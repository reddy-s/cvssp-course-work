%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% feature_descriptor.m
%% Code used to describe a feature extracted by a keypoint detector
%%
%% USAGE: finger_print = feature_descriptor(img, descriptor);
%% 
%% IN:   imgLocation - image with Tri-channel (MxNx3)
%%
%% OUT: finger_print - Finger Print Structure
%%                     detector: [Struct] Harris / SIFT detector
%%                     descriptors: [array double]
%%                     img: [inputimage]
%%                     descriptorUsed: Descriptor used to encode
%%                     features: features returned by the descriptor
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function finger_print = feature_descriptor(img)
%   detect keypoints using harris corner detector
    features = harris_corner_detector(img, 50, true);
    keyPoints = features.local_maxima;
    imeta = features.imeta;
    featureDescriptors = [];
    for i=1:length(keyPoints.xpos)
        x = keyPoints.xpos(i);
        y = keyPoints.ypos(i);
%       check if window fits in the image, else continue
        if x-30 < 1 || x+30 > imeta.width || y-30 < 1 || y+30 > imeta.height
            continue;
        end
        window = img(y-30:y+30, x-30:x+30, :);
%       change to which ever descriptor you want to use here
        localDescriptor = rgb_hist_descriptor(window, 4);
        featureDescriptors = [featureDescriptors; localDescriptor];
    end
    
    finger_print.descriptor = featureDescriptors;
    finger_print.img = img;
    finger_print.descriptorUsed = 'rgb_hist_descriptor';
    finger_print.features = features;
    finger_print.detector = 'Harris Corner Detector';
end
