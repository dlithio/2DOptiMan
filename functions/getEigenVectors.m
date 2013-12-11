function [eig1 eig2] = getEigenVectors(myVectorField,fixedPoint)

myJac = jacobianest(myVectorField,fixedPoint);
[v,d]=eig(myJac);
myNums = [];

for i = 1:3
    if d(i,i) > 0;
        myNums = [myNums i];
    end
end

if length(myNums) == 2
    eig1 = v(:,myNums(1));
    eig2 = v(:,myNums(2));
else
    error('There are not 2 positive eigenvectors. Try reversing time in your vector field (make everything negative)');
end