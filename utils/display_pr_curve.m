%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% display_pr_curve.m
%% Code used to display Precision Recall Curve
%%
%% USAGE: finger_print = display_pr_curve(apFile, displayCurve);
%% 
%% IN:   apFile          - file path to where the average precision is being stored
%%       displayCurve    - boolean Display Precision-Recall Curve
%%
%% OUT: averagePrecision - Average precision of this specific run
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function averagePrecision = display_pr_curve(apFile, displayCurve)
    % Loading evaluation file
    load(apFile,'ap');
    % display precision recall curve
    if displayCurve
        plot(ap.metrics(:, 2:2), ap.metrics(:, 1:1), 'r-o');
        xlabel("Recall");
        ylabel("Precision");
    end
    averagePrecision = ap;
end

