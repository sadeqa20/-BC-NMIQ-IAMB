%%
% Load one of the provided dataset, e.g.
clear all; close all;clc;
% data=load('./Datasets/ovarian.mat');data=data.data;
% data=load('./Datasets/CNS.mat');data=data.a;
data=load('./Datasets/Leukemia.mat');data=data.a;
% data=load('./Datasets/Colon.mat');data=data.a;
% data=load('./Datasets/Leukemia_3c.mat');data=data.a;
% data=load('./Datasets/MLL.mat');data=data.a;
% data=load('./Datasets/Lymphoma.mat');data=data.a;
% data=load('./Datasets/Leukemia_4c.mat');data=data.a;
% data=load('./Datasets/SRBCT.mat');data=data.a;
% data=load('./Datasets/Lung.mat');data=data.a;

%%
X_data=data(:,1:end-1);
Y_labels=data(:,end);

M=max(Y_labels);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Pre-process the data %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transform multi-class problems to binary in 1-vs-all strategy
% X_data = preprocess_data(X_data);
disp('------------------disc equalwidth-----------------------')
X_data_c = disc_dataset_equalwidth(X_data,M);

disp('------------------K-means-----------------------')
K=M;
[p q]=size(X_data);
nn=0;
for i=1:q   
    aa=X_data(:,i);
    c=kmean( aa,1,p,K );
    X_data_Kmean(:,i)=c';
end
  disp('------------------calculate linkage-----------------------');  
for i=1:size(X_data,2)
    z=X_data(:,i);
    c=linkage(z,'ward','euclidean'); 
    X_data_complete(:,i)=cluster(c,'maxclust',K);
end
%%
disp('-------------------calculate complete ACC---------');
[ACC_DISC,ACCSVM_DISC]=Acc(X_data_c,Y_labels);
[ACC_Kmeans,ACCSVM_Kmeans]=Acc(X_data_Kmean,Y_labels);
[ACC_Complete,ACCSVM_Complete]=Acc(X_data_complete,Y_labels);
final_ACC_Complete={[ACC_DISC],[ACC_Kmeans],[ACC_Complete]}
Final_ACC_Complete=cell2mat(final_ACC_Complete);

%%

disp('------------------calculate Best Clustering-----------------------')
for i=1:q
    X_cluster_data=X_data_c(:,i);
    X_Kmeans_data=X_data_Kmean(:,i);
    X_data_link=X_data_complete(:,i);
    
    X_cluster(:,i)=mi(X_cluster_data,Y_labels);
    X_Kmeans(:,i)=mi(X_Kmeans_data,Y_labels);
    X_data_linkage(:,i)=mi(X_data_link,Y_labels);
    
    
    if X_cluster(:,i)>=X_Kmeans(:,i)
        if X_cluster(:,i)>=X_data_linkage(:,i)
           X_data_final(:,i)=X_cluster_data;
        else
            X_data_final(:,i)=X_data_link;
        end
    else
        if X_Kmeans>=X_data_linkage
           X_data_final(:,i)=X_Kmeans_data(:,i);
        else
            X_data_final(:,i)=X_data_link;
        end
    end
    
end

X_data=X_data_final;
%%
disp('------------------calculate feature selection with MIA-----------------------')
[X_MIA MIindex]=miauto(X_data,Y_labels);
disp('Selected features using MIA with the correctly reported unobserved (ideal) features:')
disp(MIindex)
%%
disp('------------------calculate feature selection with IAMB-----------------------')
CMDIAMB=IAMB(X_MIA,Y_labels,0.5);
X_IAMB=X_MIA(:,CMDIAMB);
IAMBindex=MIindex(:,CMDIAMB);
disp('selected features using IAMB wit MIA features');
disp(IAMBindex)


%%
disp('calculate Accuracy')

[Acc_kol,AccSVM_kol]=Acc(X_data,Y_labels);
Acc_MIA=Acc(X_MIA,Y_labels);
Acc_IAMB=Acc(X_IAMB,Y_labels);


final_GenSelect_ACC={[Acc_kol],[Acc_MIA],[Acc_IAMB]}
Final_Gen_ACC=cell2mat(final_GenSelect_ACC);


