%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% User Input -- simply run main.m to execute these prompts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pick the system to use
str = input('Select tangent modifiction method: \n 1 for equally spaced points (default). \n 2 for zero tangent.\n','s');
if str == '2'
    getNewF = @getZeroF;
else
    getNewF = @getIdealF;
end


% The user must also input the requested number of starting points and the
% maximum number of points to use throughout the process

str = input('Enter initial number of points (default 2^5).\n','s');
if isempty(str)
    pointsInitial = 2^5; % the starting number of points on the ring
else
    pointsInitial = str2num(str);
end

str = input('Enter the maximum number of points (default 2^12).\n','s');
if isempty(str)
    pointsMax=2^12; % the maximum number of points to be allowed.
                       % since the scheme is adaptive, we will output an
                       % error if the desired number of points exceeds this
else
    pointsMax = str2num(str);
end


% These values determine when the scheme interpolates more points. The
% default is whenever two points are twice as far as the initial spacing,
% we insert more points. If you uncomment the following line, you can use
% an absolute value.

str = input('When should the scheme adapt? \n Entering 2 would mean that you allow the \n points to be twice as far \n as when they started (default 2).\n','s');
if isempty(str)
    maxDistancePercentage = 2; %If this value is 2, it means it allows the
                           %points to get twice as far as they started
                           %before interpolating
else
    maxDistancePercentage = str2num(str);
end

str = input('When should the scheme remove points? \n Entering .25 would mean that you allow the \n points to be a quarter as far \n as when they started (default .25).\n','s');
if isempty(str)
    minDistancePercentage = .25; %If this value is .25, it means it allows the
                           %points to get as close as 1/4 of the original
                           %distance before one of the points is removed
else
    minDistancePercentage = str2num(str);
end                    

str = input('Plot every nth geodesic (default 5).\n','s');
if isempty(str)
    timeResolution = 5; %only for plotting. If 10, it plots every tenth time
                      %step
else
    timeResolution = str2num(str);
end

fixedPointGuess = input('Guess the fixed point. Your guess should \n be something like "[1 2 3]" without quotes. (default [0 0 0]) \n');
if isempty(str)
    fixedPoint = fixedPointPrompt([0 0 0]);
else
    fixedPoint = fixedPointPrompt(fixedPointGuess);
end

str = input('Select the gradient calculation method: \n 1) Central difference - quick and less accurate  (default) \n 2) 5th Order FD Weights - slower and accurate \n 3) 5th order polynomial - slower and accurate. \n','s');
if isempty(str)  || str == '1'
    myGradient = @gradientFast;
    gradAcc = 1; %not used in this case but needed as a dummy variable
elseif str == '2'
    myGradient = @gradientFD;
    accstr = input('How many points should be used on each side of a point \n to find the gradient? \n (enter an integer larger than or equal to 1): \n','s');
    gradAcc = str2num(accstr);
else
    myGradient = @gradientPoly;
    accstr = input('How many points should be used on each side of a point \n to find the gradient? \n (enter an integer larger than or equal to 1): \n','s');
    gradAcc = str2num(accstr);
end

str = input('Select the interpolation method: \n 1) Matlab (default) \n 2) Manual Finite Difference. \n','s');
if str == '2'
    getInterp = @getInterpFD;
    accstr = input('How many points should be used on each side of where we want to interpolate \n (enter an integer larger than or equal to 1): \n','s');
    interpAcc = str2num(accstr);
else
    getInterp = @getInterpMATLAB;
    accstr = input('Which MATLAB inerpolation method?: \n 1) Spline (default) \n 2) Linear. \n 3) Piecewise Cubic Hermite \n 4) Cubic: \n','s');
    if isempty(accstr) || str == '1'
        interpAcc = 'spline';
    elseif accstr == '2'
        interpAcc = 'linear';
    elseif accstr == '3'
        interpAcc = 'pchip';
    else
        interpAcc = 'cubic';
    end
end                    