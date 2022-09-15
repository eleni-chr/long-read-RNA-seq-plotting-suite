function featureCountsGalaxyMerge
%% Function written by Eleni Christoforidou in MATLAB R2019b.

%This function merges the COUNTS data from multiple TXT files into a single
%TXT file (COUNTS data are obtained for each sample in a different TXT
%file, by running featureCounts on Galaxy). The filename of the TXT files
%to be used here should have the suffix "counts.txt".

%This function requires a TXT file for each sample, containing the COUNTS
%from featureCounts.

%Run this function from inside the folder containing the TXT files. No
%subfolders are allowed.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but a TXT file called "all_barcodes_counts.txt" is
%saved in the working directory.

%%
%Find TXT files to work with.
D=dir('*counts.txt');
fprintf('%d TXT files found\n',length(D)) %inform user of progress.

%Load gene IDs.
fname=D(1).name;
s=tdfread(fname); %import data from current TXT file.
geneIDs=num2cell(s.Geneid); %extract geneIDs and convert to cell array if all IDs are numerical.

counts=zeros(length(geneIDs),length(D)); %initialise variable.

%Load COUNTS data.
for ii=1:length(D) %loop through each TXT file.
    fprintf('Working on file %d of %d\n',ii,length(D)) %inform user of progress.
    fname=D(ii).name; %get filename of current TXT file.
    s=tdfread(fname); %import data from current TXT file.
    counts(:,ii)=s.Count; %extract COUNTS data.
end

counts=num2cell(counts); %convert matrix to cell array.

%Save results.
fprintf('Saving...\n'); %inform user of progress.
results=[geneIDs,counts]; %concatenate cell arrays.
writecell(results,'all_barcodes_counts.txt','Delimiter','tab'); %save TXT file.
clear
end