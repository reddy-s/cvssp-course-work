%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% l2_norm.m
%% Code used to calculate Mahalanobis Distance
%%
%% USAGE: dist = mahalanobis(V1, V2)
%% 
%% IN:   V1           - Vector 1
%%       V2           - Vector 2
%%       eigan_values - Eigan Values
%%
%% OUT: dist - Distance measured between the two points
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function dist = mahalanobis(V1, V2, eigan_values)
    V = abs(V1 - V2);
    dist = sqrt(sum((V * V') ./ eigan_values));
end
