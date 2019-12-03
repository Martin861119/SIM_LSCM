% This function performs 2D fourier transform on 4-D data with respect to first
% two coordinates. It only perform FFT onto the coordinates specified in T.
function H=K4D2(G,T)
N=size(G);
M=size(T);
H=zeros(N(1),N(2),N(3),N(4));
for i=1:M(1)
    H(:,:,T(i,1),T(i,2))=fftshift(fft2(G(:,:,T(i,1),T(i,2))));
end
