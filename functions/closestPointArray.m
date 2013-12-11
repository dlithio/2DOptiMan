function myClosestPointArray = closestPointArray(u,pointsUsed,timeStepMax)

usize = size(u);
myClosestPointArray = zeros(usize(2),usize(3));

for timeStep = 1:(timeStepMax-1)
    for pointNum = 1:pointsUsed(timeStep)
        point = u(:,pointNum,timeStep);
        nextCurve = u(:,1:pointsUsed(timeStep+1),timeStep+1);
        diffMat = nextCurve - repmat(point,1,pointsUsed(timeStep+1));
        distanceNonNormal = (sum(diffMat .^ 2)) .^ (.5);
        [minDist minDistIndex] = min(distanceNonNormal);
        myMinPoint = minDistIndex(1);
        myClosestPointArray(pointNum,timeStep) = myMinPoint;
    end
end

        