clear all
disp('Training male data...');
list= dir('TrainingMale');
tmp= size(list);
nmb= tmp(1,1);
i=3;

while i<=nmb 
    check=0;
    w= dlmread('Weights.txt');
    FDetect = vision.CascadeObjectDetector;
    img1 = imread(strcat('TrainingMale/',list(i).name));
    BB = step(FDetect,img1);
    img2= imcrop(img1,BB);
    img3= imresize(img2,[120 120]);
    img= rgb2gray(img3);
    mul=double(img);
    
    while check==0
      w1= w.*mul;
      a=sum(sum(w1));
      y=Sigmite(a);
      check = Threshold(y);
        if(check==1)
             dlmwrite('Weights.txt',w);
        else
            w=UpdateWeights(w,mul,0.6,y+0.1);
        end
    end 
    i=i+1;
end 
disp('Training Finished!');