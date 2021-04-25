function [Hx,Hy,MIxy,MIxx]=statistics(X,y)
[L,C]=size(X);
%entropy of each feature:
Hx=zeros(C,1);
for k=1:C
    Hx(k)=entropia2([X(:,k)';zeros(1,L)],15);
end
%output entropy:
Hy=entropia2([y';zeros(1,L)],15);
%Hy=entropia2(y,15);
%mutual information between features and output:
MIxy=zeros(C,1);
for k=1:C
    MIxy(k)=Hx(k)+Hy-entropia2([X(:,k),y],15);
end
%mutual information between features:
MIxx=zeros(C,C);
for k=1:C
    k
    for n=1:k
        if not(n==k)
            MIxx(k,n)=Hx(k)+Hx(n)-entropia2([X(:,k)';X(:,n)'],15);
            MIxx(n,k)= MIxx(k,n);
        else
            MIxx(n,n)=1;
        end
    end
end
