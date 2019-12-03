% This function first shifts each image center based on scanning
% coordinate, since the FPAData simulates optical system with scanner
% stage. Then, the electric field is retrieved by adding 0 phase onto even
% order rings and pi phase onto odd order rings. Finally, a fft is
% performed with respect to image plane coordinates.
%Function input:
%   FPAData: image plane intensity data;
%   a: scanning step size;
%   l: effective pixel size (pixle size/ optical magnification)
%   Step: scanning step;
%   Numrings: number of order rings that used for high resolution image;
%   NA: numerical aperture;
%   Lamda: wavelength;
%Function output:
%   G: 4-D array with last two dimentions represents the k space of image
%   plane coordinates and first two dimentions represents scanning
%   coordinates.
function G=K4D(FPAData,a,l,Step,Numrings,NA,Lamda)
N=size(FPAData);
G=zeros((N(1)+1)/2,(N(2)+1)/2,N(3),N(4)); 
x0=(N(1)-1)/4+1;
y0=(N(1)-1)/4+1;
for i=1:N(3)
    for j=1:N(4)
        G1=FPAData(:,:,i,j);
        G1=fftshift(fft2(G1));
        A=KShift(a,l,N,i,j,Step);
        G1=G1.*A;
        G1=abs(ifft2(G1));
        G1=GetEfieldNew(G1,Numrings,NA,Lamda,l,round(x0+(i-1)*a*Step/l),round(y0+(j-1)*a*Step/l));
        G1=G1((N(1)+1)/2-(N(1)-1)/4:(N(1)+1)/2+(N(1)-1)/4,(N(1)+1)/2-(N(1)-1)/4:(N(1)+1)/2+(N(1)-1)/4);
        G(:,:,i,j)=fftshift(fft2(G1));
    end
end