function qname_analysis(varargin)
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function gives information about the QNAME (Query Name) for each read
%in a SAM file. Multiple SAM files are checked at once. The QNAME should be
%identical to the Header in a FASTQ file.

%Run this function from inside the folder containing subfolders with the
%SAM files.

%INPUT ARGUMENTS:
%One OPTIONAL input argument: float specifying how many reads to import at
%a time. The reads are imported in blocks because attempting to import all 
%the data from the SAM file at once may cause the RAM to run out. The
%default value for this argument is 40000. If the RAM still runs out, 
%decrease this value.

%OUTPUT ARGUMENTS:
%No output arguments, but the cell arrays "qnames" and "unique_qnames" are
%saved in a MAT file called "qname_analysis.mat" in the folder "Data 
%analysis", created one directory above the working directory, and
%contains a subfolder for each SAM file. The variable "qnames" contains the
%Query Name for each read in the SAM file, in the order they appear in the 
%SAM file. The variable "unique_qnames" contains the same information as 
%"qnames" but without duplicates, and in the same order.

%%
%Find SAM files to work with.
D=dir('*/*.sam'); %get list of SAM files in subfolders.
d=length(D); %number of SAM files found.
fprintf('%d SAM files found.\n',d) %inform user.
wd=cd; %save working directory.

for f=1:d %loop through each SAM file.
    cd(D(f).folder); %navigate to folder containing SAM file.
    tempdir=dir('*.sam');
    fname=tempdir.name; %get filename of SAM file.
    fprintf('Calculating number of entries in SAM file %d of %d.\n',f,d) %inform user of progress.
    InfoStruct=saminfo(fname,'NumOfReads','true'); %get information abou the contents of the FASTQ file.
    num_reads=double(InfoStruct.NumReads); %get total number of entries in the SAM file (in uint64 type) and convert to double type for calculations later.
    fprintf('%d entries found in current SAM file.\n',num_reads); %inform user of progress.

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
    b=40000;
    qnames=cell(1,num_reads);
    
    for ii=1:blocks_minus1 %loop through each block, except for the last block.
        tic %start counting elapsed time.
        fprintf('File %d of %d: Importing block %d of %d. ',f,d,ii,blocks) %inform user of progress.
        data=samread(fname,'blockread',[a b]); %import data in blocks.
        idx=1;
        for j=a:b
            qnames{j}=data(idx).QueryName; %save the QNAME for each entry into the vector "qnames".
            idx=idx+1;
        end
        
        t=toc; %stop counting elapsed time.
        seconds=t*(blocks_minus1-ii); %calculate estimated time to completion of current SAM file (in seconds).
        minutes=seconds/60; %convert time to minutes.
        fprintf('Approximately %f minutes remaining for current file.\n',minutes); %inform user of estimated time remaining.
        
        a=a+blocksize;
        b=b+blocksize;
    end

    %Import the last block.
    c=num_reads-(blocks_minus1*blocksize); %calculate size of block.
    fprintf('File %d of %d: Importing block %d of %d. Approximately %f minutes remaining for current file.\n',f,d,blocks,blocks,minutes) %inform user of progress.
    if c~=0
        data=samread(fname,'blockread',[a num_reads]);
        idx=1;
        for j=a:num_reads
            qnames{j}=data(idx).QueryName;
            idx=idx+1;
        end
    else
        data=samread(fname,'blockread',[a b]);
        for j=a:b
            qnames{j}=data(idx).QueryName;
            idx=idx+1;
        end
    end
    
    unique_qnames=unique(qnames,'stable'); %store QNAMES in the variable "unique_qnames" without duplicates, in the same order they appear in the variable "qnames".

    %Save results
    cd ../.. %move two directories above the current one.
    folder=fname(1:end-4); %define folder name for current SAM file.
    mkdir(fullfile(pwd,'Data analysis',folder)); %create a new folder to save the results in (unless it already exists).
    cd(strcat(pwd,'/Data analysis','/',folder)); %navigate to output folder.
    save('qname_analysis.mat','qnames','unique_qnames'); %save the variables.
    fprintf('Analysis of SAM file %d of %d finished successfully.\n',f,d) %inform user of progress.
    cd(wd); %return to working directory for next iteration of for-loop.
end
clear
end