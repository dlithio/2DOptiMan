function fOriginal = myVectorField(point)

%Lorenz System
%These first 3 lines are the actual Lorenz Equations
fOriginal(1)=10*(point(2)-point(1));
fOriginal(2)=28*point(1)-point(2)-point(1) .* point(3);
fOriginal(3)=point(1).*point(2) - 8/3 * point(3);
%In order to find the stable manifold, we reverse time. This program
%automatically find the unstable manifold.
fOriginal(1)=-fOriginal(1);
fOriginal(2)=-fOriginal(2);
fOriginal(3)=-fOriginal(3);

% fOriginal(1) = point(1);
% fOriginal(2) = point(2);
% if (point(1) < -.5)
%     Phi=.1*(point(1)+.5)^3;
%     Phix=.3*(point(1)+.5)^2;
%     Phiy=0;
%     fOriginal(3) =Phix*fOriginal(1)+Phiy*fOriginal(2)-(curve(3)-Phi);
% else
%     fOriginal(3)=0;
% end

end

% The following should be deleted soon -- it's the original myLorenz
% function. Kept here to make sure I change everything necessary.
% function [fOriginal fixedPoint eigenVector1 eigenVector2 radius timeTotal timeStepSize] = myLorenz(curve)
% 
% fOriginal(1,:)=10*(curve(2,:)-curve(1,:));
% fOriginal(2,:)=28*curve(1,:)-curve(2,:)-curve(1,:) .* curve(3,:);
% fOriginal(3,:)=curve(1,:).*curve(2,:) - 8/3 * curve(3,:);
% fOriginal(1,:)=-fOriginal(1,:);
% fOriginal(2,:)=-fOriginal(2,:);
% fOriginal(3,:)=-fOriginal(3,:);
% fOriginal=normc(fOriginal);
% 
% fixedPoint = [ 0 0 0]';
% 
% J= [10 -10 0;(-28-0) 1 0; -0 -0 8/3];
% [v,d] = eig(J);
% eigenVector1 = v(:,1); % v_1 of the Jacobian of F at the fixedPoint
% eigenVector2 = v(:,3); % v_2 of the Jacobian of F at the fixedPoint
% radius = 3; %How close initial points are to fixed point
% timeTotal = 90; %How long the system is evolved for
% timeStepSize = .1;
% 
% end

% The following should be deleted soon -- it's the original myDali
% function.
% function [fOriginal fixedPoint eigenVector1 eigenVector2 radius timeTotal timeStepSize] = myDali(curve)
% 
% for point=1:length(curve)
%         fOriginal(1,point) = curve(1,point);
%         fOriginal(2,point) = curve(2,point);
%         if (curve(1,point) < -.5)
%             Phi=.1*(curve(1,point)+.5)^3;
%             Phix=.3*(curve(1,point)+.5)^2;
%             Phiy=0;
%             fOriginal(3,point) =Phix*fOriginal(1,point)+Phiy*fOriginal(2,point)-(curve(3,point)-Phi);
%         else
%             fOriginal(3,point)=0;
%         end
% end
% fOriginal=normc(fOriginal);
% 
% fixedPoint = [ 0 0 0]'; % F(fixedPoint) =0 
% eigenVector1 = [ 1 0 0 ]'; % v_1 of the Jacobian of F at the fixedPoint
% eigenVector2 = [ 0 1 0 ]'; % v_2 of the Jacobian of F at the fixedPoint
% radius = .4; %How close initial points are to fixed point
% timeTotal = 4; %How long the system is evolved for
% timeStepSize = .1;
% 
% 

% The following should be deleted soon -- it's the original mySundial
% function
% function [fOriginal fixedPoint eigenVector1 eigenVector2 radius timeTotal timeStepSize] = mySunDial(curve)
% 
% for point=1:length(curve)
%     x=curve(1,point);
%     y=curve(2,point);
%     z=curve(3,point);
%         fOriginal(1,point) = curve(1,point)-.1*curve(2,point);
%         fOriginal(2,point) = .1*curve(1,point)+curve(2,point);
%         radius = sqrt(x^2+y^2);
%         theta = atan(y/x);
%         if abs(theta) < pi/20 & x>0
%             Phi=radius^2*(cos(20*theta)+1);
%             Phir=2*radius*(cos(20*theta)+1);
%             Phith=-20*radius^2*sin(20*theta);
%         else
%             Phi=0;
%             Phir=0;
%             Phith=0;
%         end
%         fOriginal(3,point)=Phir*radius+Phith*.1-(z-Phi);
% end
% 
% fOriginal=normc(fOriginal);
% 
% fixedPoint = [ 0 0 0]'; % F(fixedPoint) =0 
% eigenVector1 = [ 1 0 0 ]'; % v_1 of the Jacobian of F at the fixedPoint
% eigenVector2 = [ 0 1 0 ]'; % v_2 of the Jacobian of F at the fixedPoint
% radius = .3; %How close initial points are to fixed point
% timeTotal = .3; %How long the system is evolved for
% timeStepSize = .001;
% 
% 
% end
