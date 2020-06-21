function [K1,K2,K3,K4,K5]=SF_Key_Gen(bin_key);
%making a cell
key= cell(5,4);
%First for matrix of 16bit each
key{1,1}=f_fun(bin_key(1:16));%bin_key(1:16);
key{1,2}=f_fun(bin_key(33:48));%bin_key(17:32);
key{1,3}=f_fun(bin_key(17:32));%bin_key(33:48);
key{1,4}=f_fun(bin_key(49:64));%bin_key(49:64);

% generating a matrix of each 16bit int 4*4
key{2,1}(1,:)=key{1,1}(1:4);
key{2,1}(2,:)=key{1,1}(5:8);
key{2,1}(3,:)=key{1,1}(9:12);
key{2,1}(4,:)=key{1,1}(13:16);
key{2,2}(1,:)=key{1,2}(1:4);
key{2,2}(2,:)=key{1,2}(5:8);
key{2,2}(3,:)=key{1,2}(9:12);
key{2,2}(4,:)=key{1,2}(13:16);
key{2,3}(1,:)=key{1,3}(1:4);
key{2,3}(2,:)=key{1,3}(5:8);
key{2,3}(3,:)=key{1,3}(9:12);
key{2,3}(4,:)=key{1,3}(13:16);
key{2,4}(1,:)=key{1,4}(1:4);
key{2,4}(2,:)=key{1,4}(5:8);
key{2,4}(3,:)=key{1,4}(9:12);
key{2,4}(4,:)=key{1,4}(13:16);

%shifting
key{3,1}(1,:)=key{2,1}(1,:);
key{3,1}(2,:)=circshift(key{2,1}(2,:),[1 1]);
key{3,1}(3,:)=circshift(key{2,1}(3,:),[1 2]);
key{3,1}(4,:)=circshift(key{2,1}(4,:),[1 3]);

key{3,2}(1,:)=key{2,2}(1,:);
key{3,2}(2,:)=circshift(key{2,2}(2,:),[1 1]);
key{3,2}(3,:)=circshift(key{2,2}(3,:),[1 2]);
key{3,2}(4,:)=circshift(key{2,2}(4,:),[1 3]);

key{3,3}(1,:)=key{2,3}(1,:);
key{3,3}(2,:)=circshift(key{2,3}(2,:),[1 1]);
key{3,3}(3,:)=circshift(key{2,3}(3,:),[1 2]);
key{3,3}(4,:)=circshift(key{2,3}(4,:),[1 3]);

key{3,4}(1,:)=key{2,4}(1,:);
key{3,4}(2,:)=circshift(key{2,4}(2,:),[1 1]);
key{3,4}(3,:)=circshift(key{2,4}(3,:),[1 2]);
key{3,4}(4,:)=circshift(key{2,4}(4,:),[1 3]);

key_1{8,1}=key{3,1}; %Modified
key_1{8,2}=key{3,2}; %Modified
key_1{8,3}=key{3,3}; %Modified
key_1{8,4}=key{3,4}; %Modified

key_1{9,1}=[key_1{8,1}(1,:),key_1{8,1}(2,:),key_1{8,1}(3,:),key_1{8,1}(4,:)];
key_1{9,2}=[key_1{8,2}(:,1)',flipdim(key_1{8,2}(:,2)',2),key_1{8,2}(:,3)',...
    flipdim(key_1{8,2}(:,4)',2)];
key_1{9,3}=[key_1{8,3}(:,1)',flipdim(key_1{8,3}(:,2)',2),key_1{8,3}(:,3)',...
    flipdim(key_1{8,3}(:,4)',2)];
key_1{9,4}=[key_1{8,4}(1,:),key_1{8,4}(2,:),key_1{8,4}(3,:),key_1{8,4}(4,:)];

% For Final KEY K1
K1=key_1{9,1};
% For Final KEY K2
K2=key_1{9,2};
% For Final KEY K3
K3=key_1{9,3};
% For Final KEY K4
K4=key_1{9,4};
% For Final KEY K5
tmp=xor(K1,K2);
tmp1=xor(K3,K4);
K5=xor(tmp,tmp1);