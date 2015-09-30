% MEP EBV Daniel Winz

close all; clear; clc;

% Path for Images
Path = '../../mep/MEP_EBV_stick38/Image_';
Extension = '.png';

% Threshold read out from Image 10
BGCb  = 162;
BGCr  = 75;
BGLimitVal = 15;
REDCb = 105;
REDCr = 195;
REDLimitVal = 10;
YELCb = 83;
YELCr = 150;
YELLimitVal = 10;
STKCb = 120;
STKCr = 140;
STKLimitVal = 10;

for Index = 1:10
    FileName = strcat(Path, sprintf('%02d', Index), Extension);
    Image = imread(FileName);
    %Image = double(Image);

    figure(Index);
    imshow(uint8(Image), []);

    %transform to YCbCr space
    ImageYCbCr = rgb2ycbcr(Image);
    %extract color planes
    Y = ImageYCbCr(:,:,1);
    Cb = ImageYCbCr(:,:,2);
    Cr = ImageYCbCr(:,:,3);

    IndexImg = zeros(size(Y));
    %find the 2D indices of all pixel with distance smaller than BGLimitVal
    IndexImg = IndexImg | ( (Cb-BGCb).^2+(Cr-BGCr).^2 > BGLimitVal.^2 );

    Circles = imopen(IndexImg, ones(15, 15));
    circle_sep = ordfilt2(Circles, 1, ones(21));
    circle_sep = imopen(circle_sep, ones(13));
    Sticks = IndexImg - Circles;
    Sticks = imopen(Sticks, ones(3,7));
    Sticks = imopen(Sticks, ones(5,1));
    Sticks = imclose(Sticks, ones(13,13));

    % Better loop over all objects

    circle_sep = bwlabel(circle_sep);
    Prop = regionprops(circle_sep,'Area','Centroid','Orientation');
    for Ind = 1:length(Prop)
        Cent=Prop(Ind).Centroid;
        Area=Prop(Ind).Area;
        X=Cent(1);Y=Cent(2);
        line([X-3 X+3], [Y-3 Y+3], 'LineWidth', 2, 'Color',[0 0 1]);
        line([X+3 X-3], [Y-3 Y+3], 'LineWidth', 2, 'Color',[0 0 1]);
    end

    Sticks = bwlabel(Sticks);
    Prop = regionprops(Sticks,'Area','Centroid','Orientation');
    for Ind = 1:length(Prop)
        Cent=Prop(Ind).Centroid;
        Area=Prop(Ind).Area;
        X=Cent(1);Y=Cent(2);
        line([X-3 X+3], [Y-3 Y+3], 'LineWidth', 2, 'Color',[0 1 0]);
        line([X+3 X-3], [Y-3 Y+3], 'LineWidth', 2, 'Color',[0 1 0]);
        if abs(Prop(Ind).Orientation) > 13
            Ang = Prop(Ind).Orientation;
            Cent=Prop(Ind).Centroid;
            X = Cent(1);
            Y = Cent(2);
            z0 = (X + i*Y) - 60*exp(-i*Ang*pi/180);
            z1 = (X + i*Y) + 60*exp(-i*Ang*pi/180);
            line([real(z0) real(z1)], [imag(z0) imag(z1)], 'LineWidth', 2, 'Color', [1 0 0]);
        end
    end


    Foreground(:,:,1) = double(Image(:,:,1)) .* double(IndexImg);
    Foreground(:,:,2) = double(Image(:,:,2)) .* double(IndexImg);
    Foreground(:,:,3) = double(Image(:,:,3)) .* double(IndexImg);
    ForegroundYCbCr = rgb2ycbcr(Foreground);

    IndexImgRed = zeros(size(Y));
    %find the 2D indices of all pixel with distance smaller than BGLimitVal
    IndexImgRed = IndexImgRed | ( (Cb-REDCb).^2+(Cr-REDCr).^2 < REDLimitVal.^2 );

    IndexImgYel = zeros(size(Y));
    %find the 2D indices of all pixel with distance smaller than BGLimitVal
    IndexImgYel = IndexImgYel | ( (Cb-YELCb).^2+(Cr-YELCr).^2 < YELLimitVal.^2 );


    IndexImgStk = zeros(size(Y));
    %find the 2D indices of all pixel with distance smaller than BGLimitVal
    IndexImgStk = IndexImgStk | ( (Cb-STKCb).^2+(Cr-STKCr).^2 < STKLimitVal.^2 );

    figure(99);
    subplot(3, 4, Index);
    %imshow(IndexImg, []);
    %imshow(Circles, []);
    imshow(Sticks, []);
    %imshow(circle_sep, []);
    %imshow(uint8(IndexImgRed), []);

end
