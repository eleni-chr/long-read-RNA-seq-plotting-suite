function plotMAPQmapped
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a plot of Mapping quality (MAPQ) vs Number of mapped
%reads.

%This function requires data obtained by running the following custom functions
%(in this order): "flag_analysis", "mapq_analysis", "countmapqs".

%Run this function from inside the folder containing the subfolders with
%the MAT files created by the above functions.

%NOTES:
%MAPQ values are integers between 0 and 60.
%MAPQ of 30 or above indicates high quality mapping.
%MAPQ below 30 indicates low quality mapping.
%MAPQ=0 (for mapped reads) indicates the read mapped to multiple locations 
%on the reference. For unmapped reads, MAPQ=0 is the default but it is not
%the real mapping quality score because the read is not actually mapped.

%IMPORTANT: This function creates a plot for 6 samples. A lot of things are
%hardcoded so this code will need to be modified for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
%Find MAT files to work with.
D=dir('*/mapq_analysis.mat'); %get list of MAT files in subfolders.
d=length(D); %number of MAT files found.
wd=cd; %save working directory.

%Obtain data for all series.
series=cell(1,d);
for f=1:d %loop through each MAT file.
    cd(D(f).folder); %navigate to folder containing MAT file.
    load('mapq_analysis.mat','mapq_mapped') %load the data into the workspace.
    series{f}=mapq_mapped;
    clear mapq_mapped
end
cd(wd); %return to working directory.

%Merge data for all series.
y=zeros(d,4);
for kk=1:d
    temp=series{kk};
    
    zeroQ=temp(1,2); %obtain number of reads with MAPQ=0.
    sixtyQ=temp(end,2); %obtain number of reads with MAPQ=60.
    
    lowQ=0;
    for ii=2:28
        lowQ=lowQ+temp(ii,2); %obtain number of reads with MAPQ=1-29.
    end
    
    highQ=0;
    for jj=29:60
        highQ=highQ+temp(jj,2); %obtain numer of reads with MAPQ=30-59.
    end
    
    %Values for y-axis.
    y(kk,4)=zeroQ;
    y(kk,1)=lowQ;
    y(kk,2)=highQ;
    y(kk,3)=sixtyQ;
    y(kk,4)=zeroQ;

    cd(wd); %return to working directory for next iteration of for-loop.
end

%Plot data.
categories={'MAPQ 1-29','MAPQ 30-59','MAPQ 60','Unknown MAPQ'}; %x-axis categories.
x=categorical(categories); %convert x to categorical data for plotting.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
b=bar(x,y); %plot bar chart.
ylabel('Number of mapped reads','FontSize',12); %add y-axis label.
lgd=legend({'Wildtype 1','Wildtype 2','Wildtype 3','Mutant 1','Mutant 2','Mutant 3'},'Location','northwest','FontSize',12); %add chart legend.
lgd.NumColumns=2; %display legend in two columns.
set(gca,'box','off'); %remove top x-axis and right y-axis.

%Change bar colours for each series.
b(1).FaceColor=[.5 .8 .7];
b(2).FaceColor=[.3 .6 .5];
b(3).FaceColor=[.1 .4 .3];
b(4).FaceColor=[.8 .5 .7];
b(5).FaceColor=[.6 .3 .5];
b(6).FaceColor=[.4 .1 .3];

%Save figure.
savefig(fig,'MAPQmapped'); %save figure as a FIG file in the working directory.
saveas(fig,'MAPQmapped.png'); %save figure as a PNG file.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'MAPQmapped.svg'); %save figure as an SVG file.
close

%ALTERNATIVE PLOT
%Subplot 1.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
ax(1)=subplot(1,2,1);
x2=categorical(categories([1 2 3]));
b=bar(x2,y(:,[1 2 3]));
ylabel('Number of mapped reads','FontSize',12); %add y-axis label.
xlabel('Primary alignments','FontSize',12); %add x-axis label.
title('A','FontSize',12);
lgd=legend({'Wildtype 1','Wildtype 2','Wildtype 3','Mutant 1','Mutant 2','Mutant 3'},'Location','northwest','FontSize',12); %add chart legend.
lgd.NumColumns=2; %display legend in two columns.
set(gca,'box','off'); %remove top x-axis and right y-axis.

%Change bar colours for each series.
b(1).FaceColor=[.5 .8 .7];
b(2).FaceColor=[.3 .6 .5];
b(3).FaceColor=[.1 .4 .3];
b(4).FaceColor=[.8 .5 .7];
b(5).FaceColor=[.6 .3 .5];
b(6).FaceColor=[.4 .1 .3];

%Subplot 2
ax(2)=subplot(1,2,2);
x3=categorical(categories(4));
c=bar(x3,y(:,4));
ylabel('Number of mapped reads','FontSize',12); %add y-axis label.
xlabel('Secondary & Chimeric alignments','FontSize',12); %add x-axis label.
title('B','FontSize',12);
set(gca,'box','off','XTick',[]); %remove top x-axis and right y-axis. Remove x-axis tick marks.
lgd=legend({'Wildtype 1','Wildtype 2','Wildtype 3','Mutant 1','Mutant 2','Mutant 3'},'FontSize',12); %add chart legend.
lgd.NumColumns=2; %display legend in two columns.

%Change bar colours for each series.
c(1).FaceColor=[.5 .8 .7];
c(2).FaceColor=[.3 .6 .5];
c(3).FaceColor=[.1 .4 .3];
c(4).FaceColor=[.8 .5 .7];
c(5).FaceColor=[.6 .3 .5];
c(6).FaceColor=[.4 .1 .3];

%Modify axes.
ax(1).XAxis.FontSize=12; %set x-axis fontsize.
ax(2).XAxis.FontSize=12;
ax(1).YAxis.FontSize=12; %set y-axis fontsize.
ax(2).YAxis.FontSize=12;
linkaxes(ax,'y'); %link y-axis limits of all subplots.

%Save alternative figure.
savefig(fig,'MAPQmapped_alt'); %save figure as a FIG file.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'MAPQmapped_alt.svg'); %save figure as an SVG file.
close
clear
end