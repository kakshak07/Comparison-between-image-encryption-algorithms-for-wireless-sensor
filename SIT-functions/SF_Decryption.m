function [bin_msg]=SF_Decryption(binary_cipher,K1,K2,K3,K4,K5);
%Decryption
dec=cell(8,4);
% Arranging 64 bit into 16 bit block
dec{1,1}=binary_cipher(1:16);
dec{1,2}=binary_cipher(17:32);
dec{1,3}=binary_cipher(33:48);
dec{1,4}=binary_cipher(49:64);

% for first round
%performing Xnor operation with K5
dec{2,1}=not(xor(K5,dec{1,1}));
%Using f f_function and Xor operation obtain second 16 bit block
dec{2,3}=xor(f_fun(dec{1,1}),dec{1,2});
%Performing xnor operation on last 16 bit
dec{2,4}=not(xor(K5,dec{1,4}));
%Using f f_function and Xor operation obtain third 16 bit block
dec{2,2}=xor(f_fun(dec{1,4}),dec{1,3});

% 
% dec{2,1}=dec{1,1};
% dec{2,1}=dec{1,2};
% dec{2,1}=dec{1,3};
% dec{2,1}=dec{1,4};

% for Second Round
%performing Xnor operation with K4
dec{3,1}=not(xor(K4,dec{2,1}));
%Using f f_function and Xor operation obtain second 16 bit block
dec{3,2}=xor(f_fun(dec{2,1}),dec{2,2});
%Performing xnor operation on last 16 bit
dec{3,4}=not(xor(K4,dec{2,4}));
%Using f f_function and Xor operation obtain third 16 bit block
dec{3,3}=xor(f_fun(dec{2,4}),dec{2,3});

% for Third Round
%Step no 01
%Swaping Blocks
dec{4,1}=dec{3,2};
dec{4,2}=dec{3,1};
dec{4,3}=dec{3,4};
dec{4,4}=dec{3,3};

%Step no 02
%performing xnor operation in first 16 bits with K3
dec{5,1}=not(xor(K3,dec{4,1}));
% Using f f_function and swaping tecniques on 16 bit
dec{5,3}=xor(f_fun(dec{4,1}),dec{4,2});
%performing xnor operation in last 16 bits with K1
dec{5,4}=not(xor(K3,dec{4,4}));
% Using f f_function and swaping tecniques on 16 bit
dec{5,2}=xor(f_fun(dec{4,4}),dec{4,3});

% for fourth Round
%performing Xnor operation with K2
dec{6,1}=not(xor(K2,dec{5,1}));
%Using f f_function and Xor operation obtain second 16 bit block
dec{6,2}=xor(f_fun(dec{5,1}),dec{5,2});
%Performing xnor operation on last 16 bit
dec{6,4}=not(xor(K2,dec{5,4}));
%Using f f_function and Xor operation obtain third 16 bit block
dec{6,3}=xor(f_fun(dec{5,4}),dec{5,3});

% for fifth Round
%Step no 01
%Swaping Blocks
dec{7,1}=dec{6,2};
dec{7,2}=dec{6,1};
dec{7,3}=dec{6,4};
dec{7,4}=dec{6,3};
%Step no 02
%performing xnor operation in first 16 bits with K1
dec{8,1}=not(xor(K1,dec{7,1}));
% Using f f_function and swaping tecniques on 16 bit
dec{8,3}=xor(f_fun(dec{7,1}),dec{7,2});
%performing xnor operation in last 16 bits with K1
dec{8,4}=not(xor(K1,dec{7,4}));
% Using f f_function and swaping tecniques on 16 bit
dec{8,2}=xor(f_fun(dec{7,4}),dec{7,3});


% %% Modification
% dec{8,1}=dec{3,1};
% dec{8,2}=dec{3,2};
% dec{8,3}=dec{3,3};
% dec{8,4}=dec{3,4};

bin_msg=[dec{8,1},dec{8,2},dec{8,3},dec{8,4}];