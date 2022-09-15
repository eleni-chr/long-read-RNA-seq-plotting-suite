function plotMapVsUnmapLength
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function creates a plot showing the distribution of the lengths of
%the mapped and unmapped reads separately.

%The custom functions "getUnmappedLengths" and "getMappedLengths" must be ran 
%beforehand (in this order) to generate the variables used in the current
%function.

%Run this function from inside the folder containing the subfolders with
%the MAT files called "length_analysis.mat", which are created by running 
%the above functions.

%IMPORTANT: This function creates a plot for 6 samples. A lot of things are
%hardcoded so this code will need to be modified for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
%Find folders with MAT files to work with.
files=dir(cd); %get a list of all files and folders in current directory.
dirFlags=[files.isdir]; % get a logical vector that tells which is a directory.
subFolders=files(dirFlags); %extract only those that are directories.
wd=cd; %save working directory.

for f=3:length(subFolders) %loop through each subfolder.
    cd(subFolders(f).name); %navigate to folder containing MAT files.
    load('length_analysis.mat','unmap_lengths','map_lengths'); %load data.
    unmapped{f-2,1}=mat2cell(unmap_lengths,length(unmap_lengths),1);
    mapped{f-2,1}=mat2cell(map_lengths,length(map_lengths),1);
    cd(wd); %return to working directory for next iteration of for-loop.
end

%% CREATE PLOT

%Subplot 1.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
ax(1)=subplot(2,3,1);
dataMapped=cell2mat(mapped{1});
dataUnmapped=cell2mat(unmapped{1});
h1=histogram(dataMapped);
hold on;
h2=histogram(dataUnmapped);
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Sequence length','FontSize',12); %add x-axis label.
title('Wildtype 1','FontSize',12); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(1).XAxis.FontSize=12; %set x-axis fontsize.
ax(1).YAxis.FontSize=12; %set y-axis fontsize.
set(gca,'xscale','log'); %log-transform the x-axis.
New_XTickLabel=get(gca,'xtick');
set(gca,'XTickLabel',New_XTickLabel);
h1.FaceColor=[0 .447 .741]; %change bar fill colour.
h1.EdgeColor=[0 .447 .741]; %change bar outline colour.
h2.FaceColor=[.85, .325, .098];
h2.EdgeColor=[.85, .325, .098];
hold off;

%Subplot 2.
ax(2)=subplot(2,3,2);
dataMapped=cell2mat(mapped{2});
dataUnmapped=cell2mat(unmapped{2});
h1=histogram(dataMapped);
hold on;
h2=histogram(dataUnmapped);
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Sequence length','FontSize',12); %add x-axis label.
title('Wildtype 2','FontSize',12); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(2).XAxis.FontSize=12; %set x-axis fontsize.
ax(2).YAxis.FontSize=12; %set y-axis fontsize.
set(gca,'xscale','log'); %log-transform the x-axis.
New_XTickLabel=get(gca,'xtick');
set(gca,'XTickLabel',New_XTickLabel);
h1.FaceColor=[0 .447 .741]; %change bar fill colour.
h1.EdgeColor=[0 .447 .741]; %change bar outline colour.
h2.FaceColor=[.85, .325, .098];
h2.EdgeColor=[.85, .325, .098];
hold off;

%Subplot 3.
ax(3)=subplot(2,3,3);
dataMapped=cell2mat(mapped{3});
dataUnmapped=cell2mat(unmapped{3});
h1=histogram(dataMapped);
hold on;
h2=histogram(dataUnmapped);
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Sequence length','FontSize',12); %add x-axis label.
title('Wildtype 3','FontSize',12); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(3).XAxis.FontSize=12; %set x-axis fontsize.
ax(3).YAxis.FontSize=12; %set y-axis fontsize.
set(gca,'xscale','log'); %log-transform the x-axis.
New_XTickLabel=get(gca,'xtick');
set(gca,'XTickLabel',New_XTickLabel);
h1.FaceColor=[0 .447 .741]; %change bar fill colour.
h1.EdgeColor=[0 .447 .741]; %change bar outline colour.
h2.FaceColor=[.85, .325, .098];
h2.EdgeColor=[.85, .325, .098];
legend('Mapped','Unmapped','FontSize',12);
hold off;

%Subplot 4.
ax(4)=subplot(2,3,4);
dataMapped=cell2mat(mapped{4});
dataUnmapped=cell2mat(unmapped{4});
h1=histogram(dataMapped);
hold on;
h2=histogram(dataUnmapped);
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Sequence length','FontSize',12); %add x-axis label.
title('Mutant 1','FontSize',12); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(4).XAxis.FontSize=12; %set x-axis fontsize.
ax(4).YAxis.FontSize=12; %set y-axis fontsize.
set(gca,'xscale','log'); %log-transform the x-axis.
New_XTickLabel=get(gca,'xtick');
set(gca,'XTickLabel',New_XTickLabel);
h1.FaceColor=[0 .447 .741]; %change bar fill colour.
h1.EdgeColor=[0 .447 .741]; %change bar outline colour.
h2.FaceColor=[.85, .325, .098];
h2.EdgeColor=[.85, .325, .098];
hold off;

%Subplot 5.
ax(5)=subplot(2,3,5);
dataMapped=cell2mat(mapped{5});
dataUnmapped=cell2mat(unmapped{5});
h1=histogram(dataMapped);
hold on;
h2=histogram(dataUnmapped);
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Sequence length','FontSize',12); %add x-axis label.
title('Mutant 2','FontSize',12); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
ax(5).XAxis.FontSize=12; %set x-axis fontsize.
ax(5).YAxis.FontSize=12; %set y-axis fontsize.
set(gca,'xscale','log'); %log-transform the x-axis.
New_XTickLabel=get(gca,'xtick');
set(gca,'XTickLabel',New_XTickLabel);
h1.FaceColor=[0 .447 .741]; %change bar fill colour.
h1.EdgeColor=[0 .447 .741]; %change bar outline colour.
h2.FaceColor=[.85, .325, .098];
h2.EdgeColor=[.85, .325, .098];
hold off;

%Subplot 6.
ax(6)=subplot(2,3,6);
dataMapped=cell2mat(mapped{6});
dataUnmapped=cell2mat(unmapped{6});
h1=histogram(dataMapped);
hold on;
h2=histogram(dataUnmapped);
ylabel('Number of reads','FontSize',12); %add y-axis label.
xlabel('Sequence length','FontSize',12); %add x-axis label.
title('Mutant 3','FontSize',12); %add plot title.
set(gca,'box','off'); %remove top x-axis and right y-axis.
New_XTickLabel=get(gca,'xtick');
set(gca,'XTickLabel',New_XTickLabel);
ax(6).XAxis.FontSize=12; %set x-axis fontsize.
ax(6).YAxis.FontSize=12; %set y-axis fontsize.
set(gca,'xscale','log'); %log-transform the x-axis.
h1.FaceColor=[0 .447 .741]; %change bar fill colour.
h1.EdgeColor=[0 .447 .741]; %change bar outline colour.
h2.FaceColor=[.85, .325, .098];
h2.EdgeColor=[.85, .325, .098];
hold off;

linkaxes(ax,'xy'); %link x-axis and y-axis limits of all subplots.

%Save plot.
savefig(fig,'MapVsUnmapLength_Hist'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'MapVsUnmapLength_Hist.svg'); %save figure as an SVG file.
close
clear
end