function my_error = error_check(fixedPoint,timeTotal,radius,timeResolution,filename,getNewF,pointsInitial, ...
                           pointsMax,maxDistancePercentage,minDistancePercentage,myGradient,gradAcc, ...
                           getInterp,interpAcc,timeStepSize,feedback_factor)
% error_check.m
% The sole puprose of this file is to run through the user defined
% constants and make sure everything is inside of an acceptable range.

% Fixed Point Checks
my_error = '';
if sum(size(fixedPoint) == [1 3]) ~= 2
    my_error =strcat(my_error,'fixed point is wrong size');
end

if ((rem(timeTotal,1) ~= 0) || (timeTotal <= 0))
    my_error =strcat(my_error,'timeTotal needs to be a positive integer');
end

if ((rem(radius,1) ~= 0) || (radius <= 0))
    my_error =strcat(my_error,'radius needs to be a positive integer');
end

if ((rem(timeResolution,1) ~= 0) || (timeResolution <= 0))
    my_error =strcat(my_error,'timeResolution needs to be a positive integer');
end

if ((rem(pointsInitial,1) ~= 0) || (pointsInitial <= 0))
    my_error =strcat(my_error,'pointsInitial needs to be a positive integer');
end

if ((rem(pointsMax,1) ~= 0) || (pointsMax <= 0))
    my_error =strcat(my_error,'pointsMax needs to be a positive integer');
end

if (~(isequal(getNewF,@getIdealF)) && ~(isequal(getNewF,@getZeroF)))
    my_error =strcat(my_error,'getNewF was not set correctly');
end

if (~(isequal(getInterp,@getInterpMATLAB)) && ~(isequal(getInterp,@getInterpFD)))
    my_error =strcat(my_error,'getInterp was not set correctly');
end

if (~(isequal(myGradient,@gradientFast)) && ~(isequal(myGradient,@gradientFD)) && ~(isequal(myGradient,@gradientPoly)))
    my_error =strcat(my_error,'myGradient was not set correctly');
end

if ~(isa(class(filename),'char'))
    my_error =strcat(my_error,'filename is wrong type, it should be a string');
end

if ((maxDistancePercentage <= 1) || (minDistancePercentage <= 0) || ...
        (minDistancePercentage >= 1) || (minDistancePercentage > maxDistancePercentage))
    my_error =strcat(my_error,'maxDist needs to be greater than 1 and minDist');
    my_error =strcat(my_error,'minDist needs to be between 0 and 1 and less than maxDist');
end

if (isequal(myGradient,@gradientFast)) && (gradAcc ~= 1)
    my_error = strcat(my_error,'gradAcc should be 1 when using gradientFast');
end

if (isequal(myGradient,@gradientFD)) && ((rem(gradAcc,1) ~= 0) || (gradAcc < 1))
    my_error = strcat(my_error,'gradAcc should be integer >= 1 when using gradientFD');
end

if (isequal(myGradient,@gradientPoly)) && ((rem(gradAcc,1) ~= 0) || (gradAcc < 1))
    my_error = strcat(my_error,'gradAcc should be integer >= 1 when using gradientPoly');
end

if (isequal(getInterp,@getInterpMATLAB)) && ~(strcmp(interpAcc,'spline') || strcmp(interpAcc, 'pchip') || strcmp(interpAcc , 'linear') || strcmp(interpAcc , 'cubic'))
    my_error = strcat(my_error,'interpAcc should be spline,pchip,linear,or cubic when using getInterpMATLAB');
end

if (isequal(getInterp,@getInterpFD)) && ((rem(gradAcc,1) ~= 0) || (gradAcc < 1))
    my_error = strcat(my_error,'interpAcc should be integer >= 1 when using getInterpFD');
end

if (timeStepSize <= 0)
    my_error = strcat(my_error,'timeStepSize >= 0');
end

if (feedback_factor ~= 0)
    my_error = strcat(my_error,'feedback_factor should be = 0');
end