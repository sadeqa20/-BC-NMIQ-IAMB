function [s,MI_Index]= miauto2( XX, Y)
% Summary
%    Estimate mutual information I(X;Y) between two categorical variables X,Y
%    X,Y can be matrices which are converted into a joint variable before computation
[n m]=size(XX);
for i=1:m
    X=XX(:,i);
    [~,~,X] = unique(X,'rows');
    [~,~,Y] = unique(Y,'rows');
    [~,ar,X]=unique(X);
    arity_X=length(ar);
    [~,ar,Y]=unique(Y);
    arity_Y=length(ar);
    n = length(Y);
    table_dim = [arity_X arity_Y ];
    p_XY = accumarray([X Y ],1,table_dim)/n;

    p_X_p_Y=sum(p_XY,2) * sum(p_XY,1);

    id_non_zero = intersect(find(p_XY~=0),find(p_X_p_Y~=0));
    mis(i) = sum(sum( p_XY(id_non_zero) .* log(p_XY(id_non_zero) ./  p_X_p_Y(id_non_zero))));
end

p=1;
s=[];
t=round(sqrt(m));
alpha2=quantile(mis,t);
alpha=alpha2(1,t);
% alpha=mean(mis);
% alpha1=trimmean(mis,20);
for i=1:m
    if mis(i)>alpha
        MI(p)=mis(i);
        MI_Index(p)=i;
        s(:,p)=XX(:,i);
        p=p+1;
    end
end


