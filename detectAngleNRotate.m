function [rotatedImage, theta] = detectAngleNRotate(inImage, factorResize)
% DETECT ANGLE AND ROTATE IMAGE.
%
%

if nargin < 2
    factorResize = 0.5;
end

[bigBW] = imdetectspots(inImage, factorResize);

regs = regionprops(bigBW); % obtain region properties (area, centroid) from image

[~, whoCentre] = max([regs.Area]);
distMatrix = zeros(length(regs));
distances = zeros(length(regs),1);
for ix=1:length(regs)
    distances(ix) = norm(regs(ix).Centroid - regs(whoCentre).Centroid);
end
distances(whoCentre) = nan;
[~,closestPoints] = sort(distances);
myPointsIdx = closestPoints(1:2);
points = vertcat(regs(myPointsIdx).Centroid);
[~, sortXPosition] = sort(points(:,1));
leftpoint = points(sortXPosition(1),:);
rightpoint = points(sortXPosition(2),:);

distY = rightpoint(2)-leftpoint(2);
distX = rightpoint(1)-leftpoint(1);

theta = atand(distY/distX);
rotatedImage = imrotate(inImage, theta, 'bilinear', 'crop');