% This function calculates field at image plane by apply pupil function with size of 2pi/lambda*NA 
function A=lenscut(I,NA,lamda,a)
N=size(I);
N=N(1);
dk=2*pi/(N*a);
K=2*pi*NA/(lamda);
T=circlecut(dk,K,N);
A=ifft2(T.*fftshift(fft2(I)));