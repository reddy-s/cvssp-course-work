%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_visualsearch.m
%% Skeleton code provided as part of the coursework assessment
%%
%% This code will load in all descriptors pre-computed (by the
%% function cvpr_computedescriptors) from the images in the MSRCv2 dataset.
%%
%% It will pick a descriptor at random and compare all other descriptors to
%% it - by calling cvpr_compare.  In doing so it will rank the images by
%% similarity to the randomly picked descriptor.  Note that initially the
%% function cvpr_compare returns a random number - you need to code it
%% so that it returns the Euclidean distance or some other distance metric
%% between the two descriptors it is passed.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = '/Users/sanred/Documents/masters/MATLAB/cwork/data';

%% Folder that holds the results...
DESCRIPTOR_FOLDER = '/Users/sanred/Documents/masters/MATLAB/cwork/output';
%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
DESCRIPTOR_SUBFOLDER='rgb_hist_descriptor';
%% Flag to weather perform PCA or not.
PCA.run = false;
%% Keep 'PCA.energy' % of energy
PCA.energy = 0.8;

%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)

ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
%     extracting class value from file name
    class = split(allfiles(filenum).name(1:end-4), "_");
    allfiles(filenum).class = str2num(class{1,1});
    allfiles(filenum).imgNum = str2num(class{2,1});
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    thesefeat=[];
    featfile=[DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    load(featfile,'F');
    ALLFILES{ctr}=imgfname_full;
    ALLFEAT=[ALLFEAT ; F];
    ctr=ctr+1;
end
%% 1.1) Perform PCA
if PCA.run
    iObs = ALLFEAT';
    fprintf('Before Performing PCA over dataset: %d Dimensions, %d Descriptors\n',...
        size(iObs, 1), size(iObs, 2));
%   Performing PCA by calling Eigan_Build, Eigan_Deflate and Eigan_Project under the hood
    [oObs, E] = Eigen_PCA(iObs, 'keepf', PCA.energy);
%   Updating the descriptor dataset to reflect the reduced dimensionality
    ALLFEAT = oObs';
    fprintf('After Performing PCA over dataset: %d Dimensions, %d Descriptors\n',...
        size(oObs, 1), size(oObs, 2));
    clear iObs oObs;
end

%% 2) Pick an image at random to be the query
NIMG=size(ALLFEAT,1);           % number of images in collection
queryimg=floor(rand()*NIMG);    % index of a random image
queryImgClass = allfiles(queryimg).class;
file_name_p = allfiles(queryimg).name;
% img=imread(ALLFILES{queryimg});
% img=img(1:2:end,1:2:end,:); % make image a quarter size
% img=img(1:81,:,:);

%% 3) Compute the distance of image to the query
dms=[];
for i=1:NIMG
    candidate=ALLFEAT(i,:);
    query=ALLFEAT(queryimg,:);
    if PCA.run
        thedst=mahalanobis(query,candidate, E.val);
    else
        thedst=l2_norm(query,candidate);
    end
    dms=[dms ; [thedst i allfiles(i).class allfiles(i).imgNum]];
end

% calculate average precision for this run
calculate_average_precision(dms, queryimg, queryImgClass, true, ...
    DESCRIPTOR_FOLDER + "/" + DESCRIPTOR_SUBFOLDER, file_name_p)

dst=sortrows(dms,1);  % sort the results

%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

SHOW=15; % Show top 15 results
dst=dst(1:SHOW,:);
outdisplay=[];
for i=1:size(dst,1)
   img=imread(ALLFILES{dst(i,2)});
   img=img(1:2:end,1:2:end,:); % make image a quarter size
   img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
   outdisplay=[outdisplay img];
end
% imgshow(outdisplay);
% imshow(outdisplay);
axis off;
