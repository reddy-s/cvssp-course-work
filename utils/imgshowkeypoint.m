%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% imgshowcorner.m
%% Code used to show a corner
%%
%% USAGE: imgshowkeypoint(img, xpos, ypos);
%% 
%% IN:   img     - Tri-channel image (MxNx3)
%%       xpos    - X position of the corner
%%       ypos    - Y position of the corner
%%
%% OUT: NONE
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function imgshowkeypoint(img, xpos, ypos)
    imshow(img);
    hold on;
    plot(xpos, ypos, 'g.');
end
