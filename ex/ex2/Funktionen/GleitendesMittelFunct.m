function [ThreshImage, DiffImage, BackGround] = GleitendesMittelFunct(ImageAct, BackGround, Params)

Offset = 127;

%estimate new background as sliding average
BackGround = Params.AvgFactor*(double(BackGround)) + (1 - Params.AvgFactor)*double(ImageAct);  %???????????????

%calcuate forground estimate
DiffImage = double(ImageAct) - double(BackGround) + Offset;
    
%calculate the threshold image
ThreshImage = abs(DiffImage - Offset) > Params.Threshold;

    
