%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% minkowski.m
%% Code used to calculate Euclidean Distance with an order of "n"
%% ref:https://www.itl.nist.gov/div898/software/dataplot/refman2/auxillar/minkdist.htm
%%
%% USAGE: dst = minkowski(V1, V2)
%% 
%% IN:   V1 - Vector 1
%%       V2 - Vector 2
%%
%% OUT: dst - Distance measured between the two points
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function dist = minkowski(V1, V2, order)
    V = abs(V1 - V2);
    orderMatrix = repmat([order], 1, size(V, 2));
    dist = sum((V .^ orderMatrix)) ^ (1/order);
end
