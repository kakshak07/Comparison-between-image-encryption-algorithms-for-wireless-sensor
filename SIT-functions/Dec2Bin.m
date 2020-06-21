function [ bin ] = Dec2Bin( dec )
%DEC2BIN Summary of this function goes here
%   Detailed explanation goes here
% bin=logical([]);
hex=[];
for b=1:length(dec)
    hex=[hex  dec2hex(dec(b),2)];
end
[bin] = Hex2Bin(hex);
end
