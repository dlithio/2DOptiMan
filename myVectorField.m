function [fOriginal fixedPointGuess radius timeTotal timeStepSize] = myVectorField(point)

%%%%%%%%%%%%%%%%%%%
%Lorenz System
%%%%%%%%%%%%%%%%%%%
% %These first 3 lines are the actual Lorenz Equations
% fOriginal(1)=10*(point(2)-point(1));
% fOriginal(2)=28*point(1)-point(2)-point(1) .* point(3);
% fOriginal(3)=point(1).*point(2) - 8/3 * point(3);
% %In order to find the stable manifold, we reverse time. This program
% %automatically finds the unstable manifold.
% fOriginal(1)=-fOriginal(1);
% fOriginal(2)=-fOriginal(2);
% fOriginal(3)=-fOriginal(3);
% %The following constants need to be specified for any vectorfield
% fixedPointGuess = [0 0 0]; %Can be the exact fixed point, but doesn't need to be
% radius = 3; %How close initial points are to the fixed point
% timeTotal = 90; %How long the system is evolved for
% timeStepSize = .5; %How far we go in each timeStep

%%%%%%%%%%%%%%%%%%%
% A Dali Manifold
%%%%%%%%%%%%%%%%%%%
fOriginal(1) = point(1);
fOriginal(2) = point(2);
if (point(1) < -.5)
    Phi=.1*(point(1)+.5)^3;
    Phix=.3*(point(1)+.5)^2;
    Phiy=0;
    fOriginal(3) =Phix*fOriginal(1)+Phiy*fOriginal(2)-(point(3)-Phi);
else
    fOriginal(3)=0;
end
%%%%%%%%%%%%%%%%
fixedPointGuess = [0 0 0]; % F(fixedPoint) =0 
radius = .4; %How close initial points are to fixed point
timeTotal = 4; %How long the system is evolved for
timeStepSize = .1;
%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%
% A Sundial Manifold
%%%%%%%%%%%%%%%%%%%
% x=point(1);
% y=point(2);
% z=point(3);
% fOriginal(1) = point(1)-.1*point(2);
% fOriginal(2) = .1*point(1)+point(2);
% radius = sqrt(x^2+y^2);
% theta = atan(y/x);
% if abs(theta) < pi/20 & x>0
%     Phi=radius^2*(cos(20*theta)+1);
%     Phir=2*radius*(cos(20*theta)+1);
%     Phith=-20*radius^2*sin(20*theta);
% else
%     Phi=0;
%     Phir=0;
%     Phith=0;
% end
% fOriginal(3)=Phir*radius+Phith*.1-(z-Phi);
% %%%%%%%%%%%%%%%%
% fixedPointGuess = [ 0 0 0]; % F(fixedPoint) =0 
% radius = .3; %How close initial points are to fixed point
% timeTotal = .3; %How long the system is evolved for
% timeStepSize = .001;
% %%%%%%%%%%%%%%%%

end