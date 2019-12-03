% This function calculates the pupil function.
function T=circlecut(dk,K,N)
T=zeros(N,N);
k0=floor((N+1)/2);
for i=1:N
    for j=1:N
        if sqrt((i-k0)^2+(j-k0)^2)*dk<=K
            T(i,j)=1;
        else
            T(i,j)=0;
        end
    end
end