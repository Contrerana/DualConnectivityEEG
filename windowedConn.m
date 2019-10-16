function pdc=windowedConn(trial,wlen,woverlap,fmin,fmax,fs,p)
    % windowing 2s length (wlen) overlapping 50% (woverlap)
    if size(trial,2)>=wlen
        windows = floor((size(trial,2)-woverlap )/(wlen-woverlap));
        windowedData=zeros(size(trial,1),wlen,windows);
        for w =1:windows
            windowedData( :, :,w)=trial(:,(w-1 )*(wlen-woverlap)+(1:wlen));
        end
    else
        windows=1;
        windowedData=zeros(size(trial,1),size(trial,2),windows);
        windowedData(:,:,1)=trial;
    end
    %PDC for each window
    pdc=zeros(windows,size(trial,1),size(trial,1));
    for w=1:windows
        if windows==1
            data=windowedData(:,:);
        else
        data=squeeze(windowedData(:,:,w));
        end
        pdc(w,:,:)=calculating_ConnPDC(data,fs,p,fmin,fmax);
    end
end