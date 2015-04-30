clear 'all';
close 'all';

%this is the image size
SizeXImage = 150;
SizeYImage = 150;

%this is the rectangle size
XRect = 10;
YRect = 30;

%create image
Image = zeros(SizeYImage, SizeXImage);
%start values of rectangle
Sx = floor(SizeXImage/2-XRect/2);
Sy = floor(SizeYImage/2-YRect/2);
%set the rectangle
Image(Sy+1:Sy+YRect,Sx+1:Sx+XRect) = 1;

%calculate DFT (keep size of image)
Image_FFT = fft2(Image);%????????

%plot image
figure(1);
subplot(2,2,1);
imshow(Image, []);
TheTitle = sprintf('Rectangle of Size (%d x %d)', XRect, YRect);
title(char(TheTitle));

subplot(2,2,2);
%plot the DFT
imshow(abs(Image_FFT),[]);%??????
title('Fourier Transform');

subplot(2,2,3);
%use fftshift to center the DFT
imshow(abs(fftshift(Image_FFT)),[]);%???????
title('Fourier Transform (with fftshift)');

%choose the rowindex
SizeFFT = size(Image_FFT,2);
RowIndex = 1;
subplot(2,2,4);
plot(abs(fftshift(Image_FFT(RowIndex,:))), 'bo');
TheTitle = sprintf('fft of row nr. %d. (with fftshift)', RowIndex);
axis([1 SizeFFT 0 XRect*YRect]);
title(char(TheTitle));



   
