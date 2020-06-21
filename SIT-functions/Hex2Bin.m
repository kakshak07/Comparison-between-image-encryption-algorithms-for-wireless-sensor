function [ bin ] = Hex2Bin( hex )
%HEX2BIN Summary of this function goes here
%   Detailed explanation goes here
bin=logical([]);
for b=1:length(hex)
    bin=[bin  logical(h2b(hex(b)))];
end
end
