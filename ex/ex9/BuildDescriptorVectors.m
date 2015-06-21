function [ DescriptorVectors, FeaturePointsNew, NumPointsSet ] = BuildDescriptorVectors( Image, FeaturePoints, Params )

    %used to define the gradient filters
    GradMask = struct;
    GradMask(1).Mask = [1 -1];
    GradMask(1).Name = '0°';
    GradMask(2).Mask = [2 -1; -1 0];
    GradMask(2).Name = '45°';
    GradMask(3).Mask = [1 -1]';
    GradMask(3).Name = '90°';
    GradMask(4).Mask = [-1 2; 0 -1];
    GradMask(4).Name = '135°';

    %used to define the points for construction of descriptor vector
    Level = struct;
    Level(1).Radius = 3;
    Level(1).Points = zeros(9,2);
    Level(1).NPoints = 9;
    Level(2).Radius = 5;
    Level(2).Points = zeros(8,2);
    Level(2).NPoints = 8;
    Level(3).Radius = 7;
    Level(3).Points = zeros(8,2);
    Level(3).NPoints = 8;

    for level = 1:3
       Index = 1;
       if level == 1
           Level(level).Points(Index,:) = [0 0];
           Index = Index+1;
       end
       Radius = Level(level).Radius;
       for poi = 0:7
           Level(level).Points(Index,:) = round([Radius 0]*[cosd(45*poi) sind(45*poi); -sind(45*poi) cosd(45*poi)]);
           Index = Index+1;
       end
    end

    Sx = size(Image,2);
    Sy = size(Image,1);
    
    DirImgScal = zeros(Sy, Sx, 12); %will hold the info for the 4 orientations at 3 different scales -> 4x3 = 12

    Index = 1;
    %determine the derivatives and chain the Gaussian filter
    for i = 1:4 % four orientations
        %apply the filter
        G0 = abs(imfilter(Image, GradMask(i).Mask,'symmetric'));        
        %chain Gaussian starting with level 0
        Gstart = G0;
        for j = 1:3
           %separable Gauss filter: first x-dir
           Gh = imfilter(Gstart, Params.GaussMask,'symmetric');
           %then y-dir; normalize through division by 2^15 
           % (-> sum over kernel elements ~ 1)
           Gh = imfilter(Gh, Params.GaussMask','symmetric')/Params.NormFactor;
           %input for next level
           Gstart = Gh;
           %save results
           DirImgScal(:,:,Index) = Gh(:,:);
           Index = Index+1;
        end
    end
    
    NumPoints = size(FeaturePoints,1);
    DescriptorVectors = zeros(NumPoints, 100);
    FeaturePointsNew = zeros(NumPoints, 2);
    %extract descriptors
    NumPointsSet = 0;
    for Ind=1:NumPoints 
        %row and column index
        y=FeaturePoints(Ind,1);
        x=FeaturePoints(Ind,2);
        %inside border
        DescVec = zeros(1,100);
        if (Params.Border < x && Params.Border < y && y < Params.Sy-Params.Border && x < Params.Sx-Params.Border)
            %loop over three levels
            Index = 1;
            for level = 1:3
                %construct point list
                Points = ones(Level(level).NPoints,1)*[x y]+Level(level).Points;
                for poi = 1:Level(level).NPoints
                    DescVec(Index:Index+3) = reshape(DirImgScal(Points(poi,2), Points(poi,1), level:3:end),1,4); 
                    Index = Index+4;
                end
            end
            NumPointsSet = NumPointsSet+1;
            DescriptorVectors(NumPointsSet,:) = DescVec;
            FeaturePointsNew(NumPointsSet,:) = FeaturePoints(Ind, :);
        end
    end
   DescriptorVectors = DescriptorVectors(1:NumPointsSet,:);
   FeaturePointsNew = FeaturePointsNew(1:NumPointsSet,:);
end

