%This function swaps the 4-D data coordinates
function A=K4DArrSim(G)
N=size(G);
A=zeros(N(3),N(4),N(1),N(2));
for i=1:N(3)
    for j=1:N(4)
        A(i,j,:,:)=G(:,:,i,j);
    end
end