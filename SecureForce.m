clc
clear all
close all
tic
addpath('C:\Users\hp\Desktop\Image Processing\Codes\SF-subFunctions\')
Images_Path='C:\Users\hp\Desktop\Image Processing\Images\';
fname={'lena','baboon','panda','Football','ORLFace'}; % filename
ext= '.jpg';

%Selecting Image for encryption
fid=input('Select Image for encryption \n1.Lena\n2.Baboon\n3.Panda\n4.Football\n5.ORLFace\n');
%fid=1 for lena and so on..

Data=imread(strcat(Images_Path,fname{fid},ext));
[row,col,dim]=size(Data);
if (dim>1)
Data=rgb2gray(Data); % convert into grayscale if input image is a color image
end

[Data,padding]=Scalling(Data,8);
Data_binary=convert2bin(Data);

%% Key Selection and Expansion

%User Inputs the key
hex_key = input('Enter the 64 bit key for encryption: ','s');
%hex_key = '133457799bbcdff1';
%hex_key='FFFFFFFFFFFFFFFF';
[bin_key] = Hex2Bin( hex_key );
[K1,K2,K3,K4,K5]=SF_Key_Gen(bin_key);

%% Encryption and Decryption
orignal_msg=[];
  encrypt_msg=[];
  decrypt_msg=[];
for i=1:size(Data_binary,1)
    orignal=Data_binary(i,:);
    tic
    [cipher]=SF_Encrypt(orignal,K1,K2,K3,K4,K5);
    encryption_time(i)=toc;
    [plaintext]=SF_Decryption(cipher,K1,K2,K3,K4,K5);
  encrypt_msg(:,i)=Binary2Dec(cipher);
  decrypt_msg(:,i)=Binary2Dec(plaintext);
end
if (padding~=0)
    Data=reshape(Data,[size(Data,1)*size(Data,2) 1]);
    Data=Data(1:end-padding);
    encrypt_msg=reshape(encrypt_msg,[size(encrypt_msg,1)*size(encrypt_msg,2) 1]);
    encrypt_msg=encrypt_msg(1:end-padding);
    decrypt_msg=reshape(decrypt_msg,[size(decrypt_msg,1)*size(decrypt_msg,2) 1]);
    decrypt_msg=decrypt_msg(1:end-padding);
end

%% Converting the Vectors into Images
Orignal=uint8(reshape(Data,[row,col]));
Encrypted=uint8(reshape(encrypt_msg,[row,col]));
Decrypted=uint8(reshape(decrypt_msg,[row,col]));

%Showing image outputs
figure
subplot(1,3,1)
imshow(Orignal)
title('Orignal image')
subplot(1,3,2)
imshow(Encrypted)
title('Encrypted image')
subplot(1,3,3)
imshow(Decrypted)
title('Decrypted image')

%Histogram
figure
subplot(2,1,1)
imhist(Orignal);
title('Original image histogram')
subplot(2,1,2)
imhist(Encrypted);
title('Encrypted image histogram')

toc

%% Calculating the Encrypted and Orignal image's Entropy
Y=(imhist(Encrypted)+0.00001)/(row*col);
Y=-sum(Y.*log2(Y));
X=(imhist(Orignal)+0.00001)/(row*col);
X=-sum(X.*log2(X));
Re=[X Y]
display(sprintf('Entropy value of original image is: %f',X))
display(sprintf('Entropy value of the encrypted image is: %f',Y))

%Correlation plot
figure
subplot(1,2,1)
scatter(Orignal(1:end-1),Orignal(2:end),'.')
axis([0 255 0 255])
title('Correlation plot of Original Image')
subplot(1,2,2)
scatter(Encrypted(1:end-1),Encrypted(2:end),'.')
axis([0 255 0 255])
title('Correlation plot of Encrypted image')

% % 1 NPCR(%)
NPCR=sum(sum(Encrypted~=Orignal))*100/(row*col)

% 2 UACI(%) 
UACI=sum(sum(abs(Encrypted-Orignal)))*100/(row*col*255)



display(sprintf('Total encryption time: %f',sum(encryption_time)))

display('correlation coefficient of original image is: ')
corrcoef(double(Orignal(1:end-1)),double(Orignal(2:end)))
display('correlation coefficient of encrypted image')
corrcoef(double(Encrypted(1:end-1)),double(Encrypted(2:end)))
