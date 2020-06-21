function [Data,padding] = Scalling (Data,sf);
% Data=imread('cameraman.tif');
Data=reshape(Data,[size(Data,1)*size(Data,2) 1]);
Data=double(Data);
padding=mod(length(Data),sf);
if (padding~=0)
    padding=sf-padding;
end
Data=[Data;zeros(padding,1)];
Data=reshape(Data,[sf,length(Data)/sf]);