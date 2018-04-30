%%
alex = alexnet;
layers = alex.Layers
%%
layers(23) = fullyConnectedLayer(3);
layers(25) = classificationLayer
%%
%myImages = imresize('/Users/saikrishnan/Desktop/myImages',[227,227]);
allImages = imageDatastore('myImages', 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

[trainingImages, testImages] = splitEachLabel(allImages, 0.8, 'randomize');
%%
opts = trainingOptions('sgdm', 'InitialLearnRate', 0.001, 'maxEpochs', 5, 'MiniBatchSize', 64);
myNet = trainNetwork(trainingImages, layers, opts);

%%
predictedLabels = classify(myNet, testImages);
accuracy = mean(predictedLabels == testImages.Labels)
