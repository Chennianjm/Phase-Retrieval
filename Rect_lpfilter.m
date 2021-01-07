function H = Rect_lpfilter(U0,p,f,lambda)
%purpose:make a filter that only passes zero frequency components
%Input:'U0'frequency distribution 
%       'f 'focal length
%       'p'pixelsize
%       'lambda'wavelength
%Output:'H' filter that only passes zero frequency components
%Author:Wei Chen-2020-10-14
[M,N]=size(U0);
a=floor(f*lambda/p/p);    %size of the cutoff frequency diameter size.
b=a;
P=ones(a,b);
H=zeros(M,N);
H(floor((M-a)/2):(floor((M-a)/2)+a-1),floor((N-b)/2):(floor((N-b)/2)+b-1))=P;
H=im2double(H);
H=H/max(max(H));
end