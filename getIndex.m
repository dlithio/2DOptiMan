function newIndex = getIndex (oldIndex,badPoints)

newIndex = zeros(1,(length(oldIndex)+sum(badPoints)));

newPoint=1;
oldPoint=1;
oldIndex = [oldIndex; (oldIndex(end)+1)];

while oldPoint <= (length(oldIndex)-1)
    newIndex(newPoint) = oldIndex(oldPoint);
    if badPoints(oldPoint) == 1
        newPoint = newPoint + 1;
        interpPoint = (oldIndex(oldPoint)+oldIndex(oldPoint+1)) / 2;
        newIndex(newPoint) = interpPoint;
    end
    newPoint = newPoint + 1;
    oldPoint = oldPoint + 1;
end

end