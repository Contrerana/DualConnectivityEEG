function conn=calculating_PDC(data,fs,fmin,fmax,p,wlen,woverlap)
% INPUTS
%            data is a struct with you trials and conditions
%            fs: sampling frequency
%            fmin and fmax : frequency band of interest
%            p: model order (MVAR)
%            wlen: window length (samples)
%            woverlap: window overlapping 

% OUTPUTS
%            conn is a struct with size the number of trials and two fields
%            per trial: condition1 and condition 2
names=fieldnames(data);
nTrials=size(data,2);
conn=struct();
for i=1:nTrials
    %% Condition 1
    temp=getfield(data,{i},names{1,1});
    conn(i).Condition1=windowedConn(temp,wlen,woverlap,fmin,fmax,fs,p);
    disp(['PDC trial' num2str(i) ' condition 1 done']);
    %% Condition 2
    temp=getfield(data,{i},names{2,1});
    conn(i).Condition2=windowedConn(temp,wlen,woverlap,fmin,fmax,fs,p);
    disp(['PDC trial' num2str(i) ' condition 2 done']);
end
end
