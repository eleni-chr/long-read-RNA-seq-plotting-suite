function plotNumberOfReads
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a plot of the Number of sequenced and Aligned reads.

%This function requires data obtained by running the following custom functions (in
%this order): "fastq_analysis", "qname analysis".

%Run this section from inside the folder containing the subfolders with the
%MAT files produced by the custom "qname_analysis" function.

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

%Initialise variables.
sequenced=zeros(d,1);
high_quality=zeros(d,1);
aligned=zeros(d,1);

%Obtain data.
for f=1:d %loop through each MAT file.
    cd(D(f).folder); %navigate to folder containing MAT file.
    load('qname_analysis.mat','unique_qnames','unique_mapped') %load the data into the workspace.
    high_quality(f)=length(unique_qnames); %obtain data for second series.
    aligned(f)=length(unique_mapped); %obtain data for third series.
    clear unique_qnames unique_mapped
    load('fastq_analysis.mat','fastq_headers') %load the data into the workspace.
    sequenced(f)=length(fastq_headers); %obtain data for first series.
    clear fastq_headers
end
cd(wd); %return to working directory.

%Merge variables.
y=[sequenced,high_quality,aligned];

%Create plot.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
categories={'Wildtype 1','Wildtype 2','Wildtype 3','Mutant 1','Mutant 2','Mutant 3'}; %x-axis categories.
x=categorical(categories); %convert x to categorical data for plotting.
x=reordercats(x,{'Wildtype 1','Wildtype 2','Wildtype 3','Mutant 1','Mutant 2','Mutant 3'}); %re-order categories because previous line sorts them in alphabetical order.
b=bar(x,y); %plot bar chart.
ylabel('Number of reads','FontSize',14); %add y-axis label.
lgd=legend({'Sequenced','High-quality*','Aligned**'},'FontSize',14); %add chart legend.
set(gca,'box','off'); %remove top x-axis and right y-axis.
XAxis.FontSize=14; %set x-axis fontsize.
YAxis.FontSize=14; %set y-axis fontsize.
set(gca,'TickLength',[0 0]); %remove axes ticks.

%Display values on top of bars.
xtips1=b(1).XEndPoints;
ytips1=b(1).YEndPoints;
labels1=string(b(1).YData);
t=text(xtips1,ytips1,labels1,'HorizontalAlignment','right','VerticalAlignment','middle','FontSize',12);
set(t,'Rotation',90);

xtips2=b(2).XEndPoints;
ytips2=b(2).YEndPoints;
labels2=string(b(2).YData);
t=text(xtips2,ytips2,labels2,'HorizontalAlignment','right','VerticalAlignment','middle','FontSize',12);
set(t,'Rotation',90);

xtips3=b(3).XEndPoints;
ytips3=b(3).YEndPoints;
labels3=string(b(3).YData);
t=text(xtips3,ytips3,labels3,'HorizontalAlignment','right','VerticalAlignment','middle','FontSize',12);
set(t,'Rotation',90);

%Add percentages for second series bars.
percentages2=round(y(:,2)./y(:,1).*100);
barLabels2=cellstr(strcat(num2str(percentages2),'%'))';
text(xtips2,[0 0 0 0 0 0],barLabels2,'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',12);

%Add percentages for third series bars.
percentages3=round(y(:,3)./y(:,2).*100);
barLabels3=cellstr(strcat(num2str(percentages3),'%'))';
text(xtips3,[0 0 0 0 0 0],barLabels3,'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',12);

% for a=1:3
%     %Display values on top of bars.
%     xtips=b(a).XEndPoints;
%     ytips=b(a).YEndPoints;
%     labels=strcat(string(b(a).YData),'%');
%     t=text(xtips,ytips,labels,'HorizontalAlignment','right','VerticalAlignment','middle','FontSize',14);
%     set(t,'Rotation',90);
%     
%     %Display percentages at bottom of bars.
%     if a>1
%         for p=2:3
%             percentages=round(y(:,p)./y(:,p-1).*100);
%             barLabels=cellstr(strcat(num2str(percentages),'%'))';
%             text(xtips,[0 0 0 0 0 0],barLabels,'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',14);
%         end
%     end
% end

%Save figure.
savefig(fig,'NumberOfReads'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'NumberOfReads.svg'); %save figure as an SVG file.
close
clear
end