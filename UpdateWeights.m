function [w] = UpdateWeights(wei,inp,r,y)
    eta= 0.1;
    eror= OutputLayerError(r,y);
    tmp=eta*eror;
    disp('tmp');
    disp(tmp);
    tmp1=tmp*inp;
    disp('tmp1');
    w=wei+tmp1;
end

