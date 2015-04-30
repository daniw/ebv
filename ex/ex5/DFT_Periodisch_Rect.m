clear 'all';
close 'all';

%size of image
ImgS = [256 256];
%period in x-direction
StepX = 11;
%period in y-direction
StepY = 19;

%create images
ImageX = zeros(ImgS);
ImageY = zeros(ImgS);
%lines in x-direction with period StepY
ImageY(1:StepY:end, :) = 1;
%lines in y-direction with period StepX
ImageX(:, 1:StepX:end) = 1;

%multiply x-image and y-image 
Image = ImageX.*ImageY;%???????

%plot everything
figure(1);
subplot(2,3,1);
imshow(ImageX, []);

subplot(2,3,2);
imshow(ImageY, []);

subplot(2,3,3);
imshow(Image, []);

%calculate and plot DFTs; the product of x-image and y-image will have 
%a DVF equal to the convolution of the respective x- and y-image DFTs
Image_FFTX = fft2(ImageX);
subplot(2,3,4);
imshow((abs(fftshift(Image_FFTX))), []);

Image_FFTY = fft2(ImageY);
subplot(2,3,5);
imshow((abs(fftshift(Image_FFTY))), []);


Image_FFT = fft2(Image);
subplot(2,3,6);
imshow((abs(fftshift(Image_FFT))), []);







