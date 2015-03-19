% define parameters as struct
Params = struct();
Params.FilterType = 'Sobel';
Params.Sigma = 2;
Params.k = 0.04;
Params.Border = 10;
Params.nBest = 100;

%%% Image 0000
% load the image
ImageRaw = imread('Images/img_0000.jpg');
Image = double(ImageRaw);

% run edge detector function
result = EdgeDetector(Image, Params);

figure(1);
imshow(Image, []);
title('img\_0000.jpg');

% plot the reuslts
[rows, cols] = find(result);
for i = 1:length(rows)
    BBox = [cols(i)-5 rows(i)-5 10 10];
    rectangle('Position', BBox, 'Edgecolor', [1 0 0], 'Curvature',[1,1]);
end

%%% Image 0001
% load the image
ImageRaw = imread('Images/img_0001.jpg');
Image = double(ImageRaw);

% run edge detector function
result = EdgeDetector(Image, Params);

figure(2);
imshow(Image, []);
title('img\_0001.jpg');

% plot the reuslts
[rows, cols] = find(result);
for i = 1:length(rows)
    BBox = [cols(i)-5 rows(i)-5 10 10];
    rectangle('Position', BBox, 'Edgecolor', [1 0 0], 'Curvature',[1,1]);
end

%%% Image 0002
% load the image
ImageRaw = imread('Images/img_0002.jpg');
Image = double(ImageRaw);

% run edge detector function
result = EdgeDetector(Image, Params);

figure(3);
imshow(Image, []);
title('img\_0002.jpg');

% plot the reuslts
[rows, cols] = find(result);
for i = 1:length(rows)
    BBox = [cols(i)-5 rows(i)-5 10 10];
    rectangle('Position', BBox, 'Edgecolor', [1 0 0], 'Curvature',[1,1]);
end

%%% Image 0003
% load the image
ImageRaw = imread('Images/img_0003.jpg');
Image = double(ImageRaw);

% run edge detector function
result = EdgeDetector(Image, Params);

figure(4);
imshow(Image, []);
title('img\_0003.jpg');

% plot the reuslts
[rows, cols] = find(result);
for i = 1:length(rows)
    BBox = [cols(i)-5 rows(i)-5 10 10];
    rectangle('Position', BBox, 'Edgecolor', [1 0 0], 'Curvature',[1,1]);
end

