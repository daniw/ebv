clear 'all'
close 'all';

%read image
Image = imread('../ex1/London.png');
%transform to double to once and for all
Image = double(Image);

%plot the image
figure(1);
subplot(2,2,1);
imshow(uint8(Image));
title('Original');

%choose the filters %??????
Sobel = 1;
if Sobel == 1
    DX = [-1 0 1;-2 0 2;-1 0 1];
    DY = [-1 -2 -1;0 0 0;1 2 1];
else
    DX = [1];
    DY = [1];
end

%apply the DX and DY filter
ImageDx = imfilter(Image, DX);
ImageDy = imfilter(Image, DY);
%plot 
subplot(2,2,3);
imshow(ImageDx, []);
title('dI/dx');
subplot(2,2,4);
imshow(ImageDy, []);
title('dI/dy');

%edge detection
subplot(2,2,2);
imshow(sqrt((ImageDx.^2)+(ImageDy.^2)), []);
title('edge detection');


