function [M1,M2]=checkerboard(m,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Purpose:Generate two complementary checkerboard matrices.
%Parameters: 'm*n' size of the checkerboard;
%Output: M1、M2:two complementary checkerboard matrices.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=zeros(m+1,n+1);
b=(m+1)*(n+1);
for i=1:2:b
I(i)=1;
end
M1=I(1:m,1:n);
M0=ones(m,n);
M2=M0-M1;



