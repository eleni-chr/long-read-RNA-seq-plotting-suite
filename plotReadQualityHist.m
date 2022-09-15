function plotReadQualityHist
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a histogram of read basecall qualities before 
%filtering out low basecall quality reads. The x-axis scale is logarithmic.

%The function requires a TXT file for each sample, containing basecall
%quality scores in column 1 and read lengths in column 2. The data must be
%tab-delimited. No headers are allowed.

%Run this function from inside the folder containing the TXT files. No
%subfolders are allowed.

%IMPORTANT: This function creates a plot for 6 samples. A lot of things are
%hardcoded so this code will need to be modified for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
%Load data.
data1=readmatrix('NanoPlot-data_barcode07.txt'); %load data.
data2=readmatrix('NanoPlot-data_barcode08.txt'); %load data.
data3=readmatrix('NanoPlot-data_barcode09.txt'); %load data.
data4=readmatrix('NanoPlot-data_barcode10.txt'); %load data.
data5=readmatrix('NanoPlot-data_barcode11.txt'); %load data.
data6=readmatrix('NanoPlot-data_barcode12.txt'); %load data.

%Subplot 1.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
ax(1)=subplot(2,3,1);
h1=histogram(data1(:,1));
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Mean read basecall quality (Phred Q-score)','FontSize',12); %add x-axis label.
title('Wildtype 1'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h1.FaceColor=[.5 .8 .7]; %change bar fill colour.
h1.EdgeColor=[.5 .8 .7]; %change bar outline colour.
line([7, 7], [0 30000], 'LineWidth', 2, 'Color', 'b'); %add line showing quality cut-off.

%Subplot 2.
ax(2)=subplot(2,3,2);
h2=histogram(data2(:,1));
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Mean read basecall quality (Phred Q-score)','FontSize',12); %add x-axis label.
title('Wildtype 2'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h2.FaceColor=[.3 .6 .5]; %change bar fill colour.
h2.EdgeColor=[.3 .6 .5]; %change bar outline colour.
line([7, 7], [0 30000], 'LineWidth', 2, 'Color', 'b'); %add line showing quality cut-off.

%Subplot 3.
ax(3)=subplot(2,3,3);
h3=histogram(data3(:,1));
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Mean read basecall quality (Phred Q-score)','FontSize',12); %add x-axis label.
title('Wildtype 3'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h3.FaceColor=[.1 .4 .3]; %change bar fill colour.
h3.EdgeColor=[.1 .4 .3]; %change bar outline colour.
line([7, 7], [0 30000], 'LineWidth', 2, 'Color', 'b'); %add line showing quality cut-off.

%Subplot 4.
ax(4)=subplot(2,3,4);
h4=histogram(data4(:,1));
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Mean read basecall quality (Phred Q-score)','FontSize',12); %add x-axis label.
title('Mutant 1'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h4.FaceColor=[.8 .5 .7]; %change bar fill colour.
h4.EdgeColor=[.8 .5 .7]; %change bar outline colour.
line([7, 7], [0 30000], 'LineWidth', 2, 'Color', 'b'); %add line showing quality cut-off.

%Subplot 5.
ax(5)=subplot(2,3,5);
h5=histogram(data5(:,1));
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Mean read basecall quality (Phred Q-score)','FontSize',12); %add x-axis label.
title('Mutant 2'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h5.FaceColor=[.6 .3 .5]; %change bar fill colour.
h5.EdgeColor=[.6 .3 .5]; %change bar outline colour.
line([7, 7], [0 30000], 'LineWidth', 2, 'Color', 'b'); %add line showing quality cut-off.

%Subplot 6.
ax(6)=subplot(2,3,6);
h6=histogram(data6(:,1));
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Mean read basecall quality (Phred Q-score)','FontSize',12); %add x-axis label.
title('Mutant 3'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h6.FaceColor=[.4 .1 .3]; %change bar fill colour.
h6.EdgeColor=[.4 .1 .3]; %change bar outline colour.
line([7, 7], [0 30000], 'LineWidth', 2, 'Color', 'b'); %add line showing quality cut-off.

%Modify axes.
ax(1).XAxis.FontSize=12; %set x-axis fontsize.
ax(2).XAxis.FontSize=12;
ax(3).XAxis.FontSize=12;
ax(4).XAxis.FontSize=12;
ax(5).XAxis.FontSize=12;
ax(6).XAxis.FontSize=12;
ax(1).YAxis.FontSize=12; %set y-axis fontsize.
ax(2).YAxis.FontSize=12;
ax(3).YAxis.FontSize=12;
ax(4).YAxis.FontSize=12;
ax(5).YAxis.FontSize=12;
ax(6).YAxis.FontSize=12;
linkaxes(ax,'xy'); %link x-axis and y-axis limits of all subplots.

%Save plot.
savefig(fig,'ReadQuality_Hist'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'ReadQuality_Hist.svg'); %save figure as an SVG file.
close
clear
end