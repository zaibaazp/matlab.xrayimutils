function plotSpotsImage(inImage, caxislims)
%

if nargin < 2
    caxislims = [0 2500];
end

imagesc(inImage);
caxis(caxislims);
