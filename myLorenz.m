function [fOriginal fixedPoint eigenVector1 eigenVector2 radius timeTotal timeStepSize] = myLorenz(curve)

fOriginal(1,:)=10*(curve(2,:)-curve(1,:));
fOriginal(2,:)=28*curve(1,:)-curve(2,:)-curve(1,:) .* curve(3,:);
fOriginal(3,:)=curve(1,:).*curve(2,:) - 8/3 * curve(3,:);
fOriginal(1,:)=-fOriginal(1,:);
fOriginal(2,:)=-fOriginal(2,:);
fOriginal(3,:)=-fOriginal(3,:);
fOriginal=normc(fOriginal);

fixedPoint = [ 0 0 0]';

J= [10 -10 0;(-28-0) 1 0; -0 -0 8/3];
[v,d]=eig(J);
eigenVector1 = v(:,1); % v_1 of the Jacobian of F at the fixedPoint
eigenVector2 = v(:,3); % v_2 of the Jacobian of F at the fixedPoint
radius = 3; %How close initial points are to fixed point
timeTotal = 90; %How long the system is evolved for
timeStepSize = .1;

end

