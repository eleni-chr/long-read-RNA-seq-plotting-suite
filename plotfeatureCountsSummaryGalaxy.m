function plotfeatureCountsSummaryGalaxy
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a plot of the results of featureCounts, when run on 
%Galaxy.

%This function requires a TXT file for each sample, containing the summary
%of featureCounts. Edit the TXT file to add the headers "Status" and
%"Count" (tab-delimited). Each TXT file must have the word "summary.txt" as
%the suffix of the filename.

%Run this function from inside the folder containing the TXT files.

%IMPORTANT: This function creates a plot for 6 samples. A lot of things are
%hardcoded so this code will need to be modified for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
%Find TXT files to work with.
D=dir('*summary.txt');
fprintf('%d TXT files found\n',length(D)) %inform user of progress.

data=zeros(12,length(D)); %initialise variable.

%Load SUMMARY data.
for ii=1:length(D) %loop through each TXT file.
    fprintf('Working on file %d of %d\n',ii,length(D)) %inform user of progress.
    fname=D(ii).name; %get filename of current TXT file.
    s=tdfread(fname); %import data from current TXT file.
    data(:,ii)=s.Count;
end
data([2:9,11],:)=[]; %delete values corresponding to unmapped reads and to secondary alignments, and zero-elements.
total_primary_alignments=sum(data); %get total number of primary alignments.
for jj=1:size(data,1)
    data(jj,:)=data(jj,:)./total_primary_alignments.*100; %replace counts with percentage of total alignments.
end

categories={'WT1','WT2','WT3','MT1','MT2','MT3'}; %x-axis categories.
x=categorical(categories); %convert x to categorical data for plotting.
x=reordercats(x,{'WT1','WT2','WT3','MT1','MT2','MT3'}); %re-order categories because previous line sorts them in alphabetical order.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
b=bar(x,data,'stacked'); %plot stacked bar chart.
ylim([0 100]); %set y-axis limits.
set(gca,'box','off');
ylabel('Percentage of primary alignments','FontSize',12);
ax=gca;
ax.FontSize=12; %set font size of axes tick values.
legend({'Overlap only 1 gene','Overlap 0 genes','Overlap >1 gene (unassigned)'},'Location','northoutside','Orientation','horizontal','FontSize',12); %add chart legend.

for kk=1:3
    xtips=b(kk).XEndPoints;
    ytips=b(kk).YEndPoints;
    labels=strcat(string(round(b(kk).YData)),'%');
    text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','cap','FontSize',12);
end

%Save figure.
savefig(fig,'featureCountsSummaryGalaxy'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'featureCountsSummaryGalaxy.svg'); %save figure as an SVG file.
close
clear
end