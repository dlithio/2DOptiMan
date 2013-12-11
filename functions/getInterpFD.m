function newCurve = getInterpFD(oldCurve,badPoints,oldPointsUsed,interpAcc)

% newPoint=1;
% oldPoint=1;
% oldCurve = [oldCurve oldCurve(:,1)];
% newCurve = zeros(3,(oldPointsUsed+sum(badPoints)));
% 
% while oldPoint <= (oldPointsUsed)
%     newCurve(:,newPoint) = oldCurve(:,oldPoint);
%     if badPoints(oldPoint) == 1
%         newPoint = newPoint + 1;
%         interpPoint = (oldCurve(:,oldPoint)+oldCurve(:,oldPoint+1)) / 2;
%         newCurve(:,newPoint) = interpPoint;
%     end
%     newPoint = newPoint + 1;
%     oldPoint = oldPoint + 1;
% end
sVector = getSVector(oldCurve);
extra = interpAcc;
uBig = repmat(oldCurve,1,3);

sBig = [sVector sVector+2*pi sVector+4*pi];

newPoint=1;
oldPoint=1;
newCurve = zeros(3,(oldPointsUsed+sum(badPoints)));

while oldPoint <= (oldPointsUsed)
    newCurve(:,newPoint) = oldCurve(:,oldPoint);
    if badPoints(oldPoint) == 1
        sInterp = (sBig(oldPoint+length(sVector)) + sBig(oldPoint+length(sVector)+1))/2;
        myWeights = weights(sInterp,sBig((oldPoint+length(sVector)-extra+1):(oldPoint+length(sVector)+extra)),0);
        myWeights = myWeights(1,:);
        interpPoint = zeros(3,1);
        for i = 1:(2*extra)
            weight = myWeights(i);
            shift = i - extra;
            interpPoint = interpPoint + weight*uBig(:,oldPoint+length(sVector)+shift);
        end
        newPoint = newPoint + 1;
        newCurve(:,newPoint) = interpPoint;
    end
    newPoint = newPoint + 1;
    oldPoint = oldPoint + 1;
end