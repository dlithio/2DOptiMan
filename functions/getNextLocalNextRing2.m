function nextLocalNextRing = getNextLocalNextRing2(local,timestep,pointsUsed2,index,closestPoints)
    if local == pointsUsed2(timestep)
        nextLocalNextRing = closestPoints(1,timestep);
    else
        nextLocalNextRing = closestPoints(local+1,timestep);
    end
end