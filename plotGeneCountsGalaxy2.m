function plotGeneCountsGalaxy2
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function creates plots for the top 6 most upregulated and the top 6
%most downregulated genes, using data generated by DESeq2. The plots show
%the number of times each gene is present in each sample, separated by
%group. Both the actual and the normalised counts are shown.

%Run this function from inside the folder containing the CSV files 
%outputted by DESeq2.

%This function also requires a TXT file outputted by featureCounts, which
%contains the counts for each gene in the last N columns, where N is equal
%to the number of samples. In this function, N is hardcoded as equal to 6.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%% Load data.
counts=readtable('symbol_counts.txt','FileType','text'); %load featureCounts results.
down=readtable('symbolGroup_mutant_vs_wildtype_resDown2.csv','FileType','text'); %load downregulated genes.
up=readtable('symbolGroup_mutant_vs_wildtype_resUp2.csv','FileType','text'); %load upregulated genes.

down=sortrows(down,'log2FoldChange','ascend'); %sort genes from most downregulated to least downregulated.
up=sortrows(up,'log2FoldChange','descend'); %sort genes from most upregulated to least upregulated.

down6=table2cell(down(1:6,1)); %get 6 most downregulated genes.
up6=table2cell(up(1:6,1)); %get 6 most upregulated genes.

%Initialise variables.
geneIDsDown=cell(6,1);
geneIDsUp=cell(6,1);
downCounts=zeros(6,6);
upCounts=zeros(6,6);
jj=1;
kk=1;

for ii=1:height(counts) %loop through each gene.
    geneID=table2cell(counts(ii,1)); %get gene name.
    if ismember(geneID,down6)
        geneIDsDown{jj}=geneID; %get name of current gene.
        downCounts(jj,:)=table2array(counts(ii,2:7)); %get number of counts for current gene for each sample.
        jj=jj+1;
    end
    if ismember(geneID,up6)
        geneIDsUp{kk}=geneID;
        upCounts(kk,:)=table2array(counts(ii,2:7));
        kk=kk+1;
    end
end

%% Load normalised data.
countsN=readtable('symbolGroup_mutant_vs_wildtype_normalisedCounts.csv','FileType','text'); %load featureCounts results.
downN=readtable('symbolGroup_mutant_vs_wildtype_resDown2.csv','FileType','text'); %load downregulated genes.
upN=readtable('symbolGroup_mutant_vs_wildtype_resUp2.csv','FileType','text'); %load upregulated genes.

downN=sortrows(downN,'log2FoldChange','ascend'); %sort genes from most downregulated to least downregulated.
upN=sortrows(upN,'log2FoldChange','descend'); %sort genes from most upregulated to least upregulated.

down6N=table2cell(downN(1:6,1)); %get 6 most downregulated genes.
up6N=table2cell(upN(1:6,1)); %get 6 most upregulated genes.

%Initialise variables.
geneIDsDownN=cell(6,1);
geneIDsUpN=cell(6,1);
downCountsN=zeros(6,6);
upCountsN=zeros(6,6);
jjN=1;
kkN=1;

for iiN=1:height(countsN) %loop through each gene.
    geneIDN=table2cell(countsN(iiN,1)); %get gene name.
    if ismember(geneIDN,down6N)
        geneIDsDownN{jjN}=geneIDN; %get name of current gene.
        downCountsN(jjN,:)=table2array(countsN(iiN,2:7)); %get number of counts for current gene for each sample.
        jjN=jjN+1;
    end
    if ismember(geneIDN,up6N)
        geneIDsUpN{kkN}=geneIDN;
        upCountsN(kkN,:)=table2array(countsN(iiN,2:7));
        kkN=kkN+1;
    end
end

%% PLOT DOWNREGULATED GENES.

fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.

for dd=1:6
    %Plot counts.
    ax1=subplot(2,3,dd);
    dataWT=downCounts(dd,1:3);
    dataMT=downCounts(dd,4:6);
    meanWT=mean(dataWT); %calculate the mean for wildtypes.
    meanMT=mean(dataMT); %calculate the mean for mutants.
    x1=2*ones(1,length(dataWT));
    x2=8*ones(1,length(dataMT));
    plot(x1,dataWT,'k.','MarkerSize',20); %plot wildyptes.
    hold on;
%     plot(x1,meanWT,'kx','MarkerSize',12); %plot mean for wildtypes.
    plot(x2,dataMT,'k.','MarkerSize',20); %plot mutants.
