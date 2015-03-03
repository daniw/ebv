clear 'all';
close 'all';

%read image
Image = imread('London.png');

%plot the image
figure(1);
subplot(2,2,1);
imshow(Image);
title('London.png');

%get histogram values
[Count, Value] = imhist(Image);
%plot them
subplot(2,2,2);
plot(Value, Count, 'bo-');
xlabel('gray value');
ylabel('absolute frequency')


%??? relative and cumulative frequency

subplot(2,2,3);
[Sx, Sy] = size(Image);
num_px = Sx * Sy;
plot(Value, Count/num_px, 'bo-');
xlabel('gray value');
ylabel('absolute frequency')

subplot(2,2,4);
plot(Value, cumsum(Count)/num_px, 'bo-');
xlabel('gray value');
ylabel('absolute frequency')

