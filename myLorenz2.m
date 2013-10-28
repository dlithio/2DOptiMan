function fOriginal = myLorenz2(c)

c=c';
fOriginal(1)=10*(c(2)-c(1));
fOriginal(2)=28*c(1)-c(2)-c(1) .* c(3);
fOriginal(3)=c(1).*c(2) - 8/3 * c(3);
fOriginal(1)=-fOriginal(1);
fOriginal(2)=-fOriginal(2);
fOriginal(3)=-fOriginal(3);
fOriginal = fOriginal';