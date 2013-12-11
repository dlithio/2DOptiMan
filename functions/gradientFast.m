function tangentVector = gradientFast(s,u,gradAcc)
% Finds the 3 dimensional gradient of a set of points. The set of points
% should be dimenstions (3) x (points). Returns tangentVector, which is the
% same dimension

[r c] = size(u);
tangentVectorPre = zeros(r,c+2);

uBig = [u(:,end) u u(:,1)];
sBigPre = [s s+2*pi s+4*pi];
sBig = sBigPre(length(s):2*length(s)+1);

for ndim = 1:3
    tangentVectorPre(ndim,:) = gradient(uBig(ndim,:),sBig);
end

tangentVector = tangentVectorPre(:,2:(end-1));

end
