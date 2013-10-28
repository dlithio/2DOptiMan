function nextLocalThisRing = getNextLocalThisRing(local,timestep,pointsUsed2)
    if local == pointsUsed2(timestep)
        nextLocalThisRing = 1;
    else
        nextLocalThisRing = local + 1;
    end
end
