function GM=Gaussian_matrix(m,n)    %Gaussian matrix
sigma =(m+n)/200;
x=linspace(-n/2,n/2,n);
y=linspace(-m/2,m/2,m);
[x0,y0]=meshgrid(x,y);
r = x0.^2 + y0.^2;
Z = -r / ( 2 * sigma^2 );
GM = exp(Z) / ( 2 * pi * sigma^2 );
GM=GM./max(max(GM));
figure(1);
% mesh(x,y,GM);
%可以直接调用高斯函数滤波器




