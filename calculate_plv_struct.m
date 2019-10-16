function conn=calculate_plv_struct(data,filtPts,wlen,woverlap)
% INPUTS
%          filter points for your filter 
%          wlen: window length (samples)
%          woverlap : window overlap (samples)
% OUTPUTS
%          conn: struct with the connectivity results
names=fieldnames(data);
nTrials=size(data,2);
conn=struct();
for i=1:nTrials
    %% CONDITION 1
    temp=getfield(data,{i},names{1,1});
    conn(i).Pos=calculate_PLV(temp,filtPts,wlen,woverlap);
    disp(['PLV trial condition 1 ' num2str(i) ' done']);
    %% CONDITION 2
    temp=getfield(data,{i},names{2,1});
    conn(i).Neg=calculate_PLV(temp,filtPts,wlen,woverlap);
    disp(['PLV trial condition 2 ' num2str(i) ' done']);
end
end