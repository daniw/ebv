clear 'all';
close 'all';

%read image
Image = imread('..\uebung01\London.png');

%plot the image
figure(1);
subplot(2,2,1);
imshow(Image);
title('Original');

%read the image with text
ImageText = imread('London_text.png');
% ImageText = rgb2gray(ImageText);
% imwrite(ImageText, 'London_text.png', 'png');

%plot 
subplot(2,2,2);
imshow(ImageText);
title('Image + Text');

%apply a minimum filter on 5x5 square ??????
ImageMin =  ImageText;
%plot
subplot(2,2,3);
imshow(ImageMin);
title('Minimum Filter');

%apply a maximum filter on 5x5 square ???????
ImageMax =  ImageText;
%plot
subplot(2,2,4);
imshow(ImageMax);
title('Maximum Filter');

LineNumber = 245;
figure(2);hold on
plot(Image(LineNumber,:), 'bo-');
ImgTitel = sprintf('x-Wert (Zeile %d)', LineNumber);
xlabel(ImgTitel);
ylabel('Grauwert');
plot(ImageText(LineNumber,:), 'r-');
plot(ImageMin(LineNumber,:), 'g-');
plot(ImageMax(LineNumber,:), 'c-');
legend('Original', 'Image + Text', 'Minimum Filter', 'Maximum Filter');


