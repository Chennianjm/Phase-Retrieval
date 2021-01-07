%Content/purpose:Using  DPAC algorithms to achieve phase retrieval by AS diffraction theory
%Parameters:'lambda' wavelength
%           'p' pixelsize
%           'z' diffraction distance
%           'M*N’size of the SLM
%           'f' focal length
%Output:    'I' image of the result achieved by the recovered phase,'PSNR、SSIM'
%Author:    Wei Chen-2020-11-21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%basic parameters
clear;
tic
nm=1e-9;um=1e-6;mm=1e-3;
lambda1=[638,520,450].*nm;
p=8*um;
z=100*mm; 
f=z/4;
M=1200;
N=1920;
image_name='GT_14.png';
intensity_target3=imread(image_name); 
intensity_target3=im2double(intensity_target3); 
amplitude_target3=sqrt(intensity_target3);        %the amplitude of the target.
figure(1),subplot(1,3,1),imshow(intensity_target3),title('the intensity of the target image');

[m,n,o]=size(amplitude_target3);
I=ones(M,N,o);
intensity_input=ones(M,N);
phase_hologram=ones(M,N,o);
PSNR_mean=ones(1,o);
SSIM_mean=ones(1,o);

for i=1:3
    %the amplitude of the different color layers of target.              
    amplitude_target=amplitude_target3(:,:,i);
    amplitude_target=padarray(amplitude_target,[(M-m)/2,(N-n)/2]);   %pad the target
    lambda=lambda1(i);
   
    %the additional random phase. 
    phase=ones(M,N); 
    phase=im2double(phase);                           %Map the image gray level to 0～1.
    phase=phase*2*pi;                                 %Phase range is mapped to 0-2*pi.
    phase(phase>pi)=phase(phase>pi)-2*pi;             %Phase range is mapped to [-pi,+pi].

    %the  phase of the hologram.
    complex_target=amplitude_target.*exp(1i*phase);
    amplitude_max=max(max(amplitude_target));
    phase1=phase+acos(amplitude_target/amplitude_max);
    phase2=phase-acos(amplitude_target/amplitude_max);
    [M1,M2]=checkerboard(M,N);                        %function: checkerboard.m
    phase_hologram(:,:,i)=M1.*phase1+M2.*phase2; 
    
    %produce the recovery target intensity after the 4f system
    reconstruction_input=intensity_input.*exp(1i*phase_hologram(:,:,i)); 
    frequency=fftshift(fft2(reconstruction_input));    
    P=Rect_lpfilter(frequency,p,f,lambda);
    frequency= frequency.*P;                          %Filter that only passes zero frequency components.
    complex_ouyput=fft2(fftshift(frequency));
    complex_ouyput=rot90(complex_ouyput,2);
    I1=complex_ouyput.*conj(complex_ouyput);
    I1=I1/max(max(I1));
    I(:,:,i)=I1;
    
%     d=z-4*f;
%     I(:,:,i)=propagation_PSF(complex_ouyput,d,p,lambda,'AS');

    PSNR_mean(i)=PSNR(amplitude_target.^2,I(:,:,i));
    SSIM_mean(i)=SSIM(amplitude_target.^2,I(:,:,i));
end
PSNR_mean=mean(PSNR_mean);
SSIM_mean=mean(SSIM_mean);
char=['PSNR=',num2str(PSNR_mean),'    ','SSIM=',num2str(SSIM_mean)];
figure(1),subplot(1,3,2),imshow(I),title('the retrieval intensity of the output image'),xlabel(char);
figure(1),subplot(1,3,3),imshow(phase_hologram),title('the phase of the hologram');
toc