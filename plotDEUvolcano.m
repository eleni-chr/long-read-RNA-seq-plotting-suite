function plotDEUvolcano
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a volcano plot of the differentially used exons
%outputted by DEXSeq.

%Run this function from inside the folder containing the CSV files
%outputted by the DEXSeq analysis.

%IMPORTANT: Some things are hardcoded so this code will need to be modified
%for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%% Differential gene expression volcano plot 1.

%Load all data.
data=readtable('dxr1.xlsx','FileType','spreadsheet');
data=table2cell([data(:,7),data(:,11)]);
for ii=1:numel(data)
    data{ii}=str2double(data{ii});
end
data=cell2mat(data);
data=data(all(~isnan(data),2),:); %remove NaNs.

%Plot all data.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
s0=scatter(data(:,2),-log((data(:,1))),[],[.25 .25 .25],'filled');
xlabel('Log_2(fold change)','FontSize',12);
ylabel('-Log_1_0(p-value)','FontSize',12);
hold on
ax=gca;
ax.XAxis.FontSize=12; %set x-axis fontsize.
ax.YAxis.FontSize=12; %set y-axis fontsize.
text(-35,-log(0.04),'p=0.05','FontSize',12);
text(1,15,'LFC=0.58','FontSize',12); %might need to adjust x and y values for your data.
text(-5,15,'LFC=-0.58','FontSize',12); %might need to adjust x and y values for your data.

%Load data with p<0.05.
data=readtable('dxr1_pval0.05.xlsx','FileType','spreadsheet');
data=table2cell([data(:,7),data(:,11)]);
for ii=1:numel(data)
    data{ii}=str2double(data{ii});
end
data=cell2mat(data);
data=data(all(~isnan(data),2),:); %remove NaNs.

%Plot data with LFC>0.58.
FC=data(:,2);
pval=data(:,1);
idx=find(FC>0.58); %find indices of elements with LFC>0.58.
FC=FC(idx);
pval=pval(idx);
s2=scatter(FC,-log(pval),[],[.75 0 .75],'filled');

%Plot data with LFC<-0.58.
FC=data(:,2);
pval=data(:,1);
idx=find(FC<-0.58); %find indices of elements with LFC>0.58.
FC=FC(idx);
pval=pval(idx);
s3=scatter(FC,-log(pval),[],[0 .75 .75],'filled');

line(xlim,[-log(0.05) -log(0.05)],'LineWidth',1,'Color','r'); %add line showing p-value cut-off.
line([-0.58 -0.58],ylim,'LineWidth',1,'Color','r'); %add line showing cut-off for downregulated.
line([0.58 0.58],ylim,'LineWidth',1,'Color','r'); %add line showing cut-off for upregulated.

lgd=legend([s2 s3],'Increased exon exclusion','Increased exon inclusion');
lgd.FontSize=12;

%Save figure.
savefig(fig,'DUE_volcano'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'DUE_volcano.svg'); %save figure as an SVG file.
close
clear
end