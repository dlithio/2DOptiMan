function beforeNextLocalNextRing = getBeforeNextLocalNextRing(local,timestep,pointsUsed2,index)
    beforeNextLocalNextRing = getNextLocalNextRing(local,timestep,pointsUsed2,index) - 1;
    if beforeNextLocalNextRing == 0
        beforeNextLocalNextRing = pointsUsed2(timestep+1);
end