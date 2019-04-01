clc;clear;close all;
 
image_folder = 'TrainingMale';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);
 
for n = 1:total_images
    full_name= fullfile(image_folder, filenames(n).name);
    our_images = logical(imread(full_name));
    our_images = bwconvhull(our_images,'objects');
    stats = regionprops(our_images,'Area','Perimeter','Eccentricity');
    area(n) = stats.Area;
    perimeter(n) = stats.Perimeter;
    metric(n) = 4*pi*area(n)/(perimeter(n).^2);
    eccentricity(n) = stats.Eccentricity;
    training = [metric;eccentricity]';
     
    group = cell(60,1);
    group(1:15,:) = {'tulang'};
    group(16:30,:) = {'apel'};
    group(31:45,:) = {'gajah'};
    group(46:60,:) = {'garpu'};
end
 
figure,
gscatter(metric',eccentricity',group,'rgbk','.',15)
legend('Tulang pelatihan','Apel pelatihan','Gajah pelatihan','Garpu pelatihan',...
    'Location','SouthWest')
grid on
 
image_folder_uji = 'data uji';
filenames_uji = dir(fullfile(image_folder_uji, '*.jpg'));
total_images_uji = numel(filenames_uji);
for n = 1:total_images_uji
    full_name_uji = fullfile(image_folder_uji, filenames_uji(n).name);
    our_images_uji = logical(imread(full_name_uji));
    our_images_uji = bwconvhull(our_images_uji,'objects');
    stats_uji = regionprops(our_images_uji,'Area','Perimeter','Eccentricity');
    area_uji(n) = stats_uji.Area;
    perimeter_uji(n) = stats_uji.Perimeter;
    metric_uji(n) = (4*pi*area_uji(n))./(perimeter_uji(n).^2);
    eccentricity_uji(n) = stats_uji.Eccentricity;
    sample = [metric_uji;eccentricity_uji]';
end
 
c = fitcknn(training, group,'NumNeighbors',1,'Standardize',1);
Class = predict(c,sample);
figure,
gscatter(metric',eccentricity',group,'rgbk','.',15)
grid on
hold on
gscatter(metric_uji',eccentricity_uji',Class,[1 1 0; 1 0 1; 0 1 1; .5 .5 .5],'x',15);
legend('Tulang pelatihan','Apel pelatihan','Gajah pelatihan','Garpu pelatihan',...
    'Tulang pengujian','Garpu pengujian','Apel pengujian','Gajah pengujian',...
    'Location','SouthWest')
hold off