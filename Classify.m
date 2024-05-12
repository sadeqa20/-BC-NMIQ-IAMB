function [acc_rf,Recall_rf,Precision_rf,fmeasure_rf,acc_dt,Recall_dt,Precision_dt,fmeasure_dt,acc_knn,Recall_knn,Precision_knn,fmeasure_knn,TPR_rf,FPR_rf,TPR_dt,FPR_dt,TPR_knn,FPR_knn,TestAccuracy]=Classify(data,Y_labels)
Featurs = data;
Targets = Y_labels;
                
%% Test and Train Data
TrPercent = 70;NSamples = numel(Targets);
TrNum = round(NSamples * TrPercent / 100);
TsNum = NSamples - TrNum;

R = randperm(NSamples);
trIndex = R(1 : TrNum);
tsIndex = R(1+TrNum : end);

TrainFeaturs = Featurs(trIndex,:);
TrainTargets = Targets(trIndex,:);

TestFeaturs = Featurs(tsIndex,:);
TestTargets = Targets(tsIndex,:);

%% Classify

    %% Apply k-Fold
 if max(Y_labels)==2
%     N = numel(TrainTargets);
%     K = 2; % k-Fold
%     CrossValIndices = CrossValInd(N,K);
    %% Set Template SVM

    temsvm = templateSVM('KernelFunction','linear','BoxConstraint',1,...
                         'KernelScale' ,'auto','CacheSize',1000);
    %% Train Algorithm
    training=TrainFeaturs;
    group=TrainTargets;
    valid=TrainFeaturs;
      label=TrainTargets;
      
% %     Accuracy = zeros(1,K);
% %     for i = 1:K
% % 
% %         training = TrainFeaturs(CrossValIndices~=i,:);
% %         group = TrainTargets(CrossValIndices~=i);
% %         valid = TrainFeaturs(CrossValIndices==i,:);
% %         label = TrainTargets(CrossValIndices==i);
        svm = fitcecoc(training,group,'Learners',temsvm);
        Class = predict(svm,valid);
        B = confusionmat(label,Class);
        S = sum(diag(B));
% %         Accuracy(i) = S/numel(label);
        Accuracy = S/numel(label);
% %     end
    TrainAccuracy = mean(Accuracy);
    %% Test Data

    [Class,score] = predict(svm,TestFeaturs);
    B = confusionmat(TestTargets,Class);
    S = sum(diag(B));
    TestAccuracy = S/numel(TestTargets);
%     figure,plotconfusion((TestTargets'+1)/2,(Class'+1)/2);
 else
     TestAccuracy=0;
 end
    %%
%-------------Decision Tree---------------
DT=DTree(TestFeaturs,TrainFeaturs,TrainTargets);
accd=confusionmat(TestTargets,DT);
[acc_dt,Recall_dt,Precision_dt,fmeasure_dt,TPR_dt,FPR_dt]  = peformance( accd ,1 );
% acc_dt=sum(sum(diag(accd)))/test_count;
% % disp('==========================');
% % disp(acc_dt);

%-------------Random Forest----------------
rforest=randomforest(TestFeaturs,TrainFeaturs,TrainTargets);
accr=confusionmat(TestTargets,rforest);
[acc_rf,Recall_rf,Precision_rf,fmeasure_rf,TPR_rf,FPR_rf]  = peformance( accr ,1 );
% acc_rf=sum(sum(diag(accr)))/test_count;
% % disp('==========================');
% % disp(acc_rf);


%--------------KNN----------------
knnModel=fitcknn(TrainFeaturs,TrainTargets,'NumNeighbors',4);
      pred=knnModel.predict(TestFeaturs);
      sk=pred;
      acckn=confusionmat(TestTargets,sk);
      [acc_knn,Recall_knn,Precision_knn,fmeasure_knn,TPR_knn,FPR_knn]  = peformance( acckn ,1 );
%       acc_knn=sum(sum(diag(acckn)))/test_count;
% %       disp('==========================');
% %       disp(acc_knn);
