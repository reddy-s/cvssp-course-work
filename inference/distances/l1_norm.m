%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% l1_norm.m
%% Code used to calculate Manhatten Distance
%%
%% USAGE: dist = l1_norm(V1, V2)
%% 
%% IN:   V1 - Vector 1
%%       V2 - Vector 2
%%
%% OUT: dist - Distance measured between the two points
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function dist = l1_norm(V1, V2)
    V = abs(V1 - V2);
    dist = sum(V);
end