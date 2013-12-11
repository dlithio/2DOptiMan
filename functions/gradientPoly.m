function tangentVector = gradientPoly(s,u,gradAcc)
% Finds the 3 dimensional gradient of a set of points. The set of points
% should be dimenstions (3) x (points). Returns tangentVector, which is the
% same dimension

[r numpoints] = size(u);
tangentVector = zeros(r,numpoints);

extra = gradAcc;
uBig = repmat(u,1,3);
sBig = [s s+2*pi s+4*pi];

for point = 1:numpoints
    polypoints = uBig(:,(point+numpoints-extra):(point+numpoints+extra));
    spoints = sBig((point+numpoints-extra):(point+numpoints+extra));
    spoints = spoints - spoints(extra+1);
    for ndim = 1:3
        P = vander((spoints))\(polypoints(ndim,:)');
        tangentVector(ndim,point) = P(end-1);
    end
end

end