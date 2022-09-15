function plotfeatureCountsSummary
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a plot of the results of featureCounts.

%This function requires a TXT file for each sample, containing the summary
%of featureCounts. Edit the TXT file to add the headers "Status" and
%"Count" (tab-delimited).

%Run this function from inside the folder containing the TXT files.

%IMPORTANT: This function creates a plot for 6 samples. A lot of things are
%hardcoded so this code will need to be modified for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
s=tdfread('barcode07filtered_sorted_counts.txt');
data1=zeros(14,1);
for ii=1:length(s.Count)
    data1(ii,1)=s.Count(ii);
end
data1(2)=[]; %delete value corresponding to unmapped reads.
data1(9)=[]; %delete value corresponding to secondary alignments.
data1=data1(data1~=0); %delete zeroes from array.
total_primary_alignments1=s.Count(1)+s.Count(12)+s.Count(14); %get total number of primary alignments.
for jj=1:length(data1)
    data1(jj,1)=data1(jj,1)/total_primary_alignments1*100; %replace counts with percentage of total alignments.
end

s=tdfread('barcode08filtered_sorted_counts.txt');
data2=zeros(14,1);
for ii=1:length(s.Count)
    data2(ii,1)=s.Count(ii);
end
data2(2)=[]; %delete value corresponding to unmapped reads.
data2(9)=[]; %delete value corresponding to secondary alignments.
data2=data2(data2~=0); %delete zeroes from array.
total__primary_alignments2=s.Count(1)+s.Count(12)+s.Count(14); %get total number of alignments.
for jj=1:length(data2)
    data2(jj,1)=data2(jj,1)/total__primary_alignments2*100; %replace counts with percentage of total alignments.
end

s=tdfread('barcode09filtered_sorted_counts.txt');
data3=zeros(14,1);
for ii=1:length(s.Count)
    data3(ii,1)=s.Count(ii);
end
data3(2)=[]; %delete value corresponding to unmapped reads.
data3(9)=[]; %delete value corresponding to secondary alignments.
data3=data3(data3~=0); %delete zeroes from array.
total__primary_alignments3=s.Count(1)+s.Count(12)+s.Count(14); %get total number of alignments.
for jj=1:length(data3)
    data3(jj,1)=data3(jj,1)/total__primary_alignments3*100; %replace counts with percentage of total alignments.
end

s=tdfread('barcode10filtered_sorted_counts.txt');
data4=zeros(14,1);
for ii=1:length(s.Count)
    data4(ii,1)=s.Count(ii);
end
data4(2)=[]; %delete value corresponding to unmapped reads.
data4(9)=[]; %delete value corresponding to secondary alignments.
data4=data4(data4~=0); %delete zeroes from array.
total_primary_alignments4=s.Count(1)+s.Count(12)+s.Count(14); %get total number of alignments.
for jj=1:length(data4)
    data4(jj,1)=data4(jj,1)/total_primary_alignments4*100; %replace counts with percentage of total alignments.
end

s=tdfread('barcode11filtered_sorted_counts.txt');
data5=zeros(14,1);
for ii=1:length(s.Count)
    data5(ii,1)=s.Count(ii);
end
data5(2)=[]; %delete value corresponding to unmapped reads.
data5(9)=[]; %delete value corresponding to secondary alignments.
data5=data5(data5~=0); %delete zeroes from array.
total_primary_alignments5=s.Count(1)+s.Count(12)+s.Count(14); %get total number of alignments.
for jj=1:length(data5)
    data5(jj,1)=data5(jj,1)/total_primary_alignments5*100; %replace counts with percentage of total alignments.
end

s=tdfread('barcode12filtered_sorted_counts.txt');
data6=zeros(14,1);
for ii=1:length(s.Count)
    data6(ii,1)=s.Count(ii);
end
data6(2)=[]; %delete value corresponding to unmapped reads.
data6(9)=[]; %delete value corresponding to secondary alignments.
data6=data6(data6~=0); %delete zeroes from array.
total_primary_alignments6=s.Count(1)+s.Count(12)+s.Count(14); %get total number of alignments.
for jj=1:length(data6)
    data6(jj,1)=data6(jj,1)/total_primary_alignments6*100; %replace counts with percentage of total alignments.
end

y=[data1'; data2'; data3'; data4'; data5'; data6']; %merge series.
categories={'WT1','WT2','WT3','MT1','MT2','MT3'}; %x-axis categories.
x=categorical(categories); %convert x to categorical data for plotting.
x=reordercats(x,{'WT1','WT2','WT3','MT1','MT2','MT3'}); %re-order categories because previous line sorts them in alphabetical order.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
b=bar(x,y,'stacked'); %plot stacked bar chart.
ylim([0 100]); %set y-axis limits.
set(gca,'box','off');
ylabel('Percentage of primary alignments','FontSize',12);
ax=gca;
ax.FontSize=12; %set font size of axes tick values.
lgd=legend({'Overlap only 1 gene','Overlap 0 genes (unassigned)','Overlap >1 gene (unassigned)'},'Location','northoutside','Orientation','horizontal','FontSize',12); %add chart legend.

xtips1=b(1).XEndPoints;
ytips1=b(1).YEndPoints;
labels1=strcat(string(round(b(1).YData)),'%');
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','cap','FontSize',12);

xtips2=b(2).XEndPoints;
ytips2=b(2).YEndPoints;
labels2=strcat(string(round(b(2).YData)),'%');
text(xtips2,ytips2,labels2,'HorizontalAlignment','center','VerticalAlignment','cap','FontSize',12);

xtips3=b(3).XEndPoints;
ytips3=b(3).YEndPoints;
labels3=strcat(string(round(b(3).YData)),'%');
text(xtips3,ytips3,labels3,'HorizontalAlignment','center','VerticalAlignment','top','FontSize',12);

%Save figure.
savefig(fig,'featureCountsSummary'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'featureCountsSummary.svg'); %save figure as an SVG file.
close
clear
end