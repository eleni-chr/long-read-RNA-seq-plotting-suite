function lst2txt
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function extracts the read IDs from an LST file and saves them in a
%TXT file in the current directory. Multiple LST files are processed at
%once. The LST file is created by Samtools and contain information about
%the unmapped reads.

%Run this function from inside the folder containing the LST files.

%INPUT ARGUMENTS: None.

%OUTPUT ARGUMENTS: None, but a new TXT file is saved in the current
%directory for each of the LST files.

%%
%Find LST files to work with.
D=dir('*.lst'); %get list of LST files.
d=length(D); %number of LST files found.
fprintf('%d LST files found.\n',d) %inform user.

for f=1:d %loop through each LST file.
    fname=D(f).name; %get filename of LST file.
    fprintf('Working on LST file %d of %d.\n',f,d) %inform user of progress.
    
    data=readtable(fname,'FileType','text'); %import LST file.
    list=data.Var1; %extract only the read IDs.
    %list=table2cell(list);
    
    filename=strcat(fname(1:end-4),'_IDs.txt'); %filename of new TXT file.
    writecell(list,filename); %save list of read IDs as TXT file.
end
clear
end