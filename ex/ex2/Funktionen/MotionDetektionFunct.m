function [ThreshImage, DiffImage] = MotionDetektionFunct(ImageAct, ImageOld)

global Threshold

%this is the threshold value (chosen manually)
Threshold = 30;
Offset = 127;

%calcuate difference image
DiffImage = (double(ImageAct) - double(ImageOld))*0.5 + Offset;

%calculate the threshold image
ThreshImage = abs(DiffImage - Offset) > Threshold;

% cast difference image to uint8
DiffImage = uint8(DiffImage);
