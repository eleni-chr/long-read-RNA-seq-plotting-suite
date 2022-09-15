function plotReadLengthHistLogData
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a log-transformed histogram of read lengths before 
%filtering out low basecall quality reads. The data are log-transformed.

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
lengths1=data1(:,2); %read lengths.
N50_1=log(1332);

data2=readmatrix('NanoPlot-data_barcode08.txt'); %load data.
lengths2=data2(:,2); %read lengths.
N50_2=log(1294);

data3=readmatrix('NanoPlot-data_barcode09.txt'); %load data.
lengths3=data3(:,2); %read lengths.
N50_3=log(1162);

data4=readmatrix('NanoPlot-data_barcode10.txt'); %load data.
lengths4=data4(:,2); %read lengths.
N50_4=log(1373);

data5=readmatrix('NanoPlot-data_barcode11.txt'); %load data.
lengths5=data5(:,2); %read lengths.
N50_5=log(1306);

data6=readmatrix('NanoPlot-data_barcode12.txt'); %load data.
lengths6=data6(:,2); %read lengths.
N50_6=log(1350);

%Subplot 1.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
ax(1)=subplot(2,3,1);
h1=histogram(log(lengths1),70); %log-transform the data.
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Sequence length)','FontSize',12); %add x-axis label.
title('Wildtype 1'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h1.FaceColor=[.5 .8 .7]; %change bar fill colour.
h1.EdgeColor=[.5 .8 .7]; %change bar outline colour.
line([N50_1, N50_1],[0 250000], 'LineWidth', 2, 'Color', 'b');

%Subplot 2.
ax(2)=subplot(2,3,2);
h2=histogram(log(lengths2),70); %log-transform the data.
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Sequence length)','FontSize',12); %add x-axis label.
title('Wildtype 2'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h2.FaceColor=[.3 .6 .5]; %change bar fill colour.
h2.EdgeColor=[.3 .6 .5]; %change bar outline colour.
line([N50_2, N50_2], [0 250000], 'LineWidth', 2, 'Color', 'b');

%Subplot 3.
ax(3)=subplot(2,3,3);
h3=histogram(log(lengths3),70); %log-transform the data.
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Sequence length)','FontSize',12); %add x-axis label.
title('Wildtype 3'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h3.FaceColor=[.1 .4 .3]; %change bar fill colour.
h3.EdgeColor=[.1 .4 .3]; %change bar outline colour.
line([N50_3, N50_3],[0 250000], 'LineWidth', 2, 'Color', 'b');

%Subplot 4.
ax(4)=subplot(2,3,4);
h4=histogram(log(lengths4),70); %log-transform the data.
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Sequence length)','FontSize',12); %add x-axis label.
title('Mutant 1'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h4.FaceColor=[.8 .5 .7]; %change bar fill colour.
h4.EdgeColor=[.8 .5 .7]; %change bar outline colour.
line([N50_4, N50_4], [0 250000], 'LineWidth', 2, 'Color', 'b');

%Subplot 5.
ax(5)=subplot(2,3,5);
h5=histogram(log(lengths5),70); %log-transform the data.
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Sequence length)','FontSize',12); %add x-axis label.
title('Mutant 2'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h5.FaceColor=[.6 .3 .5]; %change bar fill colour.
h5.EdgeColor=[.6 .3 .5]; %change bar outline colour.
line([N50_5, N50_5], [0 250000], 'LineWidth', 2, 'Color', 'b');

%Subplot 6.
ax(6)=subplot(2,3,6);
h6=histogram(log(lengths6),70); %log-transform the data.
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Log_{10}(Sequence length)','FontSize',12); %add x-axis label.
title('Mutant 3'); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
h6.FaceColor=[.4 .1 .3]; %change bar fill colour.
h6.EdgeColor=[.4 .1 .3]; %change bar outline colour.
line([N50_6, N50_6], [0 250000], 'LineWidth', 2, 'Color', 'b');

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
savefig(fig,'ReadLength_Hist_LogData'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'ReadLength_Hist_LogData.svg'); %save figure as an SVG file.
close
clear
end