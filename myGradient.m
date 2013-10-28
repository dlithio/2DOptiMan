function tangentVector = myGradient(s,u)
% Finds the 3 dimensional gradient of a set of points. The set of points
% should be dimenstions (3) x (points). Returns tangentVector, which is the
% same dimension

[r c] = size(u);
tangentVector = zeros(r,c);

extra = 2;
uBig = repmat(u,1,3);
% uBigMinus6 = [uBig(:,end-5:end) uBig(:,1:end-6)];
% uBigMinus5 = [uBig(:,end-4:end) uBig(:,1:end-5)];
%uBigMinus4 = [uBig(:,end-3:end) uBig(:,1:end-4)];
%uBigMinus3 = [uBig(:,end-2:end) uBig(:,1:end-3)];
uBigMinus2 = [uBig(:,end-1:end) uBig(:,1:end-2)];
uBigMinus1 = [uBig(:,end) uBig(:,1:end-1)];
uBigPlus1 = [uBig(:,2:end) uBig(:,1)];
uBigPlus2 = [uBig(:,3:end) uBig(:,1:2)];
%uBigPlus3 = [uBig(:,4:end) uBig(:,1:3)];
%uBigPlus4 = [uBig(:,5:end) uBig(:,1:4)];
% uBigPlus5 = [uBig(:,6:end) uBig(:,1:5)];
% uBigPlus6 = [uBig(:,7:end) uBig(:,1:6)];

sBig = [s s+2*pi s+4*pi];

for point = length(s)+1:2*length(s)
    myWeights = weights(sBig(point),sBig(point-extra:point+extra),1);
    myWeights = myWeights(2,:);
    tangentVector(:,point-length(s)) = ...
        myWeights(1) * uBigMinus2(:,point) + ...
        myWeights(2) * uBigMinus1(:,point) + ...
        myWeights(3) * uBig(:,point) + ...
        myWeights(4) * uBigPlus1(:,point) + ...
        myWeights(5) * uBigPlus2(:,point);
end

end
