function [K1,K2,K3,K4,K5]=SF_Key_Gen(bin_key);
%making a cell
key= cell(5,4);
%First for matrix of 16bit each
key{1,1}=bin_key(1:16);
key{1,2}=bin_key(17:32);
key{1,3}=bin_key(33:48);
key{1,4}=bin_key(49:64);
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

%transposition colomb-wise
key{4,1}=key{3,1}';
key{4,2}=key{3,2}';
key{4,3}=key{3,2}';
key{4,4}=key{3,2}';

%performing xor operations
key{5,1}=not(xor(key{4,1},key{4,2}));
key{5,2}=xor(key{5,1},key{4,2});
key{5,3}=not(xor(key{5,2},key{4,3})); 
key{5,4}=xor(key{5,3},key{4,4});
%concatinate into 64bits
key_64=[key{5,1}(1,:),key{5,1}(2,:),key{5,1}(3,:),key{5,1}(4,:)...
key{5,2}(1,:),key{5,2}(2,:),key{5,2}(3,:),key{5,2}(4,:)...
key{5,3}(1,:),key{5,3}(2,:),key{5,3}(3,:),key{5,3}(4,:)...
key{5,4}(1,:),key{5,4}(2,:),key{5,4}(3,:),key{5,4}(4,:)];
%p-table
p=[1,17,33,49,50,34,18,2;...
    19,35,51,52,36,20,4,3;...
    37,53,54,38,22,6,5,21;...
    55,56,40,24,8,7,23,39;...
    58,42,26,10,9,25,41,57;...
    44,28,12,11,27,43,59,60;...
    30,14,13,29,45,61,62,46;...
    16,15,31,47,63,64,48,32];
%key after p-table
for j=1:8
    for k=1:8
        key_p(j,k)=key_64(p(j,k));
    end
end
%concatinated 64bitkey
p_64=[key_p(1,:),key_p(2,:),key_p(3,:),key_p(4,:)...
    key_p(5,:),key_p(6,:),key_p(7,:),key_p(8,:)];
%Making a cell 
key_1=cell(9,4);
% first four matrix of 16bit each
key_1{1,1}=p_64(1:16);
key_1{1,2}=p_64(17:32);
key_1{1,3}=p_64(33:48);
key_1{1,4}=p_64(49:64);
%Each pattern change in matrix of 4*4
key_1{2,1}(1,:)=key_1{1,1}(1:4);
key_1{2,1}(2,:)=key_1{1,1}(5:8);
key_1{2,1}(3,:)=key_1{1,1}(9:12);
key_1{2,1}(4,:)=key_1{1,1}(13:16);

key_1{2,2}(1,:)=key_1{1,2}(1:4);
key_1{2,2}(2,:)=key_1{1,2}(5:8);
key_1{2,2}(3,:)=key_1{1,2}(9:12);
key_1{2,2}(4,:)=key_1{1,2}(13:16);

key_1{2,3}(1,:)=key_1{1,3}(1:4);
key_1{2,3}(2,:)=key_1{1,3}(5:8);
key_1{2,3}(3,:)=key_1{1,3}(9:12);
key_1{2,3}(4,:)=key_1{1,3}(13:16);

key_1{2,4}(1,:)=key_1{1,4}(1:4);
key_1{2,4}(2,:)=key_1{1,4}(5:8);
key_1{2,4}(3,:)=key_1{1,4}(9:12);
key_1{2,4}(4,:)=key_1{1,4}(13:16);
%Performing shift operation

key_1{3,1}(1,:)=key_1{2,1}(1,:);
key_1{3,1}(2,:)=circshift(key_1{2,1}(2,:),[1 1]);
key_1{3,1}(3,:)=circshift(key_1{2,1}(3,:),[1 2]);
key_1{3,1}(4,:)=circshift(key_1{2,1}(4,:),[1 3]);

key_1{3,2}(1,:)=key_1{2,2}(1,:);
key_1{3,2}(2,:)=circshift(key_1{2,2}(2,:),[1 1]);
key_1{3,2}(3,:)=circshift(key_1{2,2}(3,:),[1 2]);
key_1{3,2}(4,:)=circshift(key_1{2,2}(4,:),[1 3]);

