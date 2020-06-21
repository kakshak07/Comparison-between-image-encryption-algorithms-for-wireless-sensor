function i = fun(a)
b=cell(6,4);
%Arrangent of 16bits into 4,4 Bit Blocks
b{1,1}=a(1:4);
b{1,2}=a(5:8);
b{1,3}=a(9:12);
b{1,4}=a(13:16);
% Left Shifthing on each 4bit block
b{2,1}=b{1,1};
b{2,2}=circshift(b{1,2},[1 1]);
b{2,3}=circshift(b{1,3},[1 2]);
b{2,4}=circshift(b{1,4},[1 3]);
%performing And operation
b{3,1}=b{2,1};
b{3,2}=and(b{3,1},b{2,2});
b{3,3}=and(b{3,2},b{2,3});
b{3,4}=and(b{3,3},b{2,4});
s=cell(1,4);
s{1,1}=['0','f','2','d';'d','2','b','4';'8','7','2','d';'d','2','3','c'];
s{1,2}=['0','1','c','f';'f','8','5','0';'0','9','4','f';'f','0','d','0'];
s{1,3}=['0','e','c','0';'0','8','e','4';'8','e','4','0';'0','0','e','c'];
s{1,4}=['0','1','3','0';'0','7','1','4';'8','1','8','0';'0','f','1','c'];
% for Identifying the row and colomb within s-boxes
for r=1:length(s)
row=[b{3,r}(1,1),b{3,r}(1,4)];
col=[b{3,r}(2:3)];
x(r)=bin2dec(int2str(row))+1;
y(r)=bin2dec(int2str(col))+1;                               
end
%substitute the value identified by s-boxes
  for r=1:length(s)
      b{4,r}=s{1,r}(x(r),y(r));
  end
%coverstion of hex no into bin no 
for j=1:length(s)
    b{5,j}=logical([]);
    b{5,j}=[b{5,j} h2b(b{4,j})];
end
%performing OR operations on 4 bit blocks
b{6,1}=b{5,1};
b{6,2}=or(b{6,1},b{5,2});
b{6,3}=or(b{6,2},b{5,3});
b{6,4}=or(b{6,3},b{5,4});

%for Final 16 bit
i=[b{6,1},b{6,2},b{6,3},b{6,4}];
end