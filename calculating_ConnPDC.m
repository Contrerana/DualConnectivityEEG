function pdc=calculating_ConnPDC(data,Fs,p,fmin,fmax)
%data;
%Fs:sampling frequency
%p:order model (MVAR)
%fmin and fmax, frequency band of interest
%% MVAR model
[~,A]=arfit(data',p,p);
%% some constants
[nch,~,~] = size(A);
frange=fmin:fmax;
z = 1i*2*pi/Fs;
denPDC=zeros(nch,nch,length(frange));
for n = 1 :length(frange) % Number of frequency points
    % A(f) matrix for PDC
    Af2(:,:,n)=eye(nch) - reshape(sum(bsxfun(@times,reshape(A,nch*nch,p),...
        exp(-z*(1:p)*frange(n))),2),nch,nch);
    for ch=1:nch
        denPDC(:,ch,n)=norm(Af2(:,ch,n));
    end
end
pdc=abs(Af2)./denPDC; %Aij/sqrt(aj'*aj)
% avg freq information
pdc=squeeze(mean(pdc,3));
% main diagonal is zeros
pdc(logical(eye(size(pdc))))=0;
end