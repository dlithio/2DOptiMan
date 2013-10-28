function [fOriginal fixedPoint eigenVector1 eigenVector2 radius timeTotal timeStepSize] = mySunDial(curve)

for point=1:length(curve)
    x=curve(1,point);
    y=curve(2,point);
    z=curve(3,point);
        fOriginal(1,point) = curve(1,point)-.1*curve(2,point);
        fOriginal(2,point) = .1*curve(1,point)+curve(2,point);
        radius = sqrt(x^2+y^2);
        theta = atan(y/x);
        if abs(theta) < pi/20 & x>0
            Phi=radius^2*(cos(20*theta)+1);
            Phir=2*radius*(cos(20*theta)+1);
            Phith=-20*radius^2*sin(20*theta);
        else
            Phi=0;
            Phir=0;
            Phith=0;
        end
        fOriginal(3,point)=Phir*radius+Phith*.1-(z-Phi);
end

fOriginal=normc(fOriginal);

fixedPoint = [ 0 0 0]'; % F(fixedPoint) =0 
eigenVector1 = [ 1 0 0 ]'; % v_1 of the Jacobian of F at the fixedPoint
eigenVector2 = [ 0 1 0 ]'; % v_2 of the Jacobian of F at the fixedPoint
radius = .3; %How close initial points are to fixed point
timeTotal = .3; %How long the system is evolved for
timeStepSize = .001;


end