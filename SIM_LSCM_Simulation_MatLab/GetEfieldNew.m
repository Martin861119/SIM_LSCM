% This function retrieve the electric field information by applying a phase
% onto different ring order areas.The program segments the intensity image
% into connected binary rings by single thresholding method. Then applies 0 
% phase to even orders and pi phase to odd orders.
% Function input:
%   I: intensity image;
%   NumRings: maximum order of ring structures needed to detect;
%   NA: numerical aperture;
%   Lambda: wavelength;
%   l: pixel size;
%   x0, y0: PSF center coordinates on intensity image;
%Function output:
%   E: Retrieve electric field information based on intensity image.

function E=GetEfieldNew(I,NumRings,NA,Lambda,l,x0,y0)
N=size(I);
A=[0, 5.42365, 8.59453, 11.7486, 14.8972, 18.0432, 21.188, 24.3319, 27.4753, 30.6183];
B=zeros(N(1),N(2),NumRings);
E=zeros(N(1),N(2));
for k=1:NumRings
   for i=1:N(1)
    for j=1:N(2)
        if (2*pi*NA*sqrt((i-x0)^2+(j-y0)^2)*l/(Lambda))<=A(k)
            B(i,j,k)=1;
        else
            B(i,j,k)=0;
        end
    end
   end
end
T=I;
for i=1:5
T=imsharpen(T);
end
level = graythresh(T);
BW=im2bw(T,level);
for i=1:NumRings
    Q=BW.*B(:,:,i);
    [X,Y]=find(Q==1);
    BW1 = bwselect(BW,Y,X,4);
    BW=BW-BW1;
    if ((-1)^(i+1))>0
         E=E+BW1;
    else E=E-BW1;
    end
        
end
E=E.*(I.*I);