% tidy up
clear all; close all;
clc;

%% Read and treat images
tic;
A = imread('~/Downloads/i22-531109_saxs_subtracted_image_export_processed_00000.tiff');
%A = imrotate(A, 5, 'bilinear', 'crop'); % testing for different angles
%%
Colourlim = 2500; % Adjusted manually
factorResize = 0.5;
B = imresize(A, factorResize);

C = B;
C(B<0) = 0;

D = C;
D(C>Colourlim) = Colourlim;
E = imfilter(D, fspecial('disk', 3)); % filter with a disk element of radius 3
levels = multithresh(E, 5); % Otsu threshold with 5 levels
BW = E>levels(5);
BW = bwareafilt(BW, [100*factorResize inf]);
bigBW = imresize(BW, size(A), 'nearest');
%% Find angle and rotate image
regs = regionprops(bigBW);
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

rotA = imrotate(A, theta, 'bilinear', 'crop');


figure(1)
subplot(121)
imagesc(A); title('Input');
caxis([0 Colourlim]);
subplot(122)
imagesc(rotA);
title('Output');
caxis([0,Colourlim])
fprintf('Angle [DEG]: %3.2f\n', theta);
%fprintf('Time (seconds): %3.2f\n', toc);
%% Display all steps
if true
    figure(2) % image steps
    subplot(221)
    imagesc(B);
    subplot(222);
    imagesc(C);
    subplot(223);
    imagesc(D);
    subplot(224)
    imagesc(BW);
end
