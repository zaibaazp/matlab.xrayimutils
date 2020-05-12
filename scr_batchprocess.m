%% Script: Batch processing
% Reading many Tiff images from a single folder
%%
tidy;

path2data = '/Users/zaibaap/Downloads/M10_522/';
filenames = dir(path2data);
filenames(1:2) = [];
filenames = {filenames.name}';

rotA = cell(length(filenames),1);
theta = zeros(length(filenames),1);

tic;
for ix = 1:length(filenames)
    fprintf('Working on file: %s\n', filenames{ix});
    A{ix} = imread(fullfile(path2data, filenames{ix}));
    [rotA{ix}, theta(ix)] = detectAngleNRotate(A{ix});
end
disp(toc)


%%
[rotIm, thetaIm] = detectAngleNRotate(A{1});
%%
figure(1)
plotSpotsImage(rotIm);