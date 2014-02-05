function [force] = myVectorField(point)

% Some Instructions:
% Have exactly one of the following systems uncommented, or create your own
% system in a similar style. Here are some important things to know about
% this function:
% INPUTS
% point - A vector with 3 elements, point(1), point(2), and point(3) which
%         correspond to the (x,y,z) coordinates of a point in 3 dimensional
%         space
%
% OUTPUTS
% force - a vector with 3 elements, force(1), force(2), and force(3) which
%         correspond to the magnitudes of the force in the x, y, and z
%         directions on point.


% %%%%%%%%%%%%%%%%%%%
% %Lorenz System
% %%%%%%%%%%%%%%%%%%%
% When running the program, it's recommended to choose radius = 3 and a
% time step size of .1
%%%%%%%%%%%%%%%%%%%%%
%These first 3 lines are the actual Lorenz Equations
force(1)=10*(point(2)-point(1));
force(2)=28*point(1)-point(2)-point(1) .* point(3);
force(3)=point(1).*point(2) - 8/3 * point(3);

% %%%%%%%%%%%%%%%%%%%
% % Just flat, to see what the scheme does with unequally spaced points
% %%%%%%%%%%%%%%%%%%%
% % When running the program, it's recommended to choose radius = 3 and a
% % time step size of .1
% %%%%%%%%%%%%%%%%%%%%%
% force(1)=point(1);
% force(2)=point(2);
% force(3)=-point(3);

% % %%%%%%%%%%%%%%%%%%%
% % % A Dali Manifold
% % %%%%%%%%%%%%%%%%%%%
% % When running the program, it's recommended to choose radius = .4 and a
% % time step size of .1
% %%%%%%%%%%%%%%%%%%%%%
% force(1) = point(1);
% force(2) = point(2);
% if (point(1) < -.5)
%     Phi=.1*(point(1)+.5)^3;
%     Phix=.3*(point(1)+.5)^2;
%     Phiy=0;
%     force(3) =Phix*force(1)+Phiy*force(2)-(point(3)-Phi);
% else
%     force(3)=0;
% end

end