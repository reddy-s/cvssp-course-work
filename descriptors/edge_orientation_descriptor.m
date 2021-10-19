%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% edge_orientation_descriptor.m
%% Code used to create a Edge Orientation Based Image Descriptor
%%
%% USAGE: finger_print = edge_orientation_descriptor(img, rows, columns, 
%%                                                  bins, mag_threshold);
%% 
%% IN:   img           - Tri-channel image (MxNx3)
%%       rows          - number of rows in the grid
%%       columns       - number of columns in the grid
%%       bins          - number of bins in the EOH 
%%       mag_threshold - min threshold to be considered for EOH
%%
%% OUT: finger_print - Finger Print Structure
%%                     edgeOrientations: [1×(r*c*bins) double]
%%                     edgeEncode: [array double bins*(rows*columns)]
%%                     descriptor: [array int8]
%%                     img: [inputimage double]
%%                     imeta: [1×1 struct]
%%                     grid: [(r*c) struct]
%%                     rows: rows
%%                     columns: columns
%%                     bins: non of bins used for the EOH
%%                     derivedMagThreshold: Min Threshold used for EOH in %
%%                     minMag: Min Magnitude found
%%                     maxMag: Max Magnitude found
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function finger_print = edge_orientation_descriptor(img, rows, columns, ...
                                                    bins, mag_threshold)
%  Constructing image metadata setting necessary metadata
%  Comprises of - height of the image (px)
%               - width of the image (px)
%               - cell_height which gives the height of each cell
%               - cell_width which gives the width of each cell
%               - deg_per_bin which gives number of degrees per bin
    imeta.height = size(img, 1);
    imeta.width = size(img, 2);
    imeta.cell_height = ceil(size(img, 1)/rows);
    imeta.cell_width = ceil(size(img, 2)/columns);
    imeta.deg_per_bin = 360 / bins;
% initialising the meanRGBencode
    edge_encode = zeros(bins, rows*columns);
% converting image to monochrome
    grey_img = double(monochrome(img)) ./ 255;
% defining kernels for convolution process
    kx = [1 2 1; 0 0 0; -1 -2 -1];
    ky = kx';
% calculating derivatives of x and y
    dx = conv2(grey_img,kx,'same');
    dy = conv2(grey_img,ky,'same');
%  computing magnitude of the gradient
    mag = sqrt(dx.^2 + dy.^2);
    deg = rad2deg(atan(dy ./ dx));
    orientations = deg + ((deg < 0) * 360);
%  binning values based on threshold provided for magnitude
    mag_filtered = orientations .* (mag >= (max(max(mag))*mag_threshold));
    bins_mat = ceil(mag_filtered ./ imeta.deg_per_bin);
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
            
% extracting bin values from the cell
            cellvals = nonzeros(reshape(bins_mat(y_start:y_end,x_start:x_end,:),1,[]));
            h = histcounts(cellvals, bins);
% normalizing these values
            cell_encode = h ./ sum(h);
            edge_encode(:, cnt) = cell_encode';
% populating the grid values for each cell so that it can be used down
% stream
            grid(cnt).y_start = y_start;
            grid(cnt).y_end = y_end;
            grid(cnt).x_start = x_start;
            grid(cnt).x_end = x_end;
        end
    end
% populating the output finger_print with all keys in the struct
    finger_print.edgeOrientations = orientations;
    finger_print.edgeEncode = edge_encode;
    finger_print.descriptor = reshape(edge_encode,1,[]);
    finger_print.img = mag_filtered ./ max(max(mag_filtered));
    finger_print.imeta = imeta;
    finger_print.grid = grid;
    finger_print.rows = rows;
    finger_print.columns = columns;
    finger_print.bins = bins_mat;
    finger_print.derivedMagThreshold = mag_threshold * max(max(mag));
    finger_print.minMag = min(min(mag));
    finger_print.MaxMag = max(max(mag));
end
