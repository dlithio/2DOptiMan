function [eig_vec1 eig_vec2 eig_val1 eig_val2] = getEigenVectors(myVectorField,fixedPoint)

myJac = jacobianest(myVectorField,fixedPoint);
[v,d]=eig(myJac);
myNums = [];
myNumsNeg = [];

for i = 1:3
    if d(i,i) > 0;
        myNums = [myNums i];
    else
        myNumsNeg = [myNumsNeg i];
    end
end

if length(myNums) == 2
    eig_vec1 = v(:,myNums(1));
    eig_val1 = myNums(1);
    eig_vec2 = v(:,myNums(2));
    eig_val2 = myNums(2);
else
    eig_vec1 = v(:,myNumsNeg(1));
    eig_val1 = -myNumsNeg(1);
    eig_vec2 = v(:,myNumsNeg(2));
    eig_val2 = -myNumsNeg(2);
end