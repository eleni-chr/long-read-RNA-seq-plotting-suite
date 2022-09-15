function plotMappingInfoPercent
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a plot of Percentage of mapped reads vs Type of alignment.

%This function requires data obtained by running the following custom functions (in
%this order): "flag_analysis", "countflags".

%Run this section from inside the folder containing the subfolders with the
%MAT files created by the above functions. No subfolders are allowed.

%IMPORTANT: This function creates a plot for 6 samples. A lot of things are
%hardcoded so this code will need to be modified for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
%Find MAT files to work with.
D=dir('*/flag_analysis.mat'); %get list of MAT files in subfolders.
d=length(D); %number of MAT files found.
wd=cd; %save working directory.

%Obtain data for all series.
series=cell(1,d);
for f=1:d %loop through each MAT file.
    cd(D(f).folder); %navigate to folder containing MAT file.
    load('flag_analysis.mat','countflags') %load the data into the workspace.
    series{f}=countflags;
    clear countflags
end
cd(wd); %return to working directory.

%Merge data for all series.
stackData=zeros(2,6,3); %initialise variable.
for kk=1:d
    temp=series{kk};
    stackData(1,kk,1)=temp(1,2); %obtain number of primary alignments that mapped to the forward strand.
    stackData(2,kk,1)=temp(3,2); %obtain number of primary alignments that mapped to the reverse strand.
    stackData(1,kk,2)=temp(4,2); %obtain number of secondary alignments that mapped to the forward strand.
    stackData(2,kk,2)=temp(5,2); %obtain number of secondary alignments that mapped to the reverse strand.
    stackData(1,kk,3)=temp(6,2); %obtain number of chimeric alignments that mapped to the forward strand.
    stackData(2,kk,3)=temp(7,2); %obtain number of chimeric alignments that mapped to the reverse strand.
    cd(wd); %return to working directory for next iteration of for-loop.
end

%Find total number of alignments for each series.
total=zeros(1,d);
for jj=1:d
    temp=series{jj};
    values=temp(temp(:,1)~=4,2); %get list of mapped alignments only.
    total(jj)=sum(values); %total number of alignments.
end

%Convert data to percentages.
percentages=stackData./total*100;

%Plot data.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
groupLabels={'Mapped to forward strand','Mapped to reverse strand','Unmapped'};
b=plotBarStackGroups(percentages,groupLabels); %create plot.
ylabel('Percentage of alignments','FontSize',12); %add y-axis label.
legend({'Primary','Secondary','Chimeric'},'Location','northwest','FontSize',12); %add chart legend.
set(gca,'box','off'); %remove top x-axis and right y-axis.

% Chance the colours of each bar segment.
c1=[.4 .7 .6; .4 .7 .6; .4 .7 .6];
c2=[.7 .4 .6; .7 .4 .6; .7 .4 .6];
c3=[.2 .5 .4; .2 .5 .4; .2 .5 .4];
c4=[.5 .2 .4; .5 .2 .4; .5 .2 .4];
c5=[0 .3 .2; 0 .3 .2; 0 .3 .2];
c6=[.3 0 .2; .3 0 .2; .3 0 .2];
colours=[c1;c2;c3;c4;c5;c6];
colours = mat2cell(colours,ones(size(colours,1),1),3);
set(b,{'FaceColor'},colours);

%Save figure.
savefig(gcf,'MappingInfoPercent'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(gcf,'MappingInfoPercent.svg'); %save figure as an SVG file.
close
clear
end

%% Functions from MATLAB File Exchange that are used within this function.

function h = plotBarStackGroups(stackData, groupLabels)
%% Plot a set of stacked bars, but group them according to labels provided.
%%
%% Params: 
%%      stackData is a 3D matrix (i.e., stackData(i, j, k) => (Group, Stack, StackElement)) 
%%      groupLabels is a CELL type (i.e., { 'a', 1 , 20, 'because' };)
%%
%% Copyright 2011 Evan Bollig (bollig at scs DOT fsu ANOTHERDOT edu
%%
%% 
NumGroupsPerAxis = size(stackData, 1);
NumStacksPerGroup = size(stackData, 2);


% Count off the number of bins
groupBins = 1:NumGroupsPerAxis;
MaxGroupWidth = 0.65; % Fraction of 1. If 1, then we have all bars in groups touching
groupOffset = MaxGroupWidth/NumStacksPerGroup;

barLabels={'WT1','WT2','WT3','MT1','MT2','MT3'};

fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
hold on;
for i=1:NumStacksPerGroup

    Y = squeeze(stackData(:,i,:));
    
    % Center the bars:
    
    internalPosCount = i - ((NumStacksPerGroup+1) / 2);
    
    % Offset the group draw positions:
    groupDrawPos = (internalPosCount)* groupOffset + groupBins;
    
    h(i,:) = bar(Y,'stacked');
    set(h(i,:),'BarWidth',groupOffset);
    set(h(i,:),'XData',groupDrawPos);
    
    for j=1:NumGroupsPerAxis
        text(groupDrawPos(j),0,barLabels{i},'VerticalAlignment','bottom','HorizontalAlignment','center');
    end
end

hold off;
set(gca,'XTickMode','manual');
set(gca,'XTick',1:NumGroupsPerAxis);
set(gca,'XTickLabelMode','manual');
set(gca,'XTickLabel',groupLabels,'FontSize',12);
end