function appendFC(fname)
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function caluclates Fold-change (FC) values from log2FoldChange (LFC)
%values in a CSV file outputted by DESeq2.

%Run this function from inside the folder containing the CSV file.

%INPUT ARGUMENTS:
%fname:     A character array specifying the filename (including extension)
%           of the CSV file to be edited.

%OUTPUT ARGUMENTS: None, but a new CSV file is saved in the working
%directory. Also, a new column with the FC values is appended to the input
%file.

%%
LFC=readmatrix(fname,'Range','C:C'); %import LFC values.
FC=2.^LFC; %calculate FC values from each LFC value.
t=readtable(fname); %import all data from CSV file.
numOfColumn=size(t,2); %determine number of existing columns in CSV file.
t.(numOfColumn+1)=FC; %append new data as a new column in CSV file.
t.Properties.VariableNames{numOfColumn+1}='FoldChange'; %change header of new column in CSV file.
t.Properties.VariableNames{1}='gene'; %add a header to the first column in CSV file since it is missing.
writetable(t,fname); %save results to CSV file.
t2=table(t.gene,t.FoldChange); %create new table with only gene names and FC values.
t2.Properties.VariableNames{1}='gene'; %add column name.
t2.Properties.VariableNames{2}='FoldChange'; %add column name.
new_name=fname(1:end-4); %remove ".csv" from fname.
writetable(t2,strcat(new_name,'_STRING_input.csv')); %save new CSV file with the new table.
clear
end