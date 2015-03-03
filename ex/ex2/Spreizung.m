clear 'all';
close 'all';
%read image
Image = imread('London_squeez.png');
 
%plot the image 
figure(1);subplot(2,2,1);
imshow(Image);
title('original image');

%plot histogram
subplot(2,2,2);
imhist(Image);
title('histogram');

%LUT for spreading gray values
minvalue = min(min(Image(:,:)));
maxvalue = max(max(Image(:,:)));
LUT_Spread = uint8([zeros(1,50),[0:2:255],255*ones(1,255-177)]);
%LUT_Spread = uint8([zeros(1,minvalue),[0:256/(maxvalue - minvalue):255],255*ones(1,255-maxvalue)]);
%LUT_Spread = uint8([zeros(1,256)]);
%for n = minvalue:maxvalue
%    LUT_Spread(n) = uint8(255.0*n/(maxvalue-minvalue))
%end
%for n = maxvalue:256
%    LUT_Spread(n) = 255;
%end

%apply LUT
ImageSpread = intlut(Image, LUT_Spread);


%plot the image and corresponding histogram
subplot(2,2,3);
imshow(ImageSpread);
title('spread image');

subplot(2,2,4);
imhist(ImageSpread);
title('histogram');

