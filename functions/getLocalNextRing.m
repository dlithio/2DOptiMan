function localNextRing = getLocalNextRing(local,timestep,index)
    localNextRing = find(index(:,timestep+1) == index(local,timestep));
end
