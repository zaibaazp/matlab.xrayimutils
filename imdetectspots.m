function [imSegmentedSpots] = imdetectspots(inImage, factorResize)
% DETECT SPOT REFLECTIONS IN IMAGE.
%
% 
if nargin < 2
    factorResize = 0.5;
end
B = imresize(inImage, factorResize);

C = B;
C(B<0) = 0;

D = C;
D(C>2500) = 2500;
E = imfilter(D, fspecial('disk', 3)); % filter with a disk element of radius 3
levels = multithresh(E, 5); % Otsu threshold with 5 levels
BW = E>levels(5); % Pick highest level as threshold

BW = bwareafilt(BW, [100*factorResize inf]);
imSegmentedSpots = imresize(BW, size(inImage), 'nearest');