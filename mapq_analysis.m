function mapq_analysis(varargin)
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function gives information about the Mapping Quality (MAPQ) for each 
%entry in a SAM file. Multiple SAM files are checked at once.

%Run this function from inside the folder containing subfolders with the
%SAM files.

%INPUT ARGUMENTS:
%One OPTIONAL input argument: float specifying how many entries to import at
%a time. The entries are imported in blocks because attempting to import all 
%the data from the SAM file at once may cause the RAM to run out. The
%default value for this argument is 40000. If the RAM still runs out, 
%decrease this value.

%OUTPUT ARGUMENTS:
%No output arguments, but the following variables are saved in a MAT file
%called "mapq_analysis.mat", in a new folder called "Data analysis", 
%created one directory above the working directory (unless it already
%exists):
%(1)mapqs:           A 1 x N matrix, where N is the total number of
%                    entries in the SAM file and each value corresponds to
%                    an integer representing the mapping quality of that
%                    entry.
%(2)unique_mapqs:    A 1 x N matrix, where N is the number of unique 
%                    mapping quality scores that appear in the SAM file.
%                    The values are sorted in ascending order, and each 
%                    value appears only once.
%(3)mapq_count:      An M x 2 matrix, where M is the number of each
%                    unique mapping quality score appearing in the SAM
%                    file. The second column represents the number of
%                    occurrences of the corresponding mapping quality
%                    score in the SAM file.

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
    fprintf('Calculating number of reads in SAM file %d of %d.\n',f,d) %inform user of progress.
    InfoStruct=saminfo(fname,'NumOfReads','true'); %get information abou the contents of the FASTQ file.
    num_reads=double(InfoStruct.NumReads); %get total number of entries in the SAM file (in uint64 type) and conver to double type for calculations later.
    fprintf('%d reads found in current SAM file.\n',num_reads); %inform user of progress.

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
    mapqs=zeros(1,num_reads);
    
    for ii=1:blocks_minus1 %loop through each block, except for the last block.
        tic %start counting elapsed time.
        fprintf('File %d of %d: Importing block %d of %d. ',f,d,ii,blocks) %inform user of progress.
        data=samread(fname,'blockread',[a b]); %import data in blocks.
        idx=1;
        for j=a:b
            mapqs(j)=double(data(idx).MappingQuality); %save the mapping quality for each entry.
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
            mapqs(j)=double(data(idx).MappingQuality);
            idx=idx+1;
        end
    else
        data=samread(fname,'blockread',[a b]);
        for j=a:b
            mapqs(j)=double(data(idx).MappingQuality);
            idx=idx+1;
        end
    end
    
    %Get stats on mapqs.
    unique_mapqs=unique(mapqs); %list of all MAPQ values appearing in the SAM file but without repetitions and in ascending order.
    N=numel(unique_mapqs); %total number of unique MAPQ scores.
    count=zeros(N,1); %initialise variable.
    for k=1:N %loop through each unique MAPQ score.
        count(k)=sum(mapqs==unique_mapqs(k)); %calculate how many times the current MAPQ score k is present in the variable "mapqs".
    end
    mapq_count=[unique_mapqs(:) count]; %create a matrix, where the first column is a list
    %of unique MAPQ scores appearing in the original array "mapq", and the second
    %column represents how many times that MAPQ score appears in the original array.

    %Save results
    cd ../.. %move two directories above the current one.
    folder=fname(1:end-4); %define folder name for current SAM file.
    mkdir(fullfile(pwd,'Data analysis',folder)); %create a new folder to save the results in (unless it already exists).
    cd(strcat(pwd,'/Data analysis','/',folder)); %navigate to output folder.
    save('mapq_analysis.mat','mapqs','unique_mapqs','mapq_count'); %save the variables.
    fprintf('Analysis of SAM file %d of %d finished successfully.\n',f,d) %inform user of progress.
    cd(wd); %return to working directory for next iteration of for-loop.
end
clear
end