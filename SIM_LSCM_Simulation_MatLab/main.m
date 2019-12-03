%This main.m file simulates the optical system scanning images at back focal plane

%% This section initialize optical system parameters, the units are in um unit.
% first set the system wavelength = 405nm, optical condenser have a NA = 0.6, the number of image size at 
% back focal plane is NxN, a is scanning step size and 
% l is the effective pixel size on target (equivalent to pixel size/magnification factor)  
Lamda=0.405; NA=0.6; N=161; a=0.15;l=0.14;
% Next we set odd number of scanning steps as NStep, step size by Step and number of pixels at image
% field plane as NFPA 
NStep=81; Step=1; NFPA=ceil(N*a/l); 
% import target varation image and change it to gray image.
T=imread('target.jpg');T=rgb2gray(T);T=im2double(T);T=T(90:(90+(N-1)/2),90:(90+(N-1)/2));
%T=Impulse(81);
% PSF function calculates Point Spread function of the system
I=PSF(Lamda,NA,N,a);
%initialize 4-D field data at plane right above target plane as ScanData, 4-D back focal plane image data FPAData
%and 4-D Reciprocal space data.
ScanData=zeros(N,N,NStep,NStep);
RawKData=zeros(NFPA,NFPA,NStep,NStep);
FPAData=zeros(NFPA,NFPA,NStep,NStep);
%% This section scans the target image with calculated PSF
disp('starting scaning...')
for i=1:NStep
    for j=1:NStep
        A=ImPad(T,(N-1)/2-(i-1)*Step,(i-1)*Step,(N-1)/2-(j-1)*Step,(j-1)*Step);
        ScanData(:,:,i,j)=A.*I;
    end
end
disp('scan finished')

%% This section calculates the back focal plane image based on image formation theory.
disp('FPA Calculation...')
for i=1:NStep
    for j=1:NStep
        C=ScanData(:,:,i,j);
        H=abs(lenscut(C,NA,Lamda,a)).^2;
        RawKData(:,:,i,j)=fftshift(fft2(abs(imresize(H,a/l))));
        FPAData(:,:,i,j)=abs(imresize(H,a/l));
    end
end
%% This section scales the back focal plane image data and digitize the image data.
U=FPAData(:);
amax=max(U);
FPAData16bit=65535*mat2gray(FPAData,[0,amax]);
FPAData16bit=uint16(FPAData16bit);
% save('stripFPAData.mat','FPAData16bit','-v7.3');
% save('stripScanData.mat','ScanData','-v7.3');
disp('FPA Calculation finished')