key_1{3,3}(1,:)=key_1{2,3}(1,:);
key_1{3,3}(2,:)=circshift(key_1{2,3}(2,:),[1 1]);
key_1{3,3}(3,:)=circshift(key_1{2,3}(3,:),[1 2]);
key_1{3,3}(4,:)=circshift(key_1{2,3}(4,:),[1 3]);

key_1{3,4}(1,:)=key_1{2,4}(1,:);
key_1{3,4}(2,:)=circshift(key_1{2,4}(2,:),[1 1]);
key_1{3,4}(3,:)=circshift(key_1{2,4}(3,:),[1 2]);
key_1{3,4}(4,:)=circshift(key_1{2,4}(4,:),[1 3]);

% generate fix matrix
f_mat=cell(1,4);
f_mat{1,1}=[1,2,3,1;2,3,1,1;3,1,1,2;1,1,2,3];
f_mat{1,2}=[1,2,3,1;1,1,2,3;3,1,1,2;2,3,1,1];
f_mat{1,3}=[1,2,3,1;2,3,1,1;1,1,2,3;3,1,1,2];
f_mat{1,4}=[1,2,3,1;1,1,2,3;2,3,1,1;3,1,1,2];

% multiply fix matrix #1 with shifted matrix
    for j=1:4
       for k=1:4
           tmp=(key_1{3,1}(:,j))';
           if f_mat{1,1}(j,k)==1
               key_1{4,1}(j,k)=cellstr(num2str(tmp));
           elseif f_mat{1,1}(j,k)==2
               key_1{4,1}(j,k)=cellstr(num2str(circshift(tmp,[1 1])));
           elseif f_mat{1,1}(j,k)==3
            tmp1=circshift(tmp,[1 1]);
            key_1{4,1}(j,k)=cellstr(num2str(xor(tmp,tmp1)));
           end
       end
    end

    % multiply fix matrix #2 with shifted matrix
    for j=1:4
       for k=1:4
           tmp=(key_1{3,2}(:,j))';
           if f_mat{1,2}(j,k)==1
               key_1{4,2}(j,k)=cellstr(num2str(tmp));
           elseif f_mat{1,2}(j,k)==2
               key_1{4,2}(j,k)=cellstr(num2str(circshift(tmp,[1 1])));
           elseif f_mat{1,2}(j,k)==3
            tmp1=circshift(tmp,[1 1]);
            key_1{4,2}(j,k)=cellstr(num2str(xor(tmp,tmp1)));
           end
       end
    end
    
    % multiply fix matrix #3 with shifted matrix
    for j=1:4
       for k=1:4
           tmp=(key_1{3,3}(:,j))';
           if f_mat{1,3}(j,k)==1
               key_1{4,3}(j,k)=cellstr(num2str(tmp));
           elseif f_mat{1,3}(j,k)==2
               key_1{4,3}(j,k)=cellstr(num2str(circshift(tmp,[1 1])));
           elseif f_mat{1,3}(j,k)==3
            tmp1=circshift(tmp,[1 1]);
            key_1{4,3}(j,k)=cellstr(num2str(xor(tmp,tmp1)));
           end
       end
    end
    
% multiply fix matrix #4 with shifted matrix

    for j=1:4
       for k=1:4
           tmp=(key_1{3,4}(:,j))';
           if f_mat{1,4}(j,k)==1
               key_1{4,4}(j,k)=cellstr(num2str(tmp));
           elseif f_mat{1,4}(j,k)==2
               key_1{4,4}(j,k)=cellstr(num2str(circshift(tmp,[1 1])));
           elseif f_mat{1,4}(j,k)==3
            tmp1=circshift(tmp,[1 1]);
            key_1{4,4}(j,k)=cellstr(num2str(xor(tmp,tmp1)));
           end
       end
    end
    
