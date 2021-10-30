%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% rgb_hist_descriptor.m
%% Code used to create a RGB Histogram Based Image Descriptor
%%
%% USAGE: finger_print = rgb_hist_descriptor(img, q);
%% 
%% IN:   img           - Tri-channel image (MxNx3)
%%       Q             - Level of Quantization
%%
%% OUT: finger_print - Finger Print Structure
%%                     RGBHist: [3×(r*c) double]
%%                     descriptor: [array int8]
%%                     img: [inputimage double]
%%                     Q: Level of quantization
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function finger_print = rgb_hist_descriptor(img, Q)
% First, create qimg, an image where RGB are normalised in range 0 to (Q-1)
% We do this by dividing each pixel value by 256 (to give range 0 - just
% under 1) and then multiply this by Q, then drop the decimal point.
    qimg=double(img)./ 256;
    qimg=floor(qimg .* Q);
% Now, create a single integer value for each pixel that summarises the
% RGB value.  We will use this as the bin index in the histogram.
    bin = qimg(:,:,1)*Q^2 + qimg(:,:,2)*Q^1 + qimg(:,:,3);
% 'bin' is a 2D image where each 'pixel' contains an integer value in
% range 0 to Q^3-1 inclusive.
% We will now use Matlab's hist command to build a frequency histogram
% from these values.  First, we have to reshape the 2D matrix into a long
% vector of values.
    vals=reshape(bin,1,[]);
% Now we can use hist to create a histogram of Q^3 bins.
    h = histcounts(vals, Q^3);
% It is convenient to normalise the histogram, so the area under it sum
% to 1.
    h = h ./sum(h);
% populating the output finger_print with all keys in the struct
    finger_print.RGBHist = bin;
    finger_print.img = img;
    finger_print.Q = Q;
    finger_print.descriptor = h;
end
