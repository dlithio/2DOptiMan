function dummy = plotVectorField(u,timestep,pointsUsed)
myring = u(:,1:pointsUsed(timestep),timestep);
tangentVector = normc(myGradient(getSVector(myring),myring,gradAcc));
%quiver3(myring(1,:),myring(2,:),myring(3,:),tangentVector(1,:),tangentVector(2,:),tangentVector(3,:))
scatter3(myring(1,:),myring(2,:),myring(3,:))



