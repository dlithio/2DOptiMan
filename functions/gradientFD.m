function tangentVector = gradientFD(s,u,gradAcc)
% Finds the 3 dimensional gradient of a set of points. The set of points
% should be dimenstions (3) x (points). Returns tangentVector, which is the
% same dimension

[r c] = size(u);
tangentVector = zeros(r,c);

extra = gradAcc;
uBig = repmat(u,1,3);

sBig = [s s+2*pi s+4*pi];

for point = length(s)+1:2*length(s)
    myWeights = weights(sBig(point),sBig(point-extra:point+extra),1);
    myWeights = myWeights(2,:);
    for i = 1:(2*extra+1)
        weight = myWeights(i);
        shift = i - (extra+1);
        tangentVector(:,point-length(s)) = tangentVector(:,point-length(s)) +...
                                    weight*uBig(:,point+shift);
    end
end

end
