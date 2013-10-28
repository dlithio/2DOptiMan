function nextLocalNextRing = getNextLocalNextRing(local,timestep,pointsUsed2,index)
    nextLocalNextRing = find(index(:,timestep+1) == index(getNextLocalThisRing(local,timestep,pointsUsed2),timestep));
end