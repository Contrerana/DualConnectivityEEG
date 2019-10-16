function plv=calculate_PLV(data,filtPts,wlen,woverlap)
nCh=size(data,1);
%filter data
filteredData = filter(filtPts, 1,data');
% hilber transform
htemp=hilbert(filteredData)';
% windowing 2s length overlapping 50%
if size(data,2)>=wlen
    windows = floor((size(htemp,2)-woverlap )/(wlen-woverlap));
    windowedData=zeros(size(htemp,1),wlen,windows);
    for w =1:windows
        windowedData( :, :,w)=htemp(:,(w-1 )*(wlen-woverlap)+(1:wlen));
    end
else
    windows=1;
    windowedData=zeros(size(htemp,1),size(data,2),windows);
    windowedData(:,:,1)=htemp;
end

% PLV
angles=angle(windowedData );
plv=zeros(windows,size(data,1),size(data,1));
for w=1:windows
    for ii=1:nCh
        ch1=squeeze(angles(ii,:,w));
        for jj=1:nCh
            ch2=squeeze(angles(jj,:,w));
            diff=ch1-ch2;
            plv(w,ii,jj) = abs(mean(exp(1i*diff),2));
        end
    end
end
end