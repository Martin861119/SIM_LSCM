% This function projects 4-D k space data H back to 2-D weighted average
% grid and calucates the average value at each position.
function R=K4D2D(H,CT,TFPA,TStep,r1,r2)
N=size(CT);
M=size(TFPA);
M=M(1);
K=size(TStep);
K=K(1);
F=size(H);
R=zeros(N(1),N(2));
for i=1:M(1)
    for j=1:K(1)
        a=round(TFPA(i,1)-(F(3)+1)/2+TStep(j,1)-(F(1)+1)/2+r1*(TFPA(i,1)-(F(3)+1)/2)+r2*(TStep(j,1)-(F(1)+1)/2))+(N(1)+1)/2;
        b=round(TFPA(i,2)-(F(3)+1)/2+TStep(j,2)-(F(1)+1)/2+r1*(TFPA(i,2)-(F(3)+1)/2)+r2*(TStep(j,2)-(F(1)+1)/2))+(N(2)+1)/2;
        R(a,b)=R(a,b)+H(TStep(j,1),TStep(j,2),TFPA(i,1),TFPA(i,2));
    end
end
R=R./CT;

