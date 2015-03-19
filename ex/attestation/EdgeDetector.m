function result = EdgeDetector(Image, Params)

    % 2
    if Params.FilterType == 'Sobel'
        DX = fspecial('sobel')';
    elseif Params.FilterType == 'Prewitt'
        DX = fspecial('prewitt')';
    else
        DX = [1];
    end
    DY = DX';

    ImageDx = imfilter(Image, DX);
    ImageDy = imfilter(Image, DY);

    % 3
    ImageDx2 = ImageDx.^2;
    ImageDy2 = ImageDy.^2;
    ImageDxDy = ImageDx.*ImageDy;

    % 4
    h1 = fspecial('gaussian', 6*Params.Sigma, 6*Params.Sigma);
    ImageDx2Filt = imfilter(ImageDx2, h1, 'symmetric');
    ImageDy2Filt = imfilter(ImageDy2, h1, 'symmetric');
    ImageDxDyFilt = imfilter(ImageDxDy, h1, 'symmetric');

    % 5
    Mc = (ImageDx2Filt.*ImageDy2Filt) - (ImageDxDyFilt.^2) ...
        - (Params.k).*(ImageDx2Filt + ImageDy2Filt).^2;

    % 6
    Mc(1:Params.Border,:) = 0;
    Mc(end-Params.Border+1:end,:) = 0;
    Mc(:,1:Params.Border) = 0;
    Mc(:,end-Params.Border+1:end) = 0;

    % 7
    MFmax = ordfilt2( ...
        Mc, ...
        numel(ones(2*Params.Border+1)), ...
        ones(2*Params.Border+1, 2*Params.Border+1));

    LOCmax = Mc.*(Mc == MFmax);

    % 8
    x = unique(LOCmax)';
    sorted = sort(x, 'descend');
    LOCmax = (LOCmax >= sorted(Params.nBest));

    result = LOCmax;

end