% shifting After fix matrix Multiplication
key_1{5,1}(1,:)=key_1{4,1}(1,:);
key_1{5,1}(2,:)=circshift(key_1{4,1}(2,:),[1 1]);
key_1{5,1}(3,:)=circshift(key_1{4,1}(3,:),[1 2]);
key_1{5,1}(4,:)=circshift(key_1{4,1}(4,:),[1 3]);

key_1{5,2}(1,:)=key_1{4,2}(1,:);
key_1{5,2}(2,:)=circshift(key_1{4,2}(2,:),[1 1]);
key_1{5,2}(3,:)=circshift(key_1{4,2}(3,:),[1 2]);
key_1{5,2}(4,:)=circshift(key_1{4,2}(4,:),[1 3]);

key_1{5,3}(1,:)=key_1{4,3}(1,:);
key_1{5,3}(2,:)=circshift(key_1{4,3}(2,:),[1 1]);
key_1{5,3}(3,:)=circshift(key_1{4,3}(3,:),[1 2]);
key_1{5,3}(4,:)=circshift(key_1{4,3}(4,:),[1 3]);

key_1{5,4}(1,:)=key_1{4,4}(1,:);
key_1{5,4}(2,:)=circshift(key_1{4,4}(2,:),[1 1]);
key_1{5,4}(3,:)=circshift(key_1{4,4}(3,:),[1 2]);
key_1{5,4}(4,:)=circshift(key_1{4,4}(4,:),[1 3]);

% Performing And Operation row Wise
for i=1:length(key_1{5,1})
tmp(i,:)=and(logical(str2num(key_1{5,1}{1,i})),logical(str2num(key_1{5,1}{2,i})));
tmp1(i,:)=and(logical(str2num(key_1{5,1}{3,i})),logical(str2num(key_1{5,1}{4,i})));
key_1{6,1}(i,:)=and(tmp(i,:),tmp1(i,:));
end

for i=1:length(key_1{5,2})
tmp(i,:)=xor(logical(str2num(key_1{5,2}{1,i})),logical(str2num(key_1{5,2}{2,i})));
tmp1(i,:)=xor(logical(str2num(key_1{5,2}{3,i})),logical(str2num(key_1{5,2}{4,i})));
key_1{6,2}(i,:)=xor(tmp(i,:),tmp1(i,:));
end

for i=1:length(key_1{5,3})
tmp(i,:)=and(logical(str2num(key_1{5,3}{1,i})),logical(str2num(key_1{5,3}{2,i})));
tmp1(i,:)=and(logical(str2num(key_1{5,3}{3,i})),logical(str2num(key_1{5,3}{4,i})));
key_1{6,3}(i,:)=and(tmp(i,:),tmp1(i,:));
end

for i=1:length(key_1{5,4})
tmp(i,:)=xor(logical(str2num(key_1{5,4}{1,i})),logical(str2num(key_1{5,4}{2,i})));
tmp1(i,:)=xor(logical(str2num(key_1{5,4}{3,i})),logical(str2num(key_1{5,4}{4,i})));
key_1{6,4}(i,:)=xor(tmp(i,:),tmp1(i,:));
end

% performing xor operation to 4x4(16 bit block)

% Result 4 bit key will be obtain

tmp=xor(key_1{6,1}(1,:),key_1{6,1}(2,:));
tmp1=xor(key_1{6,1}(3,:),key_1{6,1}(4,:));
key_1{7,1}=xor(tmp,tmp1);

tmp=xor(key_1{6,2}(1,:),key_1{6,2}(2,:));
tmp1=xor(key_1{6,2}(3,:),key_1{6,2}(4,:));
key_1{7,2}=xor(tmp,tmp1);

tmp=xor(key_1{6,3}(1,:),key_1{6,3}(2,:));
tmp1=xor(key_1{6,3}(3,:),key_1{6,3}(4,:));
key_1{7,3}=xor(tmp,tmp1);

tmp=xor(key_1{6,4}(1,:),key_1{6,4}(2,:));
tmp1=xor(key_1{6,4}(3,:),key_1{6,4}(4,:));
key_1{7,4}=xor(tmp,tmp1);

%using transposition table

