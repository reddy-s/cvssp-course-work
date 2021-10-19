%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% grid_based_image_descriptor.m
%% Code used to create a Grid Based Image Descriptor
%%
%% USAGE: finger_print = grid_based_image_descriptor(img, rows, columns);
%% 
%% IN:   img - Tri-channel image (MxNx3)
%%       rows - number of rows in the grid
%%       columns - number of columns in the grid
%%
%% OUT: finger_print - Finger Print Structure
%%                     meanRGBencode: [3×(r*c) double]
%%                     descriptor: [array int8]
%%                     img: [inputimage double]
%%                     imeta: [1×1 struct]
%%                     grid: [(r*c) struct]
%%                     rows: rows
%%                     columns: columns
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function finger_print = grid_based_image_descriptor(img, rows, columns)
%  Constructing image metadata setting necessary metadata
%  Comprises of - height of the image (px)
%               - width of the image (px)
%               - cell_height which gives the height of each cell
%               - cell_width which gives the width of each cell
    imeta.height = size(img, 1);
    imeta.width = size(img, 2);
    imeta.cell_height = ceil(size(img, 1)/rows);
    imeta.cell_width = ceil(size(img, 2)/columns);
% initialising the meanRGBencode
    meanRGBencode = zeros(3, rows*columns);
% initialising counter for encoder's cell selection
    cnt = 0;
    for r=1:rows
% setting the start and end pixel values along the y axis
        y_start = 1 + ((r-1)*imeta.cell_height);
        if r==rows
            y_end = imeta.height;
        else
            y_end = r*imeta.cell_height;
        end
        
        for c=1:columns

            cnt = cnt + 1;
% setting the start and end pixel values along the x axis
            x_start = 1 + ((c-1)*imeta.cell_width);
            if c==columns
                x_end = imeta.width;
            else
                x_end = c*imeta.cell_width;
            end
% calculating the mean of R, G and B values of a grid cell
            cell = [mean(reshape(img(y_start:y_end,x_start:x_end,1),1,[]));
                    mean(reshape(img(y_start:y_end,x_start:x_end,2),1,[])); 
                    mean(reshape(img(y_start:y_end,x_start:x_end,3),1,[]))];
            meanRGBencode(:,cnt) = cell;
% populating the grid values for each cell so that it can be used down
% stream
            grid(cnt).y_start = y_start;
            grid(cnt).y_end = y_end;
            grid(cnt).x_start = x_start;
            grid(cnt).x_end = x_end;
        end
    end
% populating the output finger_print with all keys in the struct
    finger_print.meanRGBencode = meanRGBencode;
    finger_print.descriptor = ceil(reshape(meanRGBencode,1, []));
    finger_print.img = double(img) ./ 255;
    finger_print.imeta = imeta;
    finger_print.grid = grid;
    finger_print.rows = rows;
    finger_print.columns = columns;
end
