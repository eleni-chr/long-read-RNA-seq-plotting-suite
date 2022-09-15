function plotNumberOfMappings
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a plot of the Number of alignments for the mapped reads.

%This function requires data obtained by running the following custom functions (in
%this order): "flag_analysis", "qname analysis", "countqnames".

%Run this function from inside the folder containing the subfolders with the
%MAT files produced by the custom "countqnames" function.

%IMPORTANT: This function creates a plot for 6 samples. A lot of things are
%hardcoded so this code will need to be modified for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
%Find MAT files to work with.
D=dir('*/qname_analysis.mat'); %get list of MAT files in subfolders.
d=length(D); %number of MAT files found.
wd=cd; %save working directory.

%Obtain data for two series.
series=cell(1,d);
for f=1:d %loop through each MAT file.
    cd(D(f).folder); %navigate to folder containing MAT file.
    load('qname_analysis.mat','counts') %load the data into the workspace.
    series{f}=counts;
    clear counts
end
cd(wd); %return to working directory.

%Subplot 1.
data1=series{1};
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
ax(1)=subplot(2,3,1);
b=bar(data1(:,1),data1(:,2)); %plot bar chart.
ylabel('Number of mapped reads','FontSize',12); %add y-axis label.
xlabel('Number of alignments','FontSize',12); %add x-axis label.
title('Wildtype 1','FontSize',14); %add title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(1).XAxis.FontSize=12; %set x-axis fontsize.
ax(1).YAxis.FontSize=12; %set y-axis fontsize.
b.FaceColor=[.5 .8 .7]; %change bar colours.
set(gca,'YScale','log'); %set y-axis to log scale.

%Subplot 2.
data1=series{2};
ax(2)=subplot(2,3,2);
b=bar(data1(:,1),data1(:,2)); %plot bar chart.
ylabel('Number of mapped reads','FontSize',12); %add y-axis label.
xlabel('Number of alignments','FontSize',12); %add x-axis label.
title('Wildtype 2','FontSize',14); %add title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(2).XAxis.FontSize=12; %set x-axis fontsize.
ax(2).YAxis.FontSize=12; %set y-axis fontsize.
b.FaceColor=[.3 .6 .5]; %change bar colours.
set(gca,'YScale','log'); %set y-axis to log scale.

%Subplot 3.
data1=series{3};
ax(3)=subplot(2,3,3);
b=bar(data1(:,1),data1(:,2)); %plot bar chart.
ylabel('Number of mapped reads','FontSize',12); %add y-axis label.
xlabel('Number of alignments','FontSize',12); %add x-axis label.
title('Wildtype 3','FontSize',14); %add title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(3).XAxis.FontSize=12; %set x-axis fontsize.
ax(3).YAxis.FontSize=12; %set y-axis fontsize.
b.FaceColor=[.1 .4 .3]; %change bar colours.
set(gca,'YScale','log'); %set y-axis to log scale.

%Subplot 4.
data1=series{4};
ax(4)=subplot(2,3,4);
b=bar(data1(:,1),data1(:,2)); %plot bar chart.
ylabel('Number of mapped reads','FontSize',12); %add y-axis label.
xlabel('Number of alignments','FontSize',12); %add x-axis label.
title('Mutant 1','FontSize',14); %add title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(4).XAxis.FontSize=12; %set x-axis fontsize.
ax(4).YAxis.FontSize=12; %set y-axis fontsize.
b.FaceColor=[.8 .5 .7]; %change bar colours.
set(gca,'YScale','log'); %set y-axis to log scale.

%Subplot 5.
data1=series{5};
ax(5)=subplot(2,3,5);
b=bar(data1(:,1),data1(:,2)); %plot bar chart.
ylabel('Number of mapped reads','FontSize',12); %add y-axis label.
xlabel('Number of alignments','FontSize',12); %add x-axis label.
title('Mutant 2','FontSize',14); %add title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(5).XAxis.FontSize=12; %set x-axis fontsize.
ax(5).YAxis.FontSize=12; %set y-axis fontsize.
b.FaceColor=[.6 .3 .5]; %change bar colours.
set(gca,'YScale','log'); %set y-axis to log scale.

%Subplot 6.
data1=series{6};
ax(6)=subplot(2,3,6);
b=bar(data1(:,1),data1(:,2)); %plot bar chart.
ylabel('Number of mapped reads','FontSize',12); %add y-axis label.
xlabel('Number of alignments','FontSize',12); %add x-axis label.
title('Mutant 3','FontSize',14); %add title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(6).XAxis.FontSize=12; %set x-axis fontsize.
ax(6).YAxis.FontSize=12; %set y-axis fontsize.
b.FaceColor=[.4 .1 .3]; %change bar colours.
set(gca,'YScale','log'); %set y-axis to log scale.

linkaxes(ax,'xy'); %link axes limits of all subplots.

%Save figure.
savefig(fig,'NumberOfMappings'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'NumberOfMappings.svg'); %save figure as an SVG file.
close
clear
end