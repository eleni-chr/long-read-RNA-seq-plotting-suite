function plotPercentIdentity
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a plot of Percent identity histograms.

%This function requires a TXT file for each sample, containing the percent
%identity values (generated by running NanoPlot using BAM files).

%Run this function from inside the folder containing the TXT files. No
%subfolders are allowed.

%IMPORTANT: This function creates a plot for 6 samples. A lot of things are
%hardcoded so this code will need to be modified for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
%Subplot 1.
tdfread('NanoPlot-data_barcode07filtered.txt'); %load data.
clear mapQ lengths aligned_lengths readIDs aligned_quals quals
fig=figure('Position', get(0,'Screensize')); %make figure full-screen.
ax(1)=subplot(2,3,1);
h1=histogram(percentIdentity,100); %create histogram.
clear percentIdentity;
title('Wildtype 1','FontSize',16); %add plot title.
ylabel('Number of reads','FontSize',14); %add y-axis label.
xlabel('Percent identity','FontSize',14); %add x-axis label.
set(gca,'FontSize',12); %set fonstsize of axis values.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h1.FaceColor=[.5 .8 .7]; %change bar fill colour.
h1.EdgeColor=[.5 .8 .7]; %change bar outline colour.
ylim([0 450000]);

%Subplot 2.
tdfread('NanoPlot-data_barcode08filtered.txt'); %load data.
clear mapQ lengths aligned_lengths readIDs aligned_quals quals
ax(2)=subplot(2,3,2);
h2=histogram(percentIdentity,100); %create histogram.
clear percentIdentity;
title('Wildtype 2','FontSize',16); %add plot title.
ylabel('Number of reads','FontSize',14); %add y-axis label.
xlabel('Percent identity','FontSize',14); %add x-axis label.
set(gca,'FontSize',12); %set fonstsize of axis values.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h2.FaceColor=[.3 .6 .5]; %change bar fill colour.
h2.EdgeColor=[.3 .6 .5]; %change bar outline colour.
ylim([0 450000]);

%Subplot 3.
tdfread('NanoPlot-data_barcode09filtered.txt'); %load data.
clear mapQ lengths aligned_lengths readIDs aligned_quals quals
ax(3)=subplot(2,3,3);
h3=histogram(percentIdentity,100); %create histogram.
clear percentIdentity;
title('Wildtype 3','FontSize',16); %add plot title.
ylabel('Number of reads','FontSize',14); %add y-axis label.
xlabel('Percent identity','FontSize',14); %add x-axis label.
set(gca,'FontSize',12); %set fonstsize of axis values.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h3.FaceColor=[.1 .4 .3]; %change bar fill colour.
h3.EdgeColor=[.1 .4 .3]; %change bar outline colour.
ylim([0 450000]);

%Subplot 4.
tdfread('NanoPlot-data_barcode10filtered.txt'); %load data.
clear mapQ lengths aligned_lengths readIDs aligned_quals quals
ax(4)=subplot(2,3,4);
h4=histogram(percentIdentity,100); %create histogram.
clear percentIdentity;
title('Mutant 1','FontSize',16); %add plot title.
ylabel('Number of reads','FontSize',14); %add y-axis label.
xlabel('Percent identity','FontSize',14); %add x-axis label.
set(gca,'FontSize',12); %set fonstsize of axis values.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h4.FaceColor=[.8 .5 .7]; %change bar fill colour.
h4.EdgeColor=[.8 .5 .7]; %change bar outline colour.
ylim([0 450000]);

%Subplot 5.
tdfread('NanoPlot-data_barcode11filtered.txt'); %load data.
clear mapQ lengths aligned_lengths readIDs aligned_quals quals
ax(5)=subplot(2,3,5);
h5=histogram(percentIdentity,100); %create histogram.
clear percentIdentity;
title('Mutant 2','FontSize',16); %add plot title.
ylabel('Number of reads','FontSize',14); %add y-axis label.
xlabel('Percent identity','FontSize',14); %add x-axis label.
set(gca,'FontSize',12); %set fonstsize of axis values.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h5.FaceColor=[.6 .3 .5]; %change bar fill colour.
h5.EdgeColor=[.6 .3 .5]; %change bar outline colour.
ylim([0 450000]);

%Subplot 6.
tdfread('NanoPlot-data_barcode12filtered.txt'); %load data.
clear mapQ lengths aligned_lengths readIDs aligned_quals quals
ax(6)=subplot(2,3,6);
h6=histogram(percentIdentity,100); %create histogram.
clear percentIdentity;
title('Mutant 3','FontSize',16); %add plot title.
ylabel('Number of reads','FontSize',14); %add y-axis label.
xlabel('Percent identity','FontSize',14); %add x-axis label.
set(gca,'FontSize',12); %set fonstsize of axis values.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h6.FaceColor=[.4 .1 .3]; %change bar fill colour.
h6.EdgeColor=[.4 .1 .3]; %change bar outline colour.
ylim([0 450000]);

linkaxes(ax,'xy'); %link x-axis and y-axis limits of all subplots.

%Save plot.
savefig(fig,'PercentIdentity'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'PercentIdentity.svg'); %save figure as an SVG file.
close
clear
end