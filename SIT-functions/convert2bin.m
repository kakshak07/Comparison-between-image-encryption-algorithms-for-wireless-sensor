function [ Data_binary ] = convert2bin( Data )
%CONVERT2BIN Summary of this function goes here
%   Detailed explanation goes here
Data_binary=[];
for j=1:size(Data,2)
temp=[];
for i=1:size(Data,1)
temp = [temp Dec2Bin(Data(i,j))];
end
Data_binary=[Data_binary;temp];
end
end
