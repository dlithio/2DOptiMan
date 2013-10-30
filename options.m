%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% User Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pick the system to use, uncomment the correct line
%getNewF = @getZeroF;
getNewF = @getIdealF;

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

maxDistancePercentage = 2; %If this value is 2, it means it allows the
                           %points to get twice as far as they started
                           %before interpolating
                         
timeResolution = 5; %only for plotting. If 10, it plots every tenth time
                      %step