trans_mat=cell(1,4);
trans_mat{1,1}=[0,0,0,0;0,0,0,1;0,0,1,0;0,0,1,1];
trans_mat{1,2}=[0,1,0,0;0,1,0,1;0,1,1,0;0,1,1,1];
trans_mat{1,3}=[1,0,0,0;1,0,0,1;1,0,1,0;1,0,1,1];
trans_mat{1,4}=[1,1,0,0;1,1,0,1;1,1,1,0;1,1,1,1];

% For First key by Transposition

for i=1:length(trans_mat)
    for j=1:length(key_1{6,1})
        if key_1{7,1}(1,:)==trans_mat{1,i}(j,:)
            if i==1
                key_1{8,1}=[key_1{6,1}(:,1),key_1{6,1}(:,4),key_1{6,1}(:,2),...
                    key_1{6,1}(:,3)];
            elseif i==2
                key_1{8,1}=[key_1{6,1}(:,2),key_1{6,1}(:,3),key_1{6,1}(:,4),...
                    key_1{6,1}(:,1)];
            elseif i==3
                key_1{8,1}=[key_1{6,1}(:,3),key_1{6,1}(:,2),key_1{6,1}(:,1),...
                    key_1{6,1}(:,4)];
            else i==4
                key_1{8,1}=[key_1{6,1}(:,4),key_1{6,1}(:,1),key_1{6,1}(:,3),...
                    key_1{6,1}(:,2)];
            end
        end
    end
end

% For Second key by Real Fence

key_1{8,2}=[key_1{6,2}(1,:);circshift(key_1{6,2}(2,:),[1 1]);...
    key_1{6,2}(3,:);circshift(key_1{6,2}(4,:),[1 1])];


% For Third key  by Real Fence

key_1{8,3}=[key_1{6,3}(1,:);circshift(key_1{6,3}(2,:),[1 1]);...
    key_1{6,3}(3,:);circshift(key_1{6,3}(4,:),[1 1])];


% For Fourth key by transposition

for i=1:length(trans_mat)
    for j=1:length(key_1{6,4})
        if key_1{7,4}(1,:)==trans_mat{1,i}(j,:)
            if i==1
                key_1{8,4}=[key_1{6,4}(:,1),key_1{6,4}(:,4),key_1{6,4}(:,2),...
                    key_1{6,4}(:,3)];
            elseif i==2
                key_1{8,4}=[key_1{6,4}(:,2),key_1{6,4}(:,3),key_1{6,4}(:,4),...
                    key_1{6,4}(:,1)];
            elseif i==3
                key_1{8,4}=[key_1{6,4}(:,3),key_1{6,4}(:,2),key_1{6,4}(:,1),...
                    key_1{6,4}(:,4)];
            else i==4
                key_1{8,4}=[key_1{6,4}(:,4),key_1{6,4}(:,1),key_1{6,4}(:,3),...
                    key_1{6,4}(:,2)];
            end
        end
    end
end

% For Final KEY K1
key_1{9,1}=[key_1{8,1}(1,:),key_1{8,1}(2,:),key_1{8,1}(3,:),key_1{8,1}(4,:)];
K1=key_1{9,1};
% For Final KEY K2
key_1{9,2}=[key_1{8,2}(:,1)',flipdim(key_1{8,2}(:,2)',2),key_1{8,2}(:,3)',...
    flipdim(key_1{8,2}(:,4)',2)];
K2=key_1{9,2};
% For Final KEY K3
key_1{9,3}=[key_1{8,3}(:,1)',flipdim(key_1{8,3}(:,2)',2),key_1{8,3}(:,3)',...
    flipdim(key_1{8,3}(:,4)',2)];
K3=key_1{9,3};
% For Final KEY K4
key_1{9,4}=[key_1{8,4}(1,:),key_1{8,4}(2,:),key_1{8,4}(3,:),key_1{8,4}(4,:)];
K4=key_1{9,4};
% For Final KEY K5
tmp=xor(K1,K2);
tmp1=xor(K3,K4);
K5=xor(tmp,tmp1);