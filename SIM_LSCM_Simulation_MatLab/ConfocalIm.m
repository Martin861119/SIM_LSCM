%This function calculates LSCM image by appling a pinhole filter onto the
%image plane intenity image data. 

function CFIM=ConfocalIm(FPAData,R)
N=size(FPAData);
CFIM=zeros(N(3),N(4));
for i=1:N(3)
    for j=1:N(4)
        A=FPAData((N(1)+1)/2-R:(N(1)+1)/2+R,(N(1)+1)/2-R:(N(1)+1)/2+R,i,j);
        C=A(:);
        X=sum(C);
        CFIM(i,j)=X;
    end
end

