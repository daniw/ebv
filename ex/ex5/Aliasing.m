clear 'all';
close 'all';

% Parameter eingeben
DownSampling = 5;   % Downsampling-Faktor

% read image
Image = imread('kreise.png');

% plot it
figure(1);
imshow(Image);
title('Original Image');

% Downsampling w/o and with Antialiasing-Filter
figure(2)
%do sampling
ImageAlias = Image(1:DownSampling:end, 1:DownSampling:end);   
%plot it (may scale up)
imshow(ImageAlias, 'InitialMagnification', 100);
title('Moiree pattern due to Aliasing');
xlabel(['downsampling with N=' num2str(DownSampling)]);

%apply anti aliasing filter
Mask = fspecial('average', 10);%???????


%first apply filter
ImageDecimate = imfilter(Image,Mask);
%do sampling
ImageDecimate = ImageDecimate(1:DownSampling:end, 1:DownSampling:end);
%and plot
figure(3)
imshow(ImageDecimate, 'InitialMagnification', 100);
title('no Moiree pattern due to anti Aliasing filter');
xlabel(['downsampling with N=' num2str(DownSampling)]);

