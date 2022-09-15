function plotReadLengthVsQualScatterhistLogData
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function creates a scatterplot with marginal density histograms of
%the read length vs the basecall quality. The x-axis scale is logarithmic.

%The function requires a TXT file for each sample, containing basecall
%quality scores in column 1 and read lengths in column 2. The data must be
%tab-delimited. No headers are allowed.

%Run this function from inside the folder containing the TXT files. No
%subfolders are allowed.

%IMPORTANT: This function creates a plot for 6 samples. A lot of things are
%hardcoded so this code will need to be modified for use with new samples.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the plot is saved in 2 different formats in
%the working directory.

%%
%Subplot 1.
data1=readmatrix('NanoPlot-data_barcode07.txt'); %load data.
Lengths=log(data1(:,2));
Qualities=data1(:,1);
T=table(Lengths,Qualities);
fig=figure('Position', get(0, 'Screensize')); %make figure full-screen.
ax(1)=subplot(2,3,1);
h1=scatterhistogram(T,'Lengths','Qualities');
h1.Color=[.5 .8 .7];
h1.Title='Wildtype 1'; %add plot title.
h1.YLabel='Read basecall quality'; %add y-axis label.
h1.XLabel='Log_{10}(Read length)'; %add x-axis label.
h1.FontSize=12;
h1.MarkerSize=1;
h1.MarkerFilled='off';
xlim([4 11]);
ylim([2 20]);
clear data1;

%Subplot 2.
data2=readmatrix('NanoPlot-data_barcode08.txt'); %load data.
Lengths=log(data2(:,2));
Qualities=data2(:,1);
T=table(Lengths,Qualities);
ax(2)=subplot(2,3,2);
h2=scatterhistogram(T,'Lengths','Qualities');
h2.Color=[.3 .6 .5];
h2.Title='Wildtype 2'; %add plot title.
h2.YLabel='Read basecall quality'; %add y-axis label.
h2.XLabel='Log_{10}(Read length)'; %add x-axis label.
h2.FontSize=12;
h2.MarkerSize=1;
h2.MarkerFilled='off';
xlim([4 11]);
ylim([2 20]);
clear data2;

%Subplot 3.
data3=readmatrix('NanoPlot-data_barcode09.txt'); %load data.
Lengths=log(data3(:,2));
Qualities=data3(:,1);
T=table(Lengths,Qualities);
ax(3)=subplot(2,3,3);
h3=scatterhistogram(T,'Lengths','Qualities');
h3.Color=[.1 .4 .3];
h3.Title='Wildtype 3'; %add plot title.
h3.YLabel='Read basecall quality'; %add y-axis label.
h3.XLabel='Log_{10}(Read length)'; %add x-axis label.
h3.FontSize=12;
h3.MarkerSize=1;
h3.MarkerFilled='off';
xlim([4 11]);
ylim([2 20]);
clear data3;

%Subplot 4.
data4=readmatrix('NanoPlot-data_barcode10.txt'); %load data.
Lengths=log(data4(:,2));
Qualities=data4(:,1);
T=table(Lengths,Qualities);
ax(4)=subplot(2,3,4);
h4=scatterhistogram(T,'Lengths','Qualities');
h4.Color=[.8 .5 .7];
h4.Title='Mutant 1'; %add plot title.
h4.YLabel='Read basecall quality'; %add y-axis label.
h4.XLabel='Log_{10}(Read length)'; %add x-axis label.
h4.FontSize=12;
h4.MarkerSize=1;
h4.MarkerFilled='off';
xlim([4 11]);
ylim([2 20]);
clear data4;

%Subplot 5.
data5=readmatrix('NanoPlot-data_barcode11.txt'); %load data.
Lengths=log(data5(:,2));
Qualities=data5(:,1);
T=table(Lengths,Qualities);
ax(5)=subplot(2,3,5);
h5=scatterhistogram(T,'Lengths','Qualities');
h5.Color=[.6 .3 .5];
h5.Title='Mutant 2'; %add plot title.
h5.YLabel='Read basecall quality'; %add y-axis label.
h5.XLabel='Log_{10}(Read length)'; %add x-axis label.
h5.FontSize=12;
h5.MarkerSize=1;
h5.MarkerFilled='off';
xlim([4 11]);
ylim([2 20]);
clear data5;

%Subplot 6.
data6=readmatrix('NanoPlot-data_barcode12.txt'); %load data.
Lengths=log(data6(:,2));
Qualities=data6(:,1);
T=table(Lengths,Qualities);
ax(6)=subplot(2,3,6);
h6=scatterhistogram(T,'Lengths','Qualities');
h6.Color=[.4 .1 .3];
h6.Title='Mutant 3'; %add plot title.
h6.YLabel='Read basecall quality'; %add y-axis label.
h6.XLabel='Log_{10}(Read length)'; %add x-axis label.
h6.FontSize=12;
h6.MarkerSize=1;
h6.MarkerFilled='off';
xlim([4 11]);
ylim([2 20]);
clear data6;

%Save plot.
savefig(fig,'ReadLength_v_Qual_Scatterhist_LogData'); %save figure as a FIG file in the working directory.
fig.Renderer='painters'; %force MATLAB to render the image as a vector.
saveas(fig,'ReadLength_v_Qual_Scatterhist_LogData.svg'); %save figure as an SVG file.
close
clear
end