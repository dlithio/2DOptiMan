function originalF = getOriginalF (curve)

mydim = size(curve);
originalF = zeros(mydim(1),mydim(2));

for point=1:length(curve)
    vectorFieldAtPoint = myVectorField(curve(:,point));
    vectorFieldAtPoint = vectorFieldAtPoint/norm(vectorFieldAtPoint)
    originalF(1,point) = vectorFieldAtPoint(1);
    originalF(2,point) = vectorFieldAtPoint(2);
    originalF(3,point) = vectorFieldAtPoint(3);
end

end