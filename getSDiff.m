function sDiff = getSDiff(s)

sBig = [s s+2*pi s+4*pi];
sBigMinus1 = [sBig(:,end) sBig(:,1:end-1)];
sDiffBig = sBig - sBigMinus1;
sDiff = sDiffBig(length(s)+1:2*length(s));

end
