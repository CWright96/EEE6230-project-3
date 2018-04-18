net = vgg16();

imgDir = 'H:\My Documents\GitHub\EEE6230-project-3\ISIC_TrainingData\Images';
labelDir = 'H:\My Documents\GitHub\EEE6230-project-3\ISIC_TrainingData\Labels';
%%Resize training images

imgfiles = dir(fullfile(imgDir,'*.jpg'));
labfiles = dir(fullfile(labelDir,'*.png'));
NumberOfFiles = size(imgfiles);
for i=1:NumberOfFiles(1)
    ImPath = fullfile(imgDir,imgfiles(i).name());
    disp(ImPath)
    NewIM = imresize(imread(ImPath), [360 480]);
    imwrite(NewIM,ImPath);
end
for i=1:NumberOfFiles(1)
    ImPath = fullfile(labelDir,labfiles(i).name());
    disp(ImPath)
    NewIM = imresize(imread(ImPath), [360 480]);
    imwrite(NewIM,ImPath);
end

imds = imageDatastore(imgDir);

LabelIDs = [0,255];
Classes = ["Skin", "Lesion"];

pxds = pixelLabelDatastore(labelDir,Classes,LabelIDs);

