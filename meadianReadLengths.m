function meadianReadLengths
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function calculates the median and rounded mean read length in each 
%sample of sequenced reads.

%The function requires a TXT file for each sample, containing read lengths 
%either in column 2 or in column 4. The data must be tab-delimited. No 
%headers are allowed.

%Run this function from inside the folder containing the TXT files. No
%subfolders are allowed.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: The median read length and the rounded mean read length 
%for each sample is displayed in the command window.

%%
D=dir('NanoPlot*.txt'); %find files to work with.
for ii=1:length(D)
    fname=D(ii).name; %get filename of current file.
    data=readmatrix(fname); %load data.
    lengths=data(:,4); %get read lengths (column 4 if alignment was with minimap2, or column 2 if alignment was with Guppy).
    med=median(lengths); %calculate the median read length for the current sample.
    m=round(mean(lengths)); %calculate the mean read length for the current sample.
    fprintf('Sample %d: median = %d, mean (rounded) = %d\n',ii,med,m); %display results.
end
end