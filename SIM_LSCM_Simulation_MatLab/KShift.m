%This function shifts the image by applying proper phase to image k space
function A=KShift(a,l,N,I,J,Step)
A=zeros(N(1),N(2));
for i=1:N(1)
for j=1:N(2)
A(i,j)=exp(1i*((i-(N(1)+1)/2)*((N(1)-1)/4-((I-1)*Step*a/l))+(j-(N(1)+1)/2)*((N(1)-1)/4-((J-1)*Step*a/l)))*2*pi/N(1));
end
end