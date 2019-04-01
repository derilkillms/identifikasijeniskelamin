function [thres]= Threshold(sig)
if(sig<0.5)
    thres=0;
else
    thres=1;
end
end