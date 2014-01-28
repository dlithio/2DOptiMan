% This function performs the time step for computing the manifold. 
% For the input it requires u (the values of of the manifold for a fixed t)
% and stepSize (the size of the step in time). It also requires the number
% of points and the number of variables. It automatically calls the
% function getIdealF to retreive the vector field.

function uNew = nextCurve (curve , timeStepSize, getF, myGradient,gradAcc, originalF, distanceMax,u,timeStep,index,pointsUsed,pointsInitial,feedback_factor)
    
    k1=timeStepSize*getF(curve,originalF, myGradient,gradAcc,u,timeStep,index,pointsUsed,pointsInitial,feedback_factor);
    k2=timeStepSize*getF(curve+.5*k1,originalF, myGradient,gradAcc,u,timeStep,index,pointsUsed,pointsInitial,feedback_factor);
    k3=timeStepSize*getF(curve+.5*k2,originalF, myGradient,gradAcc,u,timeStep,index,pointsUsed,pointsInitial,feedback_factor);
    k4=timeStepSize*getF(curve+k3,originalF, myGradient,gradAcc,u,timeStep,index,pointsUsed,pointsInitial,feedback_factor);

    uNew = curve+1/6*(k1+2*k2+2*k3+k4);
    

end