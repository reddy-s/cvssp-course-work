%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% calculate_average_precision.m
%% Code used to calculate average precision and persist the results
%%
%% USAGE: finger_print = calculate_average_precision(dms, displayCurve, 
%%                                                        persist, baseDir);
%% 
%% IN:   dms           - distance calculated (Mx1 Struct)
%                               - distance
%                               - id
%                               - class
%                               - imgNum
%%       queryImg      - Id of the query image
%%       qClass        - class of the query image
%%       persist       - boolean to be used to control persistance
%%       baseDir       - base folder into which you want evaluation results
%%                       to go into
%%
%% OUT: None - persist file if asked to
%%                     display Precision-Recall Curve
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function calculate_average_precision(dms, queryImg, qClass, persist, baseDir)
    
    ap.sortedDistances = sortrows(dms, 1);
    ap.queryImage = queryImg;
    ap.queryClass = qClass;
    ap.metrics = zeros(size(ap.sortedDistances, 1), 3);
    ap.tqc = sum(ap.sortedDistances(:, 3:3) == ap.queryClass);
    for i=1:size(ap.sortedDistances, 1)
        qn = ap.sortedDistances(1:i, 3:3);
%         precision
        p = double(sum(qn == ap.queryClass)) / size(qn, 1);
%         recall
        rc = double(sum(qn == ap.queryClass)) / ap.tqc;
%         P(n) * rel(n) - {rel(n) = 1 if result is relevant, else 0}
        pr = p * (ap.sortedDistances(i:i, 3:3) == ap.queryClass);
        ap.metrics(i, :) = [p rc pr];
    end

    ap.averagePrecision = double(sum(ap.metrics(:, 3:3))) / ap.tqc;

    % saving results, so that we can use it to evaluate the descriptor
    if persist
        segments = [baseDir 'evaluation'];
        evaluationDir = strjoin(segments, '/');
        % create evaluation folder if not exists
        if not(exist(evaluationDir,'dir'))
            mkdir(evaluationDir);
        end

        fileName = 'ap-' + string(rand()*10e4 + rand()) + '.mat';
        segments = [evaluationDir, fileName];
        filePath = strjoin(segments, '/');

        save(filePath, 'ap');
        fprintf('Evaluation results saved to - %s\n', filePath);
    end
end