%     plot(x2,meanMT,'kx','MarkerSize',12); %plot mean for mutants.
    set(gca,'box','off'); %remove top x-axis and right y-axis.
    xlim([0 12]);
    xticks(0:12);
    ylabel('Count','FontSize',12); %add y-axis label.
    ax1.XTickLabels={'','','','Wildtype','','','','','','Mutant','','',''};
    title(geneIDsDown{dd},'FontSize',12); %add plot title.
    ax1.XAxis.FontSize=12; %set x-axis fontsize.
    ax1.YAxis.FontSize=12; %set y-axis fontsize.
    grid on;
    lim=ylim;
    ylim([-1 lim(2)+2]);

    %Plot normalised counts.
    yyaxis right
    ax2=gca;
    set(ax2,'ycolor',[.75 0 .75],'FontSize',12)
    dataWTN=downCountsN(1,1:3);
    dataMTN=downCountsN(1,4:6);
    meanWTN=mean(dataWTN); %calculate the mean for wildtypes.
    meanMTN=mean(dataMTN); %calculate the mean for mutants.
    x3=4*ones(1,length(dataWTN));
    x4=10*ones(1,length(dataMTN));
    plot(x3,dataWTN,'k.','MarkerEdgeColor',[.75 0 .75],'MarkerFaceColor',[0, 0.4470, 0.7410],'MarkerSize',20); %plot wildyptes.
    hold on;
%     plot(x3,meanWTN,'kx','MarkerSize',12); %plot mean for wildtypes.
    plot(x4,dataMTN,'k.','MarkerEdgeColor',[.75 0 .75],'MarkerSize',20); %plot mutants.
%     plot(x4,meanMTN,'kx','MarkerSize',12); %plot mean for mutants.
    ylabel('Normalised count','FontSize',12); %add y-axis label.
    lim=ylim;
    ylim([-1 lim(2)]);
    hold off;
end

%Save plot.
savefig(fig,'GeneCountsDown2'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'GeneCountsDown2.svg'); %save figure as an SVG file.
close

%% PLOT UPREGULATED GENES.

fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.

for dd=1:6
    %Plot counts.
    ax1=subplot(2,3,dd);
    dataWT=upCounts(dd,1:3);
    dataMT=upCounts(dd,4:6);
    meanWT=mean(dataWT); %calculate the mean for wildtypes.
    meanMT=mean(dataMT); %calculate the mean for mutants.
    x1=2*ones(1,length(dataWT));
    x2=8*ones(1,length(dataMT));
    plot(x1,dataWT,'k.','MarkerSize',20); %plot wildyptes.
    hold on;
%     plot(x1,meanWT,'kx','MarkerSize',12); %plot mean for wildtypes.
    plot(x2,dataMT,'k.','MarkerSize',20); %plot mutants.
%     plot(x2,meanMT,'kx','MarkerSize',12); %plot mean for mutants.
    set(gca,'box','off'); %remove top x-axis and right y-axis.
    xlim([0 12]);
    xticks(0:12);
    ylabel('Count','FontSize',12); %add y-axis label.
    ax1.XTickLabels={'','','','Wildtype','','','','','','Mutant','','',''};
    title(geneIDsUp{dd},'FontSize',12); %add plot title.
    ax1.XAxis.FontSize=12; %set x-axis fontsize.
    ax1.YAxis.FontSize=12; %set y-axis fontsize.
    grid on;
    lim=ylim;
    ylim([-1 lim(2)+2]);

    %Plot normalised counts.
    yyaxis right
    ax2=gca;
    set(ax2,'ycolor',[0.75, 0, 0.75],'FontSize',12)
    dataWTN=upCountsN(1,1:3);
    dataMTN=upCountsN(1,4:6);
    meanWTN=mean(dataWTN); %calculate the mean for wildtypes.
    meanMTN=mean(dataMTN); %calculate the mean for mutants.
    x3=4*ones(1,length(dataWTN));
    x4=10*ones(1,length(dataMTN));
    plot(x3,dataWTN,'k.','MarkerEdgeColor',[0.75, 0, 0.75],'MarkerFaceColor',[0, 0.4470, 0.7410],'MarkerSize',20); %plot wildyptes.
    hold on;
%     plot(x3,meanWTN,'kx','MarkerSize',12); %plot mean for wildtypes.
    plot(x4,dataMTN,'k.','MarkerEdgeColor',[0.75, 0, 0.75],'MarkerSize',20); %plot mutants.
%     plot(x4,meanMTN,'kx','MarkerSize',12); %plot mean for mutants.
    ylabel('Normalised count','FontSize',12); %add y-axis label.
    lim=ylim;
    ylim([-1 lim(2)]);
    hold off;
end

%Save plot.
savefig(fig,'GeneCountsUp2'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'GeneCountsUp2.svg'); %save figure as an SVG file.
close
clear
end