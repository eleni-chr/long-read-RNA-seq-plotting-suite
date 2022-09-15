function getGTFgeneID(GTFfile)
%% Function written by Eleni Christoforidou in MATLAB R2019b

%This function extracts the "gene_id" and "db_xref" fields from column 9
%of a GTF file.

%Run this function from inside the folder containing the input file.

%INPUT ARGUMENTS: 
%GTFfile:     Character array specifying the filename (including the
%             extension) of a TXT file created by changing the file 
%             extension of a GTF file to "TXT".

%OUTPUT ARGUMENTS: None, but a CSV file is saved in the working directory.

%%
data=readtable(GTFfile,'FileType','text'); %import all data of the file.
col9=data.(9); %extract column 9 from file.

start_gid=regexp(col9,'gene_id "'); %find start indices of string 1 in each row.
start_db=regexp(col9,'db_xref "GeneID'); %find start indices of string 2 in each row.
endIndex=regexp(col9,';'); %find indices of semicolons in each row.

%Initialise variables.
gene_id=cell(length(col9),1);
db_xref=cell(length(col9),1);

for ii=1:length(col9) %loop through each row.
    start_g=start_gid{ii}; %get start index of field gene_id in current row.
    start_d=start_db{ii}; %get start index of field db_xref in current row.
    
    startPos_g=start_g+9; %get start index of gene ID in field gene_id.
    startPos_d=start_d+16; %get start index of gene ID in field db_xref.
    
    positions=endIndex{ii}; %get indices of semicolons in current row.
    
    pos_gid=positions(positions>start_g); %get indices of semicolons AFTER the gene_id field.
    pos_gid=pos_gid(1); %get end index of field gene_id.
    endPos_g=pos_gid-2; %get end index of gene ID in field gene_id.
    
    if ~isempty(start_d) %db_xref field exists for current row.
        pos_db=positions(positions>start_d); %get indices of semicolons AFTER the db_xref field.
        pos_db=pos_db(1); %get end index of field db_xref.
        endPos_d=pos_db-2; %get end index of gene ID in field db_xref.
    else
        endPos_d=0; %db_xref field does not exist for current row.
    end

    str=col9{ii}; %get string of current row.
    gene_id{ii,1}=str(startPos_g:endPos_g); %extract gene ID from field gene_id.
    
    if endPos_d~=0
        db_xref{ii,1}=str(startPos_d:endPos_d); %extract gene ID from field db_xref.
    else
        db_xref{ii,1}=''; %db_xref field does not exist for current row so leave this value as an empty character array.
    end
end

t=table(gene_id,db_xref); %create new table with gene_id and db_xref values.
writetable(t,'GTF_gene_IDs.csv'); %save results as CSV file.
clear
end