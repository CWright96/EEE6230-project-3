net = vgg16();

imgDir = 'H:\My Documents\GitHub\EEE6230-project-3\ISIC_TrainingData\Images';
labelDir = 'H:\My Documents\GitHub\EEE6230-project-3\ISIC_TrainingData\Labels';
%%Resize training images
% imgfiles = dir(fullfile(imgDir,'*.jpg'));
% labfiles = dir(fullfile(labelDir,'*.png'));
% NumberOfFiles = size(imgfiles);
% for i=1:NumberOfFiles(1)
%     ImPath = fullfile(imgDir,imgfiles(i).name());
%     disp(ImPath)
%     NewIM = imresize(imread(ImPath), [360 480]);
%     imwrite(NewIM,ImPath);
% end
% for i=1:NumberOfFiles(1)
%     ImPath = fullfile(labelDir,labfiles(i).name());
%     disp(ImPath)
%     NewIM = imresize(imread(ImPath), [360 480]);
%     imwrite(NewIM,ImPath);
% end

%set up the dataStores
imds = imageDatastore(imgDir);
%set yp the labels for the ground truth masks
LabelIDs = [0,255];
Classes = ["Skin", "Lesion"];
pxds = pixelLabelDatastore(labelDir,Classes,LabelIDs);

%start of the network
imSize = [360 480 3];
numClasses = numel(Classes);

%graph of the original unchanged network
lGraph = segnetLayers(imSize,numClasses,'vgg16');
lGraph.Layers;
fig1 = figure('Position',[100,100,1000,1100]);
subplot(1,2,1);
plot(lGraph);
subplot(1,2,1);
plot(lGraph);
axis off;
axis tight;
title('Complete Layer Graph');
subplot(1,2,2);
plot(lGraph); 
xlim([2.862 3.200]);
ylim([-0.9 10.9]);
axis off;
title('Last Nine Layers');

%Transfer Learning
fig2 = figure('Position',[100,100,1000,1100]);
subplot(1,2,1);
plot(lGraph); 
xlim([2.862 3.200]);
ylim([-0.9 10.9]);
axis off;
title('Original Last Nine Layers');

lGraph = removeLayers(lGraph,{'pixelLabels'});
imFreq = tbl.PixelCount ./tbl.ImagePixelCount;
classWeights = median(imFreq) ./ imFreq;
pxLayer = pixelClassificationLayer('Name','Labels','ClassNames',tbl.Name,'ClassWeights',classWeights);

lGraph = removeLayers(lGraph,{pixelLabels});
lGraph = addLayers(lGraph, pxLayer);
lGraph = connectLayers(lGraph,'softmax','Labels');
lGraph.Layers;

subplot(1,2,2);
plot(lGraph); 
xlim([2.862 3.200]);
ylim([-0.9 10.9]);
axis off;
title('new Last Nine Layers');



