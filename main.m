%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% User Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All user specified options are in myVectorField.m. Look at
% the files there. Then run the file here (according to the 
% instructions on http://dlithio.github.io/2DOptiMan/).

clc; %Clears the workspace so you can see what's new
clear; %Erases the variables so you know what's new
try
    % If the current working directory contains main.m, this runs options.m
    % and then adds the necessary functions to the path if they're not
    % there yet
    contants_file = fullfile(pwd,'constants_file.m');
    run(contants_file)
    if  exist('getEigenVectors') == 0
        my_new_folder = fullfile(pwd,'functions');
        path(path,my_new_folder);
    end
    if  exist('options_skip') == 0
        path(path,pwd);
        options_file = fullfile(pwd,'options.m');
        run(options_file)
    else
        if options_skip ~= 1
            path(path,pwd);
            options_file = fullfile(pwd,'options.m');
            run(options_file)
        end
    end
catch
    % If the current working directoy does not contain main.m, it makes the
    % user locate it and then changes the current working directory. It
    % also adds the necessary functions if they're not there.
    wait_for_me = input('MATLAB was unable to find the original download folder. \n Please press any key and then use the file dialog to locate main.m yourself. \n','s');
    try
        [FileName,PathName,FilterIndex] = uigetfile('main.m','Locate main.m in the original download folder','main.m');
        cd(PathName);
        contants_file = fullfile(pwd,'constants_file.m');
        run(contants_file)
        if  exist('getEigenVectors') == 0
            my_new_folder = fullfile(pwd,'functions');
            path(path,my_new_folder);
        end
        if  exist('options_skip') == 0
            path(path,pwd);
            options_file = fullfile(pwd,'options.m');
            run(options_file)
        else
            if options_skip ~= 1
                path(path,pwd);
                options_file = fullfile(pwd,'options.m');
                run(options_file)
            end
        end
    catch
        % Final error catch. Most likely to exectute if user is in command
        % line mode and did not start matlab in the proper folder.
        error('MATLAB was unable to launch the file selection menu. \n Please launch matlab from the folder that containts main.m \n and retry this process.');
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Set the fixed point and Eigenvectors (don't change any of this)
[eigenVector1 eigenVector2 eigenValue1 eigenValue2 field_multiplier] = getEigenVectors(@myVectorField,fixedPoint);

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
for point = 1:(pointsInitial) %This loop sets in initial values for the manifold
    u(:,point,1) = fixedPoint ...
                 + eigenValue1*sin((point-1)/pointsInitial*2*pi)*eigenVector1 ...
                 + eigenValue2*cos((point-1)/pointsInitial*2*pi)*eigenVector2;
end
pointsUsed(1) = pointsInitial; %Sets the number of points that are being used
index(1:pointsUsed(1),1) = 1:pointsUsed(1);
maxDistance=maxDistancePercentage*...
            mean(getDistance(u(:,1:pointsUsed(1),1)));
minDistance=minDistancePercentage*...
            mean(getDistance(u(:,1:pointsUsed(1),1)));
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Program Loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
reverseStr = ''; %for the progress indicator
for timeStep = 2:timeSteps
    %Assume same number of points used (will change if it adapts)
    pointsUsed(timeStep) = pointsUsed(timeStep-1);
    %Get the new u
    u(:,1:pointsUsed(timeStep),timeStep)=nextCurve(u(:,1:pointsUsed(timeStep-1),timeStep-1)...
                                                   ,timeStepSize...
                                                   ,getNewF,myGradient,gradAcc...
                                                   ,@getOriginalF...
                                                   ,maxDistance,u,timeStep,index,pointsUsed,pointsInitial,feedback_factor,field_multiplier);
    %Assume each point has the same index (will change if it adapts), this
    %is used for plotting, need to track which point is which as the
    %manifold grows and interpolates.
    index(1:pointsUsed(timeStep),timeStep) = index(1:pointsUsed(timeStep-1),timeStep-1); 
    %Find if there are any bad points from being too far apart
	badPoints = getDistance(u(:,1:pointsUsed(timeStep),timeStep)) > maxDistance;
	if sum(badPoints) > 0
        %Note how many points we used to use
        oldPointsUsed = pointsUsed(timeStep-1);
        %We will be using more points, note that
        tempPointsUsed = pointsUsed;
        tempPointsUsed(timeStep-1)=pointsUsed(timeStep-1)+sum(badPoints);
        %Interpolate between all the bad points in the old time step
        tempOldCurve = getInterp(...
                                u(:,1:oldPointsUsed,timeStep-1)...
                                ,badPoints...
                                ,oldPointsUsed...
                                ,interpAcc...
                                );
        %Make a new index vector for our new, interpolated time step. This
        %will keep all the old points with the same index, but points that
        %are interpolated get an index that is the average of its
        %neighbors.
        tempIndex = index;
        tempIndex(1:tempPointsUsed(timeStep-1),timeStep-1) = getIndex(tempIndex(1:oldPointsUsed,timeStep-1),badPoints);
        pointsUsed(timeStep) = tempPointsUsed(timeStep-1);
        %Get new next curve
        u(:,1:pointsUsed(timeStep),timeStep)=nextCurve(tempOldCurve...
                                                   ,timeStepSize...
                                                   ,getNewF,myGradient,gradAcc...
                                                   ,@getOriginalF...
                                                   ,maxDistance,u,timeStep,tempIndex,tempPointsUsed,pointsInitial,feedback_factor,field_multiplier);
        %Record the new indexes
        index(1:pointsUsed(timeStep),timeStep) = tempIndex(1:tempPointsUsed(timeStep-1),timeStep-1);    
    end
    %Find if there are any bad points from being too close
	badPoints = getDistance(u(:,1:pointsUsed(timeStep),timeStep)) < minDistance;
	if sum(badPoints) > 0
        %Remove the bad points in the current time step
        oldCurve = u(:,1:pointsUsed(timeStep),timeStep);
        newCurve = oldCurve(:,badPoints == 0);
        u(:,1:pointsUsed(timeStep),timeStep) = padarray(newCurve,size(u(:,1:pointsUsed(timeStep),timeStep)) - size(newCurve),'post');
        %Make a new index vector for the new u with removed points
        oldIndex = index(1:pointsUsed(timeStep),timeStep);
        newIndex = oldIndex(badPoints == 0);
        index(1:pointsUsed(timeStep),timeStep) = padarray(newIndex,size(index(1:pointsUsed(timeStep),timeStep))-size(newIndex),'post');
        %We will be using less points, note that
        pointsUsed(timeStep)=pointsUsed(timeStep)-sum(badPoints);
    end
   %Print the progress
   percentDone = timeStep/timeSteps*100;
   msg = sprintf('Percent done: %3.1f', percentDone);
   fprintf([reverseStr, msg]);
   reverseStr = repmat(sprintf('\b'), 1, length(msg));
end
disp(sprintf('\n'))
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting the results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(sprintf('The manifold has been computed, we now write it to a file. \n'))

writeVTK2(pointsUsed(1:timeResolution:end),...
   index(:,1:timeResolution:end),...
   u(:,:,1:timeResolution:end),...
   filename);

disp(sprintf('Your manifold has been written to a file, use ParaView to view it.'))
