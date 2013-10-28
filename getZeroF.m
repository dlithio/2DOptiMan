%This function takes the curve for the manifold at a fixed time
%t, the number of points, and the numberOfVariables and calls the 
%function getOriginalF to return fIdeal.

function fZero = getZeroF (curve,getOriginalF)

%------------------------------------------------------
% Finds the normalized original tangent vector and its non-normalized derivative
%------------------------------------------------------
tangentVector = normc(myGradient(getSVector(curve),curve)); % The normalized tangent vector

fOriginal=getOriginalF(curve);

% Gets the dot product of the original F and T
dotProductFT=dot(fOriginal, tangentVector);

% Computes the vector by which fOriginal needs to be altered
differenceVector=-repmat(dotProductFT,3,1) .* tangentVector;
fZero=fOriginal + differenceVector;
%Normalize the vector                      
fZero = normc(fZero);

end