clc; %Clears the workspace so you can see what's new
clear; %Erases the variables so you know what's new
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% User Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Consider the system du/dt=F(u(t)), where u(t)=(x(t),y(t),z(t)). The inputs
%below are for a fixed point of the system (a point u for which
%du/dt=F(u)=0). We also require the 2 eigenvectors of the Jacobian of F
%that correspond to negative eigenvalues. Initial radius determines how
%close our initial points are to our fixed point.

%Pick the system to use, uncomment the correct line
%getNewF = @getZeroF;
getNewF = @getIdealF;

% Lorenz System
% getOriginalF = @myLorenz;
% Sundial
getOriginalF = @mySunDial;
% %Dali
%getOriginalF = @myDali;
% %SunDial
% getOriginalF = @mySunDial;

% The user must also input the requested number of starting points and the
% maximum number of points to use throughout the process

pointsInitial = 2^8; % the starting number of points on the ring
pointsMax=2^12; % the maximum number of points to be allowed.
                       % since the scheme is adaptive, we will output an
                       % error if the desired number of points exceeds this

% These values determine when the scheme interpolates more points. The
% default is whenever two points are twice as far as the initial spacing,
% we insert more points. If you uncomment the following line, you can use
% an absolute value.

maxDistancePercentage = 1.2; %If this value is 2, it means it allows the
                           %points to get twice as far as they started
                           %before interpolating
                         
timeResolution = 4; %only for plotting. If 10, it plots every tenth time
                      %step


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Set the fixed point and Eigenvectors (don't change any of this)
[dummy fixedPoint eigenVector1 eigenVector2 radius timeTotal timeStepSize] = getOriginalF(zeros(3,3));

% Sets up the manifold storage by setting up arrays of zeros
timeSteps = ceil(timeTotal/timeStepSize)+1; %The total number of time steps to be taken
u=zeros(3,pointsMax,timeSteps); %The array for storing the manifold. The
                                %arrary has 3 dimensions - the first is for
                                %the points, the 2nd is for the 3 spacial
                                %dimentions (x,y,z), the the 3rd is for
                                %time
                                
index = zeros(pointsMax,timeSteps);

pointsUsed = zeros(timeSteps,1); %An array to keep track of how many
                                    %entries in the u array correspond to
                                    %the manifold. It will start with
                                    %pointsInitial, and will increase as
                                    %the adaptive part of the scheme
                                    %inserts more points
                                    
%Now actually set the initial values in the arrays
for point = 1:pointsInitial %This loop sets in initial values for the manifold
    u(:,point,1) = fixedPoint ...
                 + radius*sin((point-1)/pointsInitial*2*pi)*eigenVector1 ...
                 + radius*cos((point-1)/pointsInitial*2*pi)*eigenVector2;
end
pointsUsed(1) = pointsInitial; %Sets the number of points that are being used
index(1:pointsUsed(1),1) = 1:pointsUsed(1);
maxDistance=maxDistancePercentage*...
            mean(getDistance(u(:,1:pointsUsed(1),1)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Program Loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for timeStep = 2:timeSteps
    %Print the progress
    timeStep/timeSteps*100
    %Assume same number of points used (will change if it adapts)
    pointsUsed(timeStep) = pointsUsed(timeStep-1);
    %Get the new u
    u(:,1:pointsUsed(timeStep),timeStep)=nextCurve(u(:,1:pointsUsed(timeStep-1),timeStep-1)...
                                                   ,timeStepSize...
                                                   ,getNewF...
                                                   ,getOriginalF...
                                                   );
    %Assume each point has the same index (will change if it adapts), this
    %is used for plotting, need to track which point is which as the
    %manifold grows and interpolates.
    index(1:pointsUsed(timeStep),timeStep) = index(1:pointsUsed(timeStep-1),timeStep-1); 
    %Find if there are any bad points
	badPoints = getDistance(u(:,1:pointsUsed(timeStep),timeStep)) > maxDistance;
	if sum(badPoints) > 0
        %Note how many points we used to use
        oldPointsUsed = pointsUsed(timeStep-1);
        %We will be using more points, note that
        pointsUsed(timeStep-1)=pointsUsed(timeStep-1)+sum(badPoints);
        %Interpolate between all the bad points in the old time step
        u(:,1:pointsUsed(timeStep-1),timeStep-1) = getInterp(...
                                u(:,1:oldPointsUsed,timeStep-1)...
                                ,badPoints...
                                ,oldPointsUsed...
                                );
        %Make a new index vector for our new, interpolated time step. This
        %will keep all the old points with the same index, but points that
        %are interpolated get an index that is the average of its
        %neighbors.
        index(1:pointsUsed(timeStep-1),timeStep-1) = getIndex(index(1:oldPointsUsed,timeStep-1),badPoints);
        pointsUsed(timeStep) = pointsUsed(timeStep-1);
        %Get new next curve
        u(:,1:pointsUsed(timeStep),timeStep)=nextCurve(u(:,1:pointsUsed(timeStep-1),timeStep-1)...
                                                   ,timeStepSize...
                                                   ,getNewF...
                                                   ,getOriginalF...
                                                   );
        %Record the new indexes
        index(1:pointsUsed(timeStep),timeStep) = index(1:pointsUsed(timeStep-1),timeStep-1);
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting the results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
writeVTK(pointsUsed(1:timeResolution:end),...
    index(:,1:timeResolution:end),...
    u(:,:,1:timeResolution:end));