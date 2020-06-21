function [ Hex ] = Binary2Hex( binary )
%binaryB2H Summary of this function goes here
%   Detailed explanation goes here
E1=dec2hex(bin2dec(num2str(binary(1:4))));
 E2=dec2hex(bin2dec(num2str(binary(5:8))));
 E3=dec2hex(bin2dec(num2str(binary(9:12))));
 E4=dec2hex(bin2dec(num2str(binary(13:16))));
 E5=dec2hex(bin2dec(num2str(binary(17:20))));
 E6=dec2hex(bin2dec(num2str(binary(21:24))));
 E7=dec2hex(bin2dec(num2str(binary(25:28))));
 E8=dec2hex(bin2dec(num2str(binary(29:32))));
 E9=dec2hex(bin2dec(num2str(binary(33:36))));
 E10=dec2hex(bin2dec(num2str(binary(37:40))));
 E11=dec2hex(bin2dec(num2str(binary(41:44))));
 E12=dec2hex(bin2dec(num2str(binary(45:48))));
 E13=dec2hex(bin2dec(num2str(binary(49:52))));
 E14=dec2hex(bin2dec(num2str(binary(53:56))));
 E15=dec2hex(bin2dec(num2str(binary(57:60))));
 E16=dec2hex(bin2dec(num2str(binary(61:64))));
 Hex=cell2mat({E1 E2 E3 E4 E5 E6 E7 E8 E9 E10 E11 E12 E13 E14 E15 E16});
end
