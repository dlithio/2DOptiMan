function [fOriginal fixedPoint eigenVector1 eigenVector2 radius timeTotal timeStepSize] = myDali(curve)

for point=1:length(curve)
        fOriginal(1,point) = curve(1,point);
        fOriginal(2,point) = curve(2,point);
        if (curve(1,point) < -.5)
            Phi=.1*(curve(1,point)+.5)^3;
            Phix=.3*(curve(1,point)+.5)^2;
            Phiy=0;
            fOriginal(3,point) =Phix*fOriginal(1,point)+Phiy*fOriginal(2,point)-(curve(3,point)-Phi);
        else
            fOriginal(3,point)=0;
        end
end
fOriginal=normc(fOriginal);

fixedPoint = [ 0 0 0]'; % F(fixedPoint) =0 
eigenVector1 = [ 1 0 0 ]'; % v_1 of the Jacobian of F at the fixedPoint
eigenVector2 = [ 0 1 0 ]'; % v_2 of the Jacobian of F at the fixedPoint
radius = .4; %How close initial points are to fixed point
timeTotal = 4; %How long the system is evolved for
timeStepSize = .1;

end