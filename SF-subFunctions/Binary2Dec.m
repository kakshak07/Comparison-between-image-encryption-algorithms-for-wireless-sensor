function [ dec ] = Binary2Dec( binary )
%binaryB2H Summary of this function goes here
%   Detailed explanation goes here
E1=bin2dec(num2str(binary(1:8)));
 E2=bin2dec(num2str(binary(9:16)));
 E3=bin2dec(num2str(binary(17:24)));
 E4=bin2dec(num2str(binary(25:32)));
 E5=bin2dec(num2str(binary(33:40)));
 E6=bin2dec(num2str(binary(41:48)));
 E7=bin2dec(num2str(binary(49:56)));
 E8=bin2dec(num2str(binary(57:64)));
 dec=cell2mat({E1 E2 E3 E4 E5 E6 E7 E8});
end
