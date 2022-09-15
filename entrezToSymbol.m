function entrezToSymbol
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function replaces the Entrez ID of a gene with its gene symbol, in
%the CSV files produced by running DESeq2 in R, using the featureCounts
%output when ran on Galaxy. It also replaces them in the TXT file
%containing gene counts, which is created by running featureCounts on
%Galaxy.

%This function requires a TXT file produced by running annotateMyIDs on
%Galaxy. The TXT file should have the filename "annotateMyIDs.txt".

%Run this function from inside the folder containing the CSV and TXT files.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but a new CSV file is created for each input
%CSV/TXT file, with the prefix "symbol" in the filename.

%% FOR THE TXT FILE:

%Load list of entrez IDs in COUNTS file.
DESeq2data=readtable('counts.txt','FileType','text');
list=DESeq2data.Geneid;

%Load list of entrez IDs and Symbols.
data=tdfread('annotateMyIDs.txt');
entrez=data.ENTREZID;
symbols=data.SYMBOL;

newList=cell(size(DESeq2data,1),1); %initialise variable.
lead='EntrezID:';

for ii=1:length(list)
    idx=find(entrez==list(ii),1); %get index of current gene in the entrez array.
    newList{ii}=strtrim(symbols(idx,:)); %get corresponding symbol for current gene.
    if strcmp(newList{ii},'NA')
        newList{ii}=strcat(lead,num2str(entrez(idx))); %Replace genes for which the symbol is NA (i.e., the genes have no symbol) with their EntrezID.
    end
end

%Append remaining variables to cell array.
counts=table2cell(DESeq2data(:,2:size(DESeq2data,2)));
finalData=[newList,counts];

%Save results.
writecell(finalData,'symbol_counts.txt','Delimiter','tab');
clear

%% FOR THE CSV FILE(S):

D=dir('Group*.csv'); %Find CSV files to work with.

for f=1:length(D) %loop through each CSV file.
    fprintf('Working on file %d of %d\n',f,length(D)); %inform user of progress.
    fname=D(f).name; %get filename of current CSV file.
    
    %Load list of entrez IDs in CSV file.
    DESeq2data=readtable(fname,'FileType','text');
    list=DESeq2data.Var1;
    
    varnames=DESeq2data.Properties.VariableNames; %Get column names in CSV files.
    varnames{1}='Gene'; %Create a header for column 1.
    
    %Convert cell array of characters to matrix.
    list2=zeros(size(list));
    for b=1:length(list)
        var=str2double(list{b});
        list2(b)=var;
    end

    %Load list of entrez IDs and Symbols.
    data=tdfread('annotateMyIDs.txt');
    entrez=data.ENTREZID;
    symbols=data.SYMBOL;

    newList=cell(size(DESeq2data,1),1); %initialise variable.

    lead='EntrezID:';
    for ii=1:length(list2)
        idx=find(entrez==list2(ii),1); %get index of current gene in the entrez array.
        newList{ii}=strtrim(symbols(idx,:)); %get corresponding symbol for current gene.
        if strcmp(newList{ii},'NA')
            newList{ii}=strcat(lead,num2str(entrez(idx))); %Replace genes for which the symbol is NA (i.e., the genes have no symbol) with their EntrezID.
        end
    end

    %Append remaining variables to cell array.
    counts=table2cell(DESeq2data(:,2:size(DESeq2data,2)));
    finalData=[newList,counts];
    finalData=[varnames;finalData]; %append Headers to top of cell array.

    %Save results.
    writecell(finalData,strcat('symbol',fname)); %save new CSV file.
end
clear
end