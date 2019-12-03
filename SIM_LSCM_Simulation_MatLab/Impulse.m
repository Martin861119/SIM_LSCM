% This function generates an impulse response image.
function T=Impulse(N)
T=zeros(N,N);
T((N+1)/2,(N+1)/2)=1;