%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% harris_corner_detector.m
%% Code that implements a harris corner detector
%%
%% USAGE: finger_print = harris_corner_detector(img, topn, apply_gaussian);
%% 
%% IN:   img            - Tri-channel image (MxNx3)
%%       topn           - TopN Corners
%%       apply_gaussian - Boolean which is used to control gaussian blurr
%% 
%% OUT: finger_print - Finger Print Structure
%%                     imeta: struct
%%                     img: [input]
%%                     gimg: [monochrome double]
%%                     strength_matrix: strength of each pixel
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function features = harris_corner_detector(img, topn, apply_gaussian)
%  Constructing image metadata setting necessary metadata
%  Comprises of - height of the image (px)
%               - width of the image (px)
%               - K 
%               - window descriptor window size
    imeta.height = size(img, 1);
    imeta.width = size(img, 2);
    imeta.K = 0.01;
    imeta.window = 7;
% strength matrix initialisation
    sm = zeros(imeta.height, imeta.width);
% local maxima matrix initialisation
    lmax = zeros(imeta.height, imeta.width);
% converting image to monochrome
    grey_img = double(monochrome(img)) ./ 255;
% defining kernels for convolution process
    kx = [1 2 1; 0 0 0; -1 -2 -1];
    ky = kx';
% calculating derivatives of x and y
    dx = conv2(grey_img, kx, 'same');
    dy = conv2(grey_img, ky, 'same');
% points needed for corner detection
    dxs = dx .^ 2;
    dys = dy .^ 2;
    dxy = dx .* dy;
% a low pass gaussian filter 
    if apply_gaussian == true
        kg = fspecial('gaussian', [7 7], 2); 
        dxs = filter2(kg, dxs);
        dys = filter2(kg, dys);
        dxy = filter2(kg, dxy);
    end
% create structure tensor & calculate corner strength of the pixel
    for i = 1:imeta.height
        for j = 1:imeta.width
            st = [dxs(i, j) dxy(i, j); dxy(i, j) dys(i, j)];
            cs = det(st) - (imeta.K * (trace(st))^2);
            sm(i, j) = cs;
        end
    end
% identifying local maxima in a 3x3 matrix
    for i = 2:imeta.height-1
        for j = 2:imeta.width-1
            if sm(i, j) > sm(i-1, j-1) && sm(i, j) > sm(i-1, j) ...
                && sm(i, j) > sm(i-1, j+1) && sm(i, j) > sm(i, j-1) ... 
                && sm(i, j) > sm(i, j+1) && sm(i, j) > sm(i+1, j-1) ...
                && sm(i, j) > sm(i+1, j) && sm(i, j) > sm(i+1, j+1)
                lmax(i, j) = 1;
            end
        end
    end
% create descriptor by using the top N strongest corners
    lmaxsm = abs(sm) .* lmax;
    flat_strengths = reshape(lmaxsm, 1, []);
    [~, topNStrengths] = maxk(flat_strengths, topn);

    top_n_corners = reshape(lmax, 1, []);
    for i = 1:size(top_n_corners, 2)
        if any(topNStrengths(:) == i)
            continue
        end
        top_n_corners(1, i) = 0;
    end
    top_n_corners = reshape(top_n_corners, imeta.height, imeta.width);

    [ypos, xpos] = find(top_n_corners == 1);
    


    features.imeta = imeta;
    features.img = img;
    features.gimg = grey_img;
    features.local_maxima.topNMatrix = top_n_corners;
    features.local_maxima.xpos = xpos;
    features.local_maxima.ypos = ypos;
end
