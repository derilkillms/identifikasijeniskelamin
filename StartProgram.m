clear all

FDetect = vision.CascadeObjectDetector;
disp('Gender Indentification');
filename= imgetfile();
im2= imread(filename);
BB = step(FDetect,im2);
if(isempty(BB))
    disp('Image does not contain a face');
else
   im3=imcrop(im2,BB);
   im4=imresize(rgb2gray(im3),[120 120]);
   mul= double(im4);
   
   weights= dlmread('Weights.txt');
   tmp= mul.*weights;
   s=sum(sum(tmp));
   y=Sigmite(s);
   check = Threshold(y);
   if(check==0)
       disp('Female');
   else
       disp('Male');
   end
end