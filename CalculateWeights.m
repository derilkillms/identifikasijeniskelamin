clear all;

check=1;
w= rand(120);
j="/TrainingFemale/training_img1.jpg";
FDetect = vision.CascadeObjectDetector;
I = imread(j);
BB = step(FDetect,I);
I2= imcrop(I,BB);
I3= imresize(I2,[120 120]);
img= rgb2gray(I3);
imshow(img);

while check==1
   mul=double(img);
   w1= w.*mul;
   a=sum(sum(w1));
   y=Sigmite(a);
   check = Threshold(y);
   if(check==0)
       dlmwrite('Weights.txt',w);
   else
       w=UpdateWeights(w,mul,0.4,y-0.1);
       %disp(w1-w);
   end
end