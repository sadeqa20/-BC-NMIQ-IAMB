function cl= kmean( a,m,n,K )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
 cn=ceil(randperm(n));
cn=cn(1:K);
c=a(cn(1:K),:);
stop=0;clust_2=0;
while(stop~=1)
d(1:n,1:K)=0;
for i=1:n
    for j=1:K
         s=0;
        for k=1:m
          s=s+(a(i,k)-c(j,k))^2;
        end
           d(i,j)=sqrt(s);   
    end       
end
N(1:K)=0;
for i=1:n
  [mm n_min]=min(d(i,:));
  N(n_min)= N(n_min)+1; 
  clust(n_min,N(n_min))=i;
end
if(min(size(clust_2)==size(clust)))
stop=min(min(clust_2==clust));
end
clust_2=clust;
for i=1:K
    s=0;
    for j=1:N(i)
        s=s+a(clust(i,j),:);
    end
    c(i,:)=s/N(i);
end
end
cl(1:n)=0;
for j=1:K
for i=1:N(j)
cl(clust(j,i))=j;
end
end
end

