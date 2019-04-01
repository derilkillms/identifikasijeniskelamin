function [err]= OutputLayerError(r,y)
 disp('y');
 disp(y);
 disp('r');
 disp(r);
 err=(r-y)*y*(1-y);
 disp('error');
 disp(err);
end