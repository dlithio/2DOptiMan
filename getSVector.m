function sVector = getSVector(curve)

curveBig = [curve curve curve];
curvePlus1 = [curve(:,2:end) curve curve curve(:,1)];

difference = curveBig-curvePlus1;
difference = difference(:,length(curve)+1:2*length(curve));

distanceNonNormal = (sum(difference .^ 2)) .^ (.5);

totalLength = sum(distanceNonNormal);

sVector = [0 cumsum(distanceNonNormal(1:end-1))] / totalLength*2*pi;

end