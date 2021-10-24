%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% calculate_mean_average_precision.m
%% Code used to calculate mean average precision
%%
%% USAGE: finger_print = calulcate_mean_average_precision(baseDir);
%% 
%% IN:   baseDir  - Base dir where the output for the descriptor is stored
%%
%% OUT: evaluationSummary - Evaluation summary for descriptor
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function evaluationSummary = calculate_mean_average_precision(baseDir)
%     load all average precision files
    allApFiles=dir(fullfile([baseDir,'/evaluation/*.mat']));

    apArray = [];
    for i=1:length(allApFiles)
        filePath = [allApFiles(i).folder '/' allApFiles(i).name];
        load(filePath, 'ap');
        apArray = [apArray; ap.averagePrecision]; 
    end
%     compute mean average precision
    evaluationSummary.meanAveragePrecision = sum(apArray) / length(apArray);
    evaluationSummary.numberOfQueries = length(apArray);
end

