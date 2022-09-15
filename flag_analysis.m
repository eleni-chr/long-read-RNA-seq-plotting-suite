function flag_analysis(varargin)
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function gives information about the Flags for each entry in a SAM
%file. Multiple SAM files are checked at once.

%Run this function from inside the folder containing subfolders with the
%SAM files.

%INPUT ARGUMENTS:
%One OPTIONAL input argument: float specifying how many entries to import at
%a time. The entries are imported in blocks because attempting to import all 
%the data from the SAM file at once may cause the RAM to run out. The
%default value for this argument is 40000. If the RAM still runs out, 
%decrease this value.

%OUTPUT ARGUMENTS:
%No output arguments, but a vector called "flags" is saved in a MAT file
%called "flag_analysis.mat". A new directory is created to save the file in.
%The new directory is a folder called "Data analysis", created one
%directory above the working directory (unless it already exists), and 
%contains a subfolder for each SAM file. The varible "flags" is a 1 x N 
%matrix, where N is the total number of reads in the SAM file and each 
%element corresponds to a  combination of bitwise flags as follows 
%(according to the SAM format specification PDF at 
%https://github.com/samtools/hts-specs, last updated 5 Feb 2020):

%Flag = 0     0x900  no flags set, thus segment is mapped on the forward
%                    strand
%                    (This is the primary line - and the only line - of the
%                    read in the SAM file.)

%Flag = 1     0x1    template has multiple segments in sequencing
%                    (If 0x1 is unset, no assumptions can be made about
%                    0x2, 0x8, 0x20, 0x40 and 0x80.)

%Flag = 2     0x2    each segment properly aligned according to the aligner
%                    (i.e., the read is mapped with appropriate orientation
%                    and insert size such that it plausibly reflects having
%                    been "nicely" mapped as a whole to the reference.) 

%Flag = 4     0x4    segment is unmapped (i.e., failed to map to exons)
%                    (no assumptions can be made about bits 0x2, 0x100, and
%                    0x800; i.e., it is unknown whether the segment
%                    aligned, whether it is a secondary alignment, or
%                    whether it is a supplementary alignment.)

%Flag = 8     0x8    next read in the template is unmapped

%Flag = 16    0x10   read sequence is reverse complemented (When bit 0x4 is
%                    unset, this corresponds to the strand to which the 
%                    read has been mapped: bit 0x10 unset indicates the 
%                    forward strand, while set indicates the reverse
%                    strand. When 0x4 is set, this indicates whether the 
%                    unmapped read is stored in its original orientation as
%                    it came off the sequencing machine.). In other words,
%                    it is a primary alignment mapped on the reverse strand.

%Flag = 32    0x20   read sequence of the next segment in the template is 
%                    reverse complemented
%                    (For the last read, the next read is the first read in
%                    the template.)

%Flag = 64    0x40   the first segment in the template (see notes for 0x80)

%Flag = 128   0x80   the last segment in the template
%                    (If 0x40 and 0x80 are both set, the read is part of a 
%                    linear template, but it is neither the first nor the
%                    last read. If both 0x40 and 0x80 are unset, the index 
%                    of the read in the template is unknown. This may
%                    happen for a non-linear template or when this
%                    information is lost.)

%Flag = 256   0x100  secondary alignment
%                    (i.e., alternative mappings when multiple mappings are
%                    presented in a SAM file.)

%Flag = 512   0x200  did not pass filters, such as platform/vendor quality
%                    controls

%Flag = 1024  0x400  PCR or optical duplicate

%Flag = 2048  0x800  supplementary alignment
%                    (i.e., the alignment line is part of a chimeric
%                    alignment.)

%Any other flag number is a combination of two or more of the above
%properties (e.g., Flag = 1040 means 16 + 1024, so the read is reverse
%complemented and a PCR or optical duplicate.)

%DEFINITIONS:
% Template             A DNA/RNA sequence part of which is sequenced on a
%                      sequencing machine or assembled from raw sequences.

% Read                 A raw sequence that comes off a sequencing machine.
%                      A read may consist of multiple segments. In a SAM
%                      file, a read may occupy multiple alignment lines, 
%                      when its alignment is chimeric or when multiple
%                      mappings are given.

% Segment              A contiguous sequence or sub-sequence. The full
%                      sequence of a read read may be aligned to produce
%                      different locally aligned segments.

% Linear alignment     An alignment of a read to a single reference sequence
%                      that may include insertions, deletions, skips and
%                      clipping, but may not include direction changes
%                      (i.e., one portion of the alignment on forward strand
%                      and another portion of alignment on reverse strand).

% Chimeric alignment   An alignment of a read that cannot be represented as
%                      a linear alignment. A chimeric alignment is
%                      represented as a set of linear alignments that do
%                      not have large overlaps. One of the linear alignments
%                      in a chimeric alignment is considered the
%                      “representative” alignment, and the others are called
%                      “supplementary” and are distinguished by the
%                      supplementary alignment flag. All the SAM records in
%                      a chimeric alignment have the same Query %Name
%                      (QNAME). Reads having identical QNAME are regarded
%                      to come from the same template. Chimeric alignments 
%                      are primarily caused by structural variations, gene 
%                      fusions, misassemblies, RNA-seq or are experimental.

% Mapped               Mapped sequences are those for which an approximate
%                      origin on the reference genome has been found.
%                      Unmapped sequences may still align to the reference
%                      genome.

% Multiple mapping     One of these alignments is considered primary. All the
%                      other alignments have the secondary alignment flag set.
%                      The alignment designated primary is the best alignment.
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
    InfoStruct=saminfo(fname,'NumOfReads','true');
    num_reads=double(InfoStruct.NumReads); %get total number of entries in the SAM file (in uint64 type) and conver to double type for calculations later.
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
    fprintf('Will attempt to import reads in %d blocks.\n',blocks) %inform user of progress.
    
    %Initialise variables.
    a=1;
    b=40000;
    flags=zeros(1,num_reads);
    
    for ii=1:blocks_minus1 %loop through each block, except for the last block.
        tic %start counting elapsed time.
        fprintf('File %d of %d: Importing block %d of %d. ',f,d,ii,blocks) %inform user of progress.
        data=samread(fname,'blockread',[a b]); %import data in blocks.
        idx=1;
        for j=a:b
            flags(j)=double(data(idx).Flag); %save the flag for each entry.
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
            flags(j)=double(data(idx).Flag);
            idx=idx+1;
        end
    else
        data=samread(fname,'blockread',[a b]);
        for j=a:b
            flags(j)=double(data(idx).Flag);
            idx=idx+1;
        end
    end

    %Save results
    cd ../.. %move two directories above the current one.
    folder=fname(1:end-4); %define folder name for current SAM file.
    mkdir(fullfile(pwd,'Data analysis',folder)); %create a new folder to save the results in (unless it already exists).
    cd(strcat(pwd,'/Data analysis','/',folder)); %navigate to output folder.
    save('flag_analysis.mat','flags'); %save the variable.
    fprintf('Analysis of SAM file %d of %d finished successfully.\n',f,d) %inform user of progress.
    cd(wd); %return to working directory for next iteration of for-loop.
end
clear
end