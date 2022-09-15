function plotVariantCounts
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a plot of the splicing variant type counts for each
%group.

%This function requires CSV files created by running SGSeq in R. Save a
%copy of the CSV files as XLSX files.

%Run this function from inside the folder containing the XLSX files.

%IMPORTANT: Some things are hardcoded so this code will need to be modified
%for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
%Load WT data.
dataWT=readtable('proportionWT.xlsx','FileType','spreadsheet');
dataWT=table2cell(dataWT(:,[1 4])); %keep only necessary columns.
dataWT=dataWT([2,4,5,7:9,12:15],:); %keep only non-zero rows.
valuesWT=sort(cell2mat(dataWT(:,2))); %sort in ascending order.
labels={'MXE','S2E.I','ALE','AFE','SE.I','AS','AE','RI.R','A5SS.P','A3SS.P'}; %labels correspond to sorted values.

%Load MT data.
dataMT=readtable('proportionMT.xlsx','FileType','spreadsheet');
dataMT=table2cell(dataMT(:,[1 4]));
dataMT=dataMT([2,4,5,7:9,12:15],:);
valuesMT=sort(cell2mat(dataMT(:,2)));

%Plot figure.
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.

%Plot WT.
subplot(1,2,1);
p1=pie(valuesWT);
title('Wildtype','FontSize',14);
set(p1(2:2:end),'FontSize',14); %set values' font size.
legend(labels,'FontSize',14,'Location','eastoutside');

%Plot MT.
subplot(1,2,2);
p2=pie(valuesMT);
title('Mutant','FontSize',14);
set(p2(2:2:end),'FontSize',14);
legend(labels,'FontSize',14,'Location','eastoutside');

%Save plot.
savefig(fig,'VariantCounts'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'VariantCounts.svg'); %save figure as an SVG file.
close
clear
end