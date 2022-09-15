function getUnmappedLengths
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function calcualtes the sequence length of unmapped reads.

%This function requires TXT files created by running seqtk, to get the 
%information about the unmapped reads. Multiple TXT files are processed at 
%once.

%Run this function from inside the folder containing the TXT files outputted
%by seqtk.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but the following variable is saved into a new MAT
%file called "length_analysis.mat":
%unmap_lengths:     An M x 1 matrix of numbers, where M is equal to the
%                   number of unmapped reads. Each element is equal to the
%                   length of the corresponding read.

%%
%Find TXT files to work with.
D=dir('*.txt'); %get list of TXT files.
d=length(D); %number of TXT files found.
fprintf('%d TXT files found.\n',d) %inform user.
wd=cd; %save working directory.

for f=1:d %loop through each TXT file.
    fname=D(f).name; %get filename of TXT file.
    fprintf('Working on file %d of %d\n',f,d) %inform user of progress.

    seqs=readtable(fname,'FileType','text'); %import unmapped reads.
    seqs=seqs.Var3; %extract only the read sequences.
    unmap_lengths=zeros(length(seqs),1); %initialise variable.
    totalreads=length(seqs); %total number of unmapped reads.
    for ii=1:totalreads %loop through each unamapped read.
        unmap_lengths(ii)=length(seqs{ii}); %calculate length of current sequence and save it in array of lengths.
    end

    %Save results
    cd ../.. %move two directories above the current one.
    folder=fname(1:end-13); %define folder name for current TXT file.
    mkdir(fullfile(pwd,'Data analysis',folder)); %create a new folder to save the results in (unless it already exists).
    cd(strcat(pwd,'/Data analysis','/',folder)); %navigate to output folder.
    save('length_analysis.mat','unmap_lengths'); %save the variable.
    cd(wd); %return to working directory for next iteration of for-loop.
end
clear
end