function beforeNextLocalNextRing = getBeforeNextLocalNextRing2(local,timestep,pointsUsed2,index,closestPoints)
    beforeNextLocalNextRing = getNextLocalNextRing2(local,timestep,pointsUsed2,index,closestPoints) - 1;
    if beforeNextLocalNextRing == 0
        beforeNextLocalNextRing = pointsUsed2(timestep+1);
end