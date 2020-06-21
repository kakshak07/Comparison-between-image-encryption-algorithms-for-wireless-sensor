function [cipher]=SF_Encrypt(bin_msg,K1,K2,K3,K4,K5);
%For Encryption of 64 bit msg
bin_msg1=bin_msg(1:32);
bin_msg2=bin_msg(33:64);

enc=cell(8,4);
% Arranging 64 bit into 16 bit block
enc{1,1}=bin_msg(1:16);
enc{1,2}=bin_msg(17:32);
enc{1,3}=bin_msg(33:48);
enc{1,4}=bin_msg(49:64);

% For First round
%Step no 01
%performing xnor operation in first 16 bits with K1
enc{2,1}=not(xor(K1,enc{1,1}));
% Using f f_function and swaping tecniques on 16 bit
enc{2,2}=xor(f_fun(enc{2,1}),enc{1,3});
%performing xnor operation in last 16 bits with K1
enc{2,4}=not(xor(K1,enc{1,4}));
% Using f f_function and swaping tecniques on 16 bit
enc{2,3}=xor(f_fun(enc{2,4}),enc{1,2});
%Step no 02

%Swaping Blocks
enc{3,1}=enc{2,2};
enc{3,2}=enc{2,1};
enc{3,3}=enc{2,4};
enc{3,4}=enc{2,3};

% For Second Round
%performing Xnor operation with K2
enc{4,1}=not(xor(K2,enc{3,1}));
%Using f f_function and Xor operation obtain second 16 bit block
enc{4,2}=xor(f_fun(enc{4,1}),enc{3,2});
%Performing xnor operation on last 16 bit
enc{4,4}=not(xor(K2,enc{3,4}));
%Using f f_function and Xor operation obtain third 16 bit block
enc{4,3}=xor(f_fun(enc{4,4}),enc{3,3});

% For Third Round
%Step no 01
%performing xnor operation in first 16 bits with K3
enc{5,1}=not(xor(K3,enc{4,1}));
% Using f f_function and swaping tecniques on 16 bit
enc{5,2}=xor(f_fun(enc{5,1}),enc{4,3});
%performing xnor operation in last 16 bits with K1
enc{5,4}=not(xor(K3,enc{4,4}));
% Using f f_function and swaping tecniques on 16 bit
enc{5,3}=xor(f_fun(enc{5,4}),enc{4,2});
%Step no 02
%Swaping Blocks
enc{6,1}=enc{5,2};
enc{6,2}=enc{5,1};
enc{6,3}=enc{5,4};
enc{6,4}=enc{5,3};

% %% Modified
% enc{3,1}=enc{1,1};
% enc{3,2}=enc{1,2};
% enc{3,3}=enc{1,3};
% enc{3,4}=enc{1,4};

%Round no 04
%performing Xnor operation with K4
enc{7,1}=not(xor(K4,enc{6,1}));
%Using f f_function and Xor operation obtain second 16 bit block
enc{7,2}=xor(f_fun(enc{7,1}),enc{6,2});
%Performing xnor operation on last 16 bit
enc{7,4}=not(xor(K4,enc{6,4}));
%Using f f_function and Xor operation obtain third 16 bit block
enc{7,3}=xor(f_fun(enc{7,4}),enc{6,3});
 
% Round no 05
%performing Xnor operation with K5
enc{8,1}=not(xor(K5,enc{7,1}));
%Using f f_function and Xor operation obtain second 16 bit block
enc{8,2}=xor(f_fun(enc{8,1}),enc{7,3});
%Performing xnor operation on last 16 bit
enc{8,4}=not(xor(K5,enc{7,4}));
%Using f f_function and Xor operation obtain third 16 bit block
enc{8,3}=xor(f_fun(enc{8,4}),enc{7,2});
% Encrypted Cipher

% enc{8,1}=enc{7,1};
% enc{8,2}=enc{7,2};
% enc{8,3}=enc{7,3};
% enc{8,4}=enc{7,4};


cipher=[enc{8,1},enc{8,2},enc{8,3},enc{8,4}];
% cipher=[enc{3,1},enc{3,2},enc{3,3},enc{3,4}];