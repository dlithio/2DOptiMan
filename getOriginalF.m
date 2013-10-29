function originalF = getOriginalF (curve)
    
for point=1:length(curve)
    originalF(1) = myVectorField(1,point);
    originalF(2) = myVectorField(2,point);
    originalF(3) = myVectorField(3,point);
end

end