% This function calculates the point spread function of a given optical system. 
function P=PSF(lamda,NA,N,l)
x0=floor((N+1)/2);
P=zeros(N,N);
for i=1:N
    for j=1:N
        if ((i-x0)^2+(j-x0)^2)==0
            P(i,j)=1;
        else
            P(i,j)=2*besselj(1,2*pi*NA*sqrt((i-x0)^2+(j-x0)^2)*l/(lamda))/(2*pi*NA*sqrt((i-x0)^2+(j-x0)^2)*l/(lamda));
        end
    end
end