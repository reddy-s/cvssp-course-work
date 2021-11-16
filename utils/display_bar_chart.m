%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% display_bar_chart.m
%% Code used to show bar chart
%%
%% USAGE: display_bar_chart(x, y, xLabelText, yLabelText);
%% 
%% IN:   x          - X Values
%%       y          - Y Values
%%       xLabelText - X Label
%%       yLabelText - Y Label
%% 
%% OUT: NONE
%%
%% (c) Sangram Reddy 2021  (sd01356@surrey.co.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function display_bar_chart(x, y, xLabelText, yLabelText)
    b = bar(x, y);
    xtips = b(1).XEndPoints;
    ytips = b(1).YEndPoints;
    labels = string(b(1).YData);
    text(xtips,ytips,labels,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
    xlabel(xLabelText);
    ylabel(yLabelText);
end

