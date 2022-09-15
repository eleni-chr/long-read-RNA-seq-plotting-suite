function fastq_seqs(varargin)
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function extracts the sequence of each entry in a FASTQ file. 
%Multiple FASTQ files are checked at once.

%Run this function from inside the folder containing the FASTQ files. No
%subfolders are allowed.

%INPUT ARGUMENTS:
%One OPTIONAL input argument: float specifying how many entries to import at
%a time. The entries are imported in blocks because attempting to import all 
%the data from the SAM file at once may cause the RAM to run out. The
%default value for this argument is 30000. If the RAM still runs out, 
%decrease this value.

%OUTPUT ARGUMENTS:
%None, but the variable "fastq_seqs" is saved in a MAT file called
%"fastq_seqs.mat" in a folder called "Data analysis", which (unless it
%already exists) is created one directory above the current directory. The 
%"fastq_seqs" variable is a 1 x N cell array where N is equal to the number
%of reads in the FASTQ file. Each element of "fastq_seqs" corresponds to a 
%read sequence. The elements of "fastq_seqs" appear in the same order as 
%they appear in the FASTQ file.

%%
%Find FASTQ files to work with.
D=dir('*.fastq'); %get list of FASTQ files.
d=length(D); %number of FASTQ files found.
fprintf('%d FASTQ files found.\n',d) %inform user.
wd=cd; %save working directory.

for f=1:d %loop through each FASTQ file.
    fname=D(f).name; %get filename of FASTQ file.
    fprintf('Calculating number of entries in FASTQ file %d of %d.\n',f,d) %inform user of progress.
    InfoStruct=fastqinfo(fname); %get information abou the contents of the FASTQ file.
    num_reads=double(InfoStruct.NumberOfEntries); %get total number of entries in the FASTQ file (in uint64 type) and convert to double type for calculations later.
    fprintf('%d entries found in current FASTQ file.\n',num_reads); %inform user of progress.

    %Check input argument.
    p=inputParser;
    argName='blocksize';
    defaultValue=40000;
    validationFcn=@(x) isnumeric(x) && isscalar(x) && isfloat(x) && (x>0) && (x<num_reads); %check validity of input argument.
    addOptional(p,argName,defaultValue,validationFcn);
    parse(p,varargin{:});
    S=p.Results; %access value for blocksize.
    blocksize=S.blocksize; %define value for blocksize.
    z=num_reads/blocksize;
    blocks=ceil(z); %round UP to nearest integer if z is a decimal.
    blocks_minus1=floor(z); %round DOWN to nearest integer if z is a decimal.
    fprintf('Will attempt to import entries in %d blocks.\n',blocks) %inform user of progress.
    
    %Initialise variables.
    a=1;
    b=30000;
    fastq_seqs=cell(1,num_reads);
    
    for ii=1:blocks_minus1 %loop through each block, except for the last block.
        tic %start counting elapsed time.
        fprintf('File %d of %d: Importing block %d of %d. ',f,d,ii,blocks) %inform user of progress.
        [~,data,~]=fastqread(fname,'blockread',[a b]); %import data in blocks of 30,000 reads at a time.
        idx=1;
        for j=a:b
            fastq_seqs{j}=data{idx}; %save the sequence.
            idx=idx+1;
        end
        
        t=toc; %stop counting elapsed time.
        seconds=t*(blocks_minus1-ii); %calculate estimated time to completion of current SAM file (in seconds).
        minutes=seconds/60; %convert time to minutes.
        fprintf('Approximately %f minutes remaining for current file.\n',minutes); %inform user of estimated time remaining.
        
        a=a+blocksize;
        b=b+blocksize;
    end

    %Import the last block of reads.
    c=num_reads-(blocks_minus1*blocksize); %calculate size of block.
    fprintf('File %d of %d: Importing block %d of %d. Approximately %f minutes remaining for current file.\n',f,d,blocks,blocks,minutes) %inform user of progress.
    if c~=0
        [~,data,~]=fastqread(fname,'blockread',[a num_reads]);
        idx=1;
        for j=a:num_reads
            fastq_seqs{j}=data{idx};
            idx=idx+1;
        end
    else
        [~,data,~]=fastqread(fname,'blockread',[a b]);
        for j=a:b
            fastq_seqs{j}=data{idx};.
            idx=idx+1;
        end
    end

    %Save results
    cd .. %move one directory above the current one.
    folder=fname(1:end-6); %define folder name for current FASTQ file.
    mkdir(fullfile(pwd,'Data analysis',folder)); %create a new folder to save the results in (unless it already exists).
    cd(strcat(pwd,'/Data analysis','/',folder)); %navigate to output folder.
    save('fastq_seqs.mat','fastq_seqs','-v7.3'); %save the variable. The '-v7.3' flag is needed to save variables >2GB.
    fprintf('Analysis of FASTQ file %d of %d finished successfully.\n',f,d) %inform user of progress.
    cd(wd); %return to working directory for next iteration of for-loop.
end
clear
end