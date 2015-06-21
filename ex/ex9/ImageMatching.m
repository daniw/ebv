clear 'all'
close 'all'

%set of parameters 
Params = struct;
Params.GaussMask = [4 11 22 34 39 34 22 11 4];%Gaussian used for filtering
Params.NormFactor = 2^15;%normalization factor used
Params.Border = 15;%set to correct size dep. on the radius below (Level-struct)
Params.Discrepancy = 0.5;%best descriptor match must be better than n-times the second one


%read image
Image = imread('image.png'); 
if size(Image,3) == 3
	Image = rgb2gray(Image);
end

%split into two parts and convert to double once and forever
Params.Sx = size(Image,2)/2;
Params.Sy = size(Image,1);

LeftImagePart = double(Image(:,1:Params.Sx));
RightImagePart = double(Image(:,Params.Sx+1:2*Params.Sx));

%extract the feature points: left image part
FeaturePointsLeft = corner(LeftImagePart); FeaturePointsLeft = [FeaturePointsLeft(:,2) FeaturePointsLeft(:,1)];

%extract feature descriptors: left image part
[ DescriptorVectorsLeft, FeaturePointsLeft, NumPointsLeft ] = BuildDescriptorVectors(LeftImagePart, FeaturePointsLeft, Params);
   
%extract the feature points: right image part
FeaturePointsRight = corner(RightImagePart); FeaturePointsRight = [FeaturePointsRight(:,2) FeaturePointsRight(:,1)];
    
%extract feature descriptors: right image part
[ DescriptorVectorsRight, FeaturePointsRight, NumPointsRight ] = BuildDescriptorVectors(RightImagePart, FeaturePointsRight, Params);

Matches = [];
%try to match the descriptors
for Ind=1:NumPointsRight 
	%find best match
    Diffs = DescriptorVectorsLeft-ones(NumPointsLeft,1)*DescriptorVectorsRight(Ind,:);
    [Val, Indices] = sort(sum(Diffs.^2,2));
    if ~isempty(Val) && Val(1) < Params.Discrepancy*Val(2)
    	Matches = [Matches; Ind Indices(1)];                
    end
end

%plot matches
FullImage = [LeftImagePart, RightImagePart];
figure;
imshow(FullImage, []);
for Ind=1:NumPointsRight
    X=Params.Sx+FeaturePointsRight(Ind,2);Y=FeaturePointsRight(Ind,1);
    %make a cross
    line([X-2 X+2], [Y Y],'LineWidth',1,'Color',[1 0 0]);
    line([X X], [Y-2 Y+2],'LineWidth',1,'Color',[1 0 0]);
end
for Ind=1:NumPointsLeft
    X=FeaturePointsLeft(Ind,2);Y=FeaturePointsLeft(Ind,1);
    %make a cross
    line([X-2 X+2], [Y Y],'LineWidth',1,'Color',[1 0 0]);
    line([X X], [Y-2 Y+2],'LineWidth',1,'Color',[1 0 0]);
end
for Ind=1:size(Matches,1)
    X1=FeaturePointsLeft(Matches(Ind,2),2);Y1=FeaturePointsLeft(Matches(Ind,2),1);
    X2=Params.Sx+FeaturePointsRight(Matches(Ind,1),2);Y2=FeaturePointsRight(Matches(Ind,1),1);
    line([X1 X2], [Y1 Y2],'LineWidth',1,'Color',[0 0 1]);
end
title(strcat('number matches: ', num2str(size(Matches,1))));
   
