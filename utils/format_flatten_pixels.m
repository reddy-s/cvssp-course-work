%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% format_flatten_pixels.m
%% Takes an image (gray scale / tri channel [RGB]) and flattens the pixels
%% so that it can be used as an input to Eigen_Build and Eigen_Mahalanonis
%% functions
%%
%% Usage:  format_flatten_pixels (image, channels)
%%
%% IN:  image        - The image to display, as speified above
%%      channels     - number of channels in the image
%%
%% OUT: flat         - No of channels as the input image x (Rows * Columns)
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function flat = format_flatten_pixels(img, channels)
% Takes an image (gray scale / tri channel [RGB]) and flattens the pixels
% so that it can be used as an input to Eigen_Build and Eigen_Mahalanonis
% functions
    nImg = double(img) ./ 255;
    flat = zeros(channels, size(nImg,1)*size(nImg,2));
    for c = 1:channels
        flat(c,:) = reshape(nImg(:,:,c),1,[]);
    end
end
