%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% edge_orientation_and_color_descriptor.m
%% Code used to create a Edge Orientation and Colour Based Image Descriptor
%%
%% USAGE: finger_print = edge_orientation_and_color_descriptor(img, rows, 
%%                                           columns, bins, mag_threshold);
%% 
%% IN:   img           - Tri-channel image (MxNx3)
%%       rows          - number of rows in the grid
%%       columns       - number of columns in the grid
%%       bins          - number of bins in the EOH 
%%       mag_threshold - min threshold to be considered for EOH
%%
%% OUT: finger_print - Finger Print Structure
%%                     colourDescriptor: grid_based_image_descriptor
%%                     edgeOrientationDescriptor: edge_orientation_descriptor
%%                     descriptor: [array double]
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function finger_print = edge_orientation_and_color_descriptor(img, rows, ...
    columns, bins, mag_threshold)
% calling colour and edge orientation descriptors
gd = grid_based_image_descriptor(img, rows, columns);
eod = edge_orientation_descriptor(img, rows, columns, bins, mag_threshold);
% populating the output finger_print with all keys in the struct
    finger_print.colourDescriptor = gd;
    finger_print.edgeOrientationDescriptor = eod;
    finger_print.descriptor = cat(2, gd.descriptor, eod.descriptor);
end
