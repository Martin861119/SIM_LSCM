% This function calculates the SIM-LSCM image (SIM) and confocal microscopy image (CFIM)
% Function input:
% FPAData: 4-D image field intensity data;
% Lamda: wavelength;
% NA: Optical system Numerical Aperture;
% a: scanning step size;
% l: effective pixel size (pixle size/ optical magnification)
% Step: scanning step;
% Numrings: number of order rings that used for high resolution image
% reconstruction;
% Function output:
% SIM: reconstructed SIM-LSCM image;
% CFIM: LSCM image with 0.9um pinhole size;

function [SIM, CFIM]=SIMPost(FPAData,Lamda,NA,a,l,Step,Numrings)
%% This section setup the paramters.
N=size(FPAData);
NFPA=N(1);
NStep=N(3);
U=sqrt(sqrt(FPAData));
disp('Parameter Setup finished...')
%% This section retrieve the electric field image and applies fourier transform
%%with respect to image field coordinates.  
G=K4D(U,a,l,Step,Numrings,NA,Lamda);
%% This section calculates the weighted average k space parameters. 
%%In order to save calculation time, this program only calculates the meaningful 
%%data that locates inside Numerical aperture inside k-space 
M=size(G);
M=M(1);
K=2*pi*NA/(Lamda);%maximum k-space info from the lens cut
dk=2*pi/(M*l);%FPA k space
dk2=2*pi/(NStep*Step*a);%step scanning space
Ak=(dk*M+dk2*NStep)/(M+NStep);%weighted average k-space
r1=Ak/dk-1;
r2=Ak/dk2-1;
T=[];%FPA k-space indeces after cut%
T2=[];%scanning k-space indeces after cut%
for i=1:M
    for j=1:M
        if sqrt((i-((M+1)/2))^2+(j-((M+1)/2))^2)*dk<=K
            T=[T;i,j];
        else
        end
    end
end
for i=1:NStep
    for j=1:NStep
        if sqrt((i-((NStep+1)/2))^2+(j-((NStep+1)/2))^2)*dk2<=K
            T2=[T2;i,j];
        else
        end
    end
end
disp('First Fourier of px, py finished...')
%% This section swaps the 4-D data coordinates and prepare for fourier transform 
%%with resepct to scanning coordinate.
G1=K4DArrSim(G);
disp('4D data indices swap finished...')
%% This section performs fourier transform with respecet to scanning step coordinate.
H=K4D2(G1,T);
disp('Second Fourier of kx, ky finished...')
%% This section counts the number of data points at each weighted average grid spot
%%This counter is used for calculate average number in reciprocal space. 
CT=KCounter(T,T2,M,NStep,r1,r2);
disp('Counter Matrix Generated...')
%% This section projects 4-D reciprocal space data back to 2-D weighted average grid space. 
R=K4D2D(H,CT,T,T2,r1,r2);
n = size(R);
m = round((NStep - n(1))/2);
R = ImPad(R,m, m, m, m);
%% This section calculates the final SIM-LSCM and LSCM image results. 
SIM = abs(ifft2(R)).^2/max(max(abs(ifft2(R)).^2));
CFIM = ConfocalIM(FPAData, 3);