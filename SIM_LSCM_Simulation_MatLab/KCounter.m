% This function calculates the number of samples at each weight average
% grid. To save calculation time, only quarter of the k space is
% calculated.

function CT=KCounter(T,T2,NFPA,NStep,r1,r2)
M=size(T2);
M=M(1);
Y=[];
for i=1:M
    A=round(T(:,1)-(NFPA+1)/2+T2(i,1)-(NStep+1)/2+r1*(T(:,1)-(NFPA+1)/2)+r2*(T2(i,1)-(NStep+1)/2));
    B=round(T(:,2)-(NFPA+1)/2+T2(i,2)-(NStep+1)/2+r1*(T(:,2)-(NFPA+1)/2)+r2*(T2(i,2)-(NStep+1)/2));
    C=[A,B];
    Y=[Y;C];
end
V=max(Y(:,1))+1;
CT1=zeros(V,V);
for i=1:V %use the symetric of the counter, do the calc in 1/4 of the space%
    for j=1:V
        C=find(Y(:,1)==(i-1) & Y(:,2)==(j-1));
        L=size(C);
        CT1(i,j)=L(1);
    end
end
CT=zeros((V-1)*2+1,(V-1)*2+1);
CT(1:V,1:V)=flipud(fliplr(CT1));
CT(V:2*V-1,1:V)=fliplr(CT1);
CT(1:V,V:2*V-1)=flipud(CT1);
CT(V:2*V-1,V:2*V-1)=CT1;
CT(CT==0)=1;
