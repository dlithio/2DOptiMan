function newCurve = getInterp(oldCurve,badPoints,oldPointsUsed)

newPoint=1;
oldPoint=1;
oldCurve = [oldCurve oldCurve(:,1)];
newCurve = zeros(3,(oldPointsUsed+sum(badPoints)));

while oldPoint <= (oldPointsUsed)
    newCurve(:,newPoint) = oldCurve(:,oldPoint);
    if badPoints(oldPoint) == 1
        newPoint = newPoint + 1;
        interpPoint = (oldCurve(:,oldPoint)+oldCurve(:,oldPoint+1)) / 2;
        newCurve(:,newPoint) = interpPoint;
    end
    newPoint = newPoint + 1;
    oldPoint = oldPoint + 1;
end

    