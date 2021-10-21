%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% grid_based_image_descriptor.m
%% Code used to display a grid for image
%%
%% USAGE: imgshowgrid(img, grid, rows, columns);
%% 
%% IN:   img     - Tri-channel image (MxNx3)
%%       grid    - Grid of sub images
%%       rows    - number of rows in the grid
%%       columns - number of columns in the grid
%%
%% OUT: NONE
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function imgshowgrid(img, grid, rows, columns)
    for sp=1:rows*columns
        cg = grid(sp);
%  display subplot for all images
        tightsubplot(rows,columns,sp, 'Box', 'inner', 'Spacing', 0.001);
        imgshow(img(cg.y_start:cg.y_end,cg.x_start:cg.x_end,:))
        axis off
    end
end
