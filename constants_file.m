%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Optional Configuration File
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you prefer, you can run the program using this configuration file,
% rather than selecting new options each time. To use this configuration
% file, you'll want to uncomment the line starting with "options_skip" and 
% then run main.m as you normally would have.

% options_skip=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Important Options -- these will change depending on your vector field
% (which is edited in myVectorField.m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% These are the things that you're probably going to need to change for
% each problem.

% Here you must give an exact fixed point for the vector field. You cannot
% make a guess here. The fixed point must be in the format
% [1 0 0]'
% the " ' " at the end is very important
fixedPoint = [0 0 0]';

% How far do you want to evolve the manifold?
timeTotal=90; 

% How far from the fixed point should your initial ring of points be?
radius = 3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting Options -- these will only affect the plotting of the manifold,
% they do not change its computation in any way.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot every nth geodesic. This is only for the plotting output -- it does
% not affect the computation in any way.
timeResolution = 5;

% What should the name of the manifold file be? This file should be read in
% by Paraview.
filename = 'manifold.vtk';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Accuracy options -- the defaults here will work for many problems.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% None of the options below will be used unless you uncomment the line
% mentioned in the above section. Remember -- after setting your options,
% you'll need to run main.m like you would have without using this file.

% Which tangent modification method will you use? Only uncomment one of the
% following lines below.
% % 1) @getZeroF corresponds to zero tangent
% getNewF = @getZeroF;
% 2) @getIdealF corresponds to the tangent vector that keeps the points
% % equally spaced
getNewF = @getIdealF;

% What should the initial number of points be?
pointsInitial = 2^5;

% What should the maximum number of points be? Note that there will be more
% points than the initial number of points when interpolation is used.
pointsMax=2^12;

% When should the scheme adapt? Entering 2 would mean that you allow the
% points to be twice as far as when they started
maxDistancePercentage = 4;

% When should the scheme remove points? Entering .25 would mean that you 
% allow the points to be a quarter as far as when they started
minDistancePercentage = .25;

% Select the gradient calculation method: note that only one of the
% following options should be uncommented.
% 1) This is the fastest method, good for most problems
myGradient = @gradientFast;
gradAcc = 1; 
% % 2) This method uses a custom finite difference function. If you are
% % calculating the gradient at x_0, gradAcc specifies the number of points
% % on either side of x_0 that are used in the calculation. 
% myGradient = @gradientFD;
% gradAcc = str2num(accstr);
% % 3) This method uses MATLABs built in polynomial interpolation. If you are
% % calculating the gradient at x_0, gradAcc specifies the number of points
% % on either side of x_0 that are used in the calculation. 
% myGradient = @gradientPoly;
% gradAcc = str2num(accstr);

% Select the method of interpolation. Again, only one of the following
% options should be uncommented.
% 1) Builtin MATLAB methods. Only 1 value for interpAcc should be selected
% if this is what you are using.
getInterp = @getInterpMATLAB;
interpAcc = 'spline';
% interpAcc = 'pchip'; % Piecewise Cubic Hermite
% interpAcc = 'linear';
% interpAcc = 'cubic';
% % 2) Using the custom finite difference based method. Here interpAcc is the
% % number of points on either side of where you're interpolating -- so it
% % should be an integer larger than or equal to 1.
% getInterp = @getInterpFD;
% interpAcc = 2;

% What should the length of each timestep be?
timeStepSize=.1;

% This is a legacy option will likely be removed later. Do not change.
feedback_factor=0;