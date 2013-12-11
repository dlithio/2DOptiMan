function myGlobal = getGlobal(local,timestep,pointsUsed2)
    myGlobal = sum(pointsUsed2(1:timestep)) - pointsUsed2(timestep) + local - 1;
end