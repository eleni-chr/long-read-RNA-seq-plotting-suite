function plotDEvolcano
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates two volcano plots of the differentially expressed
%genes outputted by DESeq2. Each plot has a different set of cut-off values.

% Run this function from inside the folder containing the CSV files
% outputted by the DESeq2 analysis.

%IMPORTANT: Some things are hardcoded so this code will need to be modified
%for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%% Differential gene expression volcano plot 1.

%Load data.
data=readmatrix('Group_mutant_vs_wildtype.csv');
data=[data(:,3),data(:,6)];
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
s0=scatter(data(:,1),-log((data(:,2))),[],[.25 .25 .25],'filled');
xlabel('Log_2(fold change)','FontSize',12);
ylabel('-Log_1_0(p-value)','FontSize',12);
hold on
ax=gca;
ax.XAxis.FontSize=12; %set x-axis fontsize.
ax.YAxis.FontSize=12; %set y-axis fontsize.
text(5.5,-log(0.03),'p=0.05','FontSize',12);
text(0.63,32,'LFC=0.58','FontSize',12); %might need to adjust x and y values for your data.
text(-1.33,32,'LFC=-0.58','FontSize',12); %might need to adjust x and y values for your data.

%Plot data with p<0.05.
data=readmatrix('Group_mutant_vs_wildtype_res05.csv');
data=[data(:,3),data(:,6)];
s1=scatter(data(:,1),-log((data(:,2))),[],'b','filled');

%Plot data with LFC>0.58.
data=readmatrix('Group_mutant_vs_wildtype_resUp.csv');
data=[data(:,3),data(:,6)];
s2=scatter(data(:,1),-log((data(:,2))),[],[.75 0 .75],'filled');

%Plot data with LFC<-0.58.
data=readmatrix('Group_mutant_vs_wildtype_resDown.csv');
data=[data(:,3),data(:,6)];
s3=scatter(data(:,1),-log((data(:,2))),[],[0 .75 .75],'filled');

line(xlim,[-log(0.05) -log(0.05)],'LineWidth',1,'Color','r'); %add line showing p-value cut-off.
line([-0.58 -0.58],ylim,'LineWidth',1,'Color','r'); %add line showing cut-off for downregulated.
line([0.58 0.58],ylim,'LineWidth',1,'Color','r'); %add line showing cut-off for upregulated.

lgd=legend([s0 s1 s2 s3],'p>=0.05','p<0.05','p<0.05 + Upregulated','p<0.05 + Downregulated');
lgd.FontSize=12;

%Save figure.
savefig(fig,'DE_volcano'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'DE_volcano.svg'); %save figure as an SVG file.
close
clear

%% Differential gene expression volcano plot 2.

%Load data.
data=readmatrix('Group_mutant_vs_wildtype.csv');
data=[data(:,3),data(:,6)];
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
s0=scatter(data(:,1),-log((data(:,2))),[],[.25 .25 .25],'filled');
xlabel('Log_2(fold change)','FontSize',12);
ylabel('-Log_1_0(p-value)','FontSize',12);
hold on
ax=gca;
ax.XAxis.FontSize=12; %set x-axis fontsize.
ax.YAxis.FontSize=12; %set y-axis fontsize.
text(5.5,-log(0.03),'p=0.05','FontSize',12);
text(1.05,32,'LFC=1','FontSize',12); %might need to adjust x and y values for your data.
text(-1.55,32,'LFC=-1','FontSize',12); %might need to adjust x and y values for your data.

%Plot data with p<0.05.
data=readmatrix('Group_mutant_vs_wildtype_res05.csv');
data=[data(:,3),data(:,6)];
s1=scatter(data(:,1),-log((data(:,2))),[],'b','filled');

%Plot data with LFC>1.
data=readmatrix('Group_mutant_vs_wildtype_resUp2.csv');
data=[data(:,3),data(:,6)];
s2=scatter(data(:,1),-log((data(:,2))),[],[.75 0 .75],'filled');

%Plot data with LFC<-1.
data=readmatrix('Group_mutant_vs_wildtype_resDown2.csv');
data=[data(:,3),data(:,6)];
s3=scatter(data(:,1),-log((data(:,2))),[],[0 .75 .75],'filled');

line(xlim,[-log(0.05) -log(0.05)],'LineWidth',1,'Color','r'); %add line showing p-value cut-off.
line([-1 -1],ylim,'LineWidth',1,'Color','r'); %add line showing cut-off for downregulated.
line([1 1],ylim,'LineWidth',1,'Color','r'); %add line showing cut-off for upregulated.

lgd=legend([s0 s1 s2 s3],'p>=0.05','p<0.05','p<0.05 + Upregulated','p<0.05 + Downregulated');
lgd.FontSize=12;

%Save figure.
savefig(fig,'DE_volcano2'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'DE_volcano2.svg'); %save figure as an SVG file.
close
clear
end