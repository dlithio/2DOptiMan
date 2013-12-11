function errors = findError(u,timeStep,index,pointsUsed,pointsInitial)

myIndexValues = (index(1:pointsUsed(timeStep),timeStep)-index(1,timeStep))/pointsInitial;
mySValues = getSVector(u(:,1:pointsUsed(timeStep),timeStep))'/(2*pi);

errors = myIndexValues - mySValues;
