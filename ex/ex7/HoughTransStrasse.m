%
% Hough transformation
%
clear 'all';
close 'all';

%read image
Image = imread('Strasse.png');
%plot it
figure(1);
subplot(3,1,1);
imshow(Image);
title('original image');

% Detect the edges, the result is a binary image
EdgeCanny = edge(Image, 'canny', [0 0.1], 1);
%plot it
subplot(3,1,2);
imshow(EdgeCanny, []);
title('Canny edge detection');

% Hough transformation, calculate the accumulator Hough
[Hough, Theta, Rho] = hough(EdgeCanny, 'RhoResolution', 1);
figure(2)
imshow(mat2gray(Hough));
colormap('hot');
xlabel('Theta');
ylabel('Rho')
title('Hough Accumulator');

NumPeaks = 10;
HoughPeaks = houghpeaks(Hough, NumPeaks, 'Threshold', 15, 'NHoodSize', [15 15]);%?????????????
Lines = houghlines(EdgeCanny, Theta, Rho, HoughPeaks, 'FillGap', 15, 'MinLength', 250);
figure(3);
imshow(Image);
title('original image with hough lines');
hold on;

for k = 1:length(Lines)
    XY = [Lines(k).point1; Lines(k).point2];
    line(XY(:,1),XY(:,2),'LineWidth',2,'Color','red');
    XY = (Lines(k).point1+Lines(k).point2)/2;
    TheText = sprintf('rho = %d, alpha = %d', Lines(k).rho, Lines(k).theta);
    %text(XY(1), XY(2), TheText, 'BackgroundColor',[.7 .7 .7]);
end

