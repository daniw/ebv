clear 'all'
close 'all'

%read image
Image = imread('../ex1/London.png');
%transform to double to once and for all
Image = double(Image);

%plot the image
figure(1);
subplot(2,2,1);
imshow(uint8(Image));
title('Original');

%choose the filters
Sobel = 1;
if Sobel == 1
    DX = fspecial('sobel')';
    DY = fspecial('sobel');
else
    DX = fspecial('prewitt')';
    DY = fspecial('prewitt');
end

%apply the DX and DY filter
ImageDx = imfilter(Image, DX);
ImageDy = imfilter(Image, DY);

%calculate the norm of the derviative
ImageDr = sqrt(ImageDx.*ImageDx+ImageDy.*ImageDy);
%plot it
subplot(2,2,2);
imshow(ImageDr, []);
title('dI/dr');

Threshold = 40;
%apply a certain threshold ????????
EdgeImage = ImageDr > Threshold;
%plot it
subplot(2,2,3);
imshow(EdgeImage, []);
Title = sprintf('Edge Image using Threshold: %d', Threshold);
title(char(Title));


Threshold = 60;
%apply a certain threshold ????????
EdgeImage = ImageDr > Threshold;
%plot it
subplot(2,2,4);
imshow(EdgeImage, []);
Title = sprintf('Edge Image using Threshold: %d', Threshold);
title(char(Title));


