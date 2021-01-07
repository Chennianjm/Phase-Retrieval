function I = propagation_PSF(U0,z,p,lambda,method)
%purpose:Solve the light field distribution after propagation by scalar diffraction theory
%Input:'U0'Complex amplitude distribution on  rear surface of len
%       'z 'propagation distance
%       'p'pixelsize
%       'lambda'wavelength
%       'method' string like 'Fresnel','AS','Fraunhofer'
%Output:'I'the light intensity distribution after propagation
%Author:Wei Chen-2020-10-14
[M,N]=size(U0);

Lx=N*p;
Ly=M*p;
Lx1=lambda*z/p;
Ly1=lambda*z/p;

x0=linspace(-Lx/2,Lx/2,N); 
y0=linspace(-Ly/2,Ly/2,M);
[X0,Y0]=meshgrid(x0,y0);  %cordinate in object surface

x1=linspace(-Lx1/2,Lx1/2,N);
y1=linspace(-Ly1/2,Ly1/2,M);
[X1,Y1]=meshgrid(x1,y1);  %cordinate in image surface

fx = linspace(-1/2/p,1/2/p-1/Lx,N);   % cordinate in spatial frequency domain
fy = linspace(-1/2/p,1/2/p-1/Ly,M);
[fx,fy]=meshgrid(fx,fy);
k = 2*pi/lambda;
global Uz;
    
if(strcmp(method,'AS'))           % Angular Specturm method
    H=exp(1i*k*z*sqrt(1-(lambda*fx).^2-(lambda*fy).^2));
    U1_FT=fftshift(fft2(fftshift(U0)));
    Uz=ifftshift(ifft2(ifftshift(H.*U1_FT)));
elseif(strcmp(method,'Fresnel'))  % Fresnel method
    c=exp(1i*k/2/z*(X0.^2+Y0.^2));
    Oc=U0.*c;
    FOc=fftshift(fft2(Oc));
    Z=exp(1i*k/2/z*(X1.^2+Y1.^2));
    Uz=Z.*FOc;    
elseif(strcmp(method,'Fraunhofer')) % Fraunhofer method
    FO=fftshift(fft2(U0));
    Z=exp(1i*k/2/z*(X1.^2+Y1.^2));
    Uz=Z.*FO; 
else
    errordlg('Type of transfer function must be <AS> , <Fresnel> or <Fraunhofer>','Error');
end
I=Uz.*conj(Uz);
I=I./max(max(I));
end