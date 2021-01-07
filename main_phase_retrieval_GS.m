%Content/purpose:Using Gerchberg Saxton or DPAC algorithms to achieve phase retrieval by AS diffraction theory
%Parameters:'iteration_number' the number of iteration
%           'lambda' wavelength,
%           'p' pixelsize,
%           'z' diffraction distance
%Output:    'I' image of the result achieved by the recovered phase
%Author:    Wei Chen-2020-11-16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%basic parameters
clear;
tic
nm=1e-9;um=1e-6;mm=1e-3;
lambda1=[638,520,450].*nm;
p=8*um;
z=100*mm;
iteration_number=100; 
M=1200;
N=1920;

image_name='GT_14.png';
intensity_target3=imread(image_name); 
intensity_target3=im2double(intensity_target3); 
amplitude_target3=sqrt(intensity_target3);        %the amplitude of the target.

[m,n,o]=size(intensity_target3);
intensity_input=ones(M,N);                      %the amplitude of the input.
intensity_input=im2double(intensity_input); 
global Uz;
figure(1),subplot(1,3,1),imshow(intensity_target3),title('the intensity of the target image');
I=ones(M,N,o);
phase_hologram=ones(M,N,o);
PSNR_mean=ones(1,o);
SSIM_mean=ones(1,o);

for i=1:3
    %the amplitude of the different color layers of target.              
    amplitude_target=amplitude_target3(:,:,i);
    amplitude_target=padarray(amplitude_target,[(M-m)/2,(N-n)/2]);
    lambda=lambda1(i);
   
    %the additional random phase.                                    
    phase=rand(M,N); 
    phase=im2double(phase);                           %Map the image gray level to 0～1.
    phase=phase*2*pi;                                 %Phase range is mapped to 0-2*pi.
    phase(phase>pi)=phase(phase>pi)-2*pi;             %Phase range is mapped to [-pi,+pi].

    %the original phase of the input
    estimate_input=intensity_input.*exp(1i*phase);
    intensity_out=propagation_PSF(estimate_input,z,p,lambda,'AS'); 
    phase1=angle(Uz);

    %start
    estimate_input=intensity_input.*exp(1i*phase1);
    for k=1:iteration_number
        propagation_PSF(estimate_input,z,p,lambda,'AS');
        output_ang=angle(Uz);                                         
        estimate_output=amplitude_target.*exp(1i*output_ang);                         
        propagation_PSF(estimate_output,-z,p,lambda,'AS');                        
        input_ang=angle(Uz); 
        estimate_input=intensity_input.*exp(1i*input_ang);  
    end
    phase_hologram(:,:,i)=input_ang;
    reconstruction_input=intensity_input.*exp(1i*phase_hologram(:,:,i));
    I(:,:,i)=propagation_PSF(reconstruction_input,z,p,lambda,'AS');
    PSNR_mean(i)=PSNR(amplitude_target.^2,I(:,:,i));
    SSIM_mean(i)=SSIM(amplitude_target.^2,I(:,:,i));
end
PSNR_mean=mean(PSNR_mean);
SSIM_mean=mean(SSIM_mean);
char=['PSNR=',num2str(PSNR_mean),'    ','SSIM=',num2str(SSIM_mean)];
figure(1),subplot(1,3,2),imshow(I),title('the retrieval intensity of the output image'),xlabel(char);
figure(1),subplot(1,3,3),imshow(phase_hologram),title('the phase of the hologram');
toc
