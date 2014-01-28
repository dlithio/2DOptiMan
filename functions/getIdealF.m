%This function takes the curve for the manifold at a fixed time
%t, the number of points, and the numberOfVariables and calls the 
%function getOriginalF to return fIdeal.

function fIdeal = getIdealF (curve,getOriginalF,myGradient,gradAcc,u,timeStep,index,pointsUsed,pointsInitial,feedback_factor)

%------------------------------------------------------
% Finds the normalized original tangent vector and its non-normalized derivative
%------------------------------------------------------
tangentVector = normc(myGradient(getSVector(curve),curve,gradAcc)); % The normalized tangent vector
tangentDerivativeVector = myGradient(getSVector(curve),tangentVector,gradAcc); % The normalized derivative of the tangent vector
% tangentVector = normc(myGradient(0:2*pi/32:63*pi/32,curve)); % The normalized tangent vector
% tangentDerivativeVector = myGradient(0:2*pi/32:63*pi/32,tangentVector); % The normalized derivative of the tangent vector
% binormalVector = normc(cross(tangentVector,normalVector)); % We could
% compute this quantity, but we simply compute the change in the tangent
% vector and add that to the original vector at the end. The only reason we
% need the tangentDerivative is for computing phi(s,t), the coefficent to our tangent
% vector

%---------------------------------------------------
% Finds phi(s,t) so that fIdeal can be computed
%---------------------------------------------------
curveSVector=getSVector(curve);
fOriginal=getOriginalF(curve);
dotProduct=dot(fOriginal, tangentDerivativeVector);
dotProductFTsCumIntegral=cumtrapz(curveSVector,dotProduct);

% Uses the dot product to find phi(s,t) for the current t
prePhi = dotProductFTsCumIntegral ...
        -getSVector(curve)/(2*pi)*trapz([curveSVector 2*pi],[dotProduct dotProduct(1)]);
phi=prePhi-mean(prePhi);

% Gets the dot product of the original F and T
dotProductFT=dot(fOriginal, tangentVector);

% Computes the vector by which fOriginal needs to be altered
differenceVector=repmat((phi-dotProductFT),3,1) .* tangentVector;
errors = findError(u,timeStep-1,index,pointsUsed,pointsInitial);
differenceVector2=feedback_factor*repmat((-errors'),3,1) .* tangentVector;
fIdeal=fOriginal + differenceVector-differenceVector2; %Normalizing the vector at this point
                                     %would change the tangential component
                                     %(remember that it is not zero).
                                     %fOriginal is normalized, and that's
                                     %all that needs to be done
fIdeal=fIdeal;

end