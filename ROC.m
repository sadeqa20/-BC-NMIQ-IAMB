function ROC(Featurs,Targets)
% Featurs = data(:,1:end-1);
% Targets = data(:,end);                
file_no=1;
while file_no<=1
     TPR=[];FPR=[];Precision=[];Recall=[];
    threshold_range=0:0.001:1;
    for d=threshold_range
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
        
%         test_bw=im2bw(image,d);
%         truth_bw=im2bw(image_truth,d); %��0��1����Χ�ڵ�ֵ����ֵd��ֵ������ʵֵ���
        test_bw=DTree(TestFeaturs,TrainFeaturs,TrainTargets);
        truth_bw=TestTargets;
        
      
        TP=sum(truth_bw==1 & test_bw==1);   %������Ѱ�ø�ֵ������������==1����ֱ�����
        FN=sum(truth_bw==1 & test_bw==2);
        FP=sum(truth_bw==2 & test_bw==1);
        TN=sum(truth_bw==2 & test_bw==2);
        TPR=[TPR,TP/(TP+FN)];
        FPR=[FPR,FP/(FP+TN)];
        Precision=[Precision,TP/(TP+FP)];
        Recall=[Recall,TP/(TP+FN)];
    end
    
    FPR=sort(FPR,'descend');TPR=sort(TPR,'descend');
    L=(abs(FPR-0)<0.001 &abs(TPR-0)<0.001);
    FPR(L)=[];TPR(L)=[];
    FPR=[1,FPR,0];TPR=[1,TPR,0];
    FPR=fliplr(FPR);TPR=fliplr(TPR);   
    
%    
%     L=(abs(Recall-0)<0.0001 &abs(Precision-0)<0.0001);
%     Recall(L)=[];Precision(L)=[];  
%     Recall=[1,Recall,0];Precision=[0,Precision,1];
%     Recall=fliplr(Recall);Precision=fliplr(Precision);  %���ҽ�����������
%     
%   
    i=1;AUC=0;%0.9841
    while i<length(FPR)
        if FPR(i+1)-FPR(i)~=0
            S_trapezoid=(TPR(i)+TPR(i+1))*(FPR(i+1)-FPR(i))/2;  %С�������
            AUC=AUC+S_trapezoid;
        end
        i=i+1;
    end   
    i=1;PR_AUC=0;  %0.8707
%     while i<length(Recall)  %ֻҪRecall��С���󼴿�
%         if Recall(i+1)-Recall(i)~=0
%             S_trapezoid=(Precision(i)+Precision(i+1))*(Recall(i+1)-Recall(i))/2;  %С�������
%             PR_AUC=PR_AUC+S_trapezoid;
%         end
%         i=i+1;
%     end
    
    FPR_array{file_no}=FPR;TPR_array{file_no}=TPR;
    Recall_array{file_no}=Recall;Precision_array{file_no}=Precision;
    AUC_array{file_no}=AUC;PR_AUC_array{file_no}=PR_AUC;
%     micro_P_array{file_no}=sum(Precision)/length(Precision);
%     micro_R_array{file_no}=sum(Recall)/length(Recall);
%     micro_F1_array{file_no}=...
%         (2*micro_P_array{file_no}*micro_R_array{file_no})/(micro_P_array{file_no}+micro_R_array{file_no})
%         
    file_no=file_no+1;
end

% Featurs = dataIAMB(:,1:end-1);
% Targets = dataIAMB(:,end);                
file_no=2;
while file_no<=2
     TPR=[];FPR=[];Precision=[];Recall=[];
    threshold_range=0:0.001:1;
    for d=threshold_range
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
        
%         test_bw=im2bw(image,d);
%         truth_bw=im2bw(image_truth,d); %��0��1����Χ�ڵ�ֵ����ֵd��ֵ������ʵֵ���
        test_bw=DTree(TestFeaturs,TrainFeaturs,TrainTargets);
        truth_bw=TestTargets;
        
      
        TP=sum(truth_bw==1 & test_bw==1);   %������Ѱ�ø�ֵ������������==1����ֱ�����
        FN=sum(truth_bw==1 & test_bw==2);
        FP=sum(truth_bw==2 & test_bw==1);
        TN=sum(truth_bw==2 & test_bw==2);
        TPR=[TPR,TP/(TP+FN)];
        FPR=[FPR,FP/(FP+TN)];
%         Precision=[Precision,TP/(TP+FP)];
%         Recall=[Recall,TP/(TP+FN)];
    end
    
    FPR=sort(FPR,'descend');TPR=sort(TPR,'descend');
    L=(abs(FPR-0)<0.001 &abs(TPR-0)<0.001);
    FPR(L)=[];TPR(L)=[];
    FPR=[1,FPR,0];TPR=[1,TPR,0];
    FPR=fliplr(FPR);TPR=fliplr(TPR);   
    
%    
%     L=(abs(Recall-0)<0.0001 &abs(Precision-0)<0.0001);
%     Recall(L)=[];Precision(L)=[];  
%     Recall=[1,Recall,0];Precision=[0,Precision,1];
%     Recall=fliplr(Recall);Precision=fliplr(Precision);  %���ҽ�����������
%     
%   
    i=1;AUC=0;%0.9841
    while i<length(FPR)
        if FPR(i+1)-FPR(i)~=0
            S_trapezoid=(TPR(i)+TPR(i+1))*(FPR(i+1)-FPR(i))/2;  %С�������
            AUC=AUC+S_trapezoid;
        end
        i=i+1;
    end   
    i=1;PR_AUC=0;  %0.8707
%     while i<length(Recall)  %ֻҪRecall��С���󼴿�
%         if Recall(i+1)-Recall(i)~=0
%             S_trapezoid=(Precision(i)+Precision(i+1))*(Recall(i+1)-Recall(i))/2;  %С�������
%             PR_AUC=PR_AUC+S_trapezoid;
%         end
%         i=i+1;
%     end
    
    FPR_array{file_no}=FPR;TPR_array{file_no}=TPR;
    Recall_array{file_no}=Recall;Precision_array{file_no}=Precision;
    AUC_array{file_no}=AUC;PR_AUC_array{file_no}=PR_AUC;
%     micro_P_array{file_no}=sum(Precision)/length(Precision);
%     micro_R_array{file_no}=sum(Recall)/length(Recall);
%     micro_F1_array{file_no}=...
%         (2*micro_P_array{file_no}*micro_R_array{file_no})/(micro_P_array{file_no}+micro_R_array{file_no})
%         
    file_no=file_no+1;
end



% һ��ROC����
h_roc=figure('Name','ROC')
hold on
for i=1:length(FPR_array)
    plot(FPR_array{i},TPR_array{i},'LineWidth',1.1)
    
end
text(0.8,0.18*0.7,[' AUC=',num2str(AUC_array{1})],'color','b')
text(0.8,0.07*1,[' AUC=',num2str(AUC_array{2})],'color','r')
% text(0.5,0.55-0.1*3,['threshold-DT=',num2str(threshold)]);
line([0,1], [0,1], 'LineWidth', 2, 'Color', 'b');
xlabel('False Positive Rate'),ylabel('True Positive Rate');axis([0,1,0,1]);title('ROC curve Colon-DT');
% lgd = legend({'AUC=','AUC=',},'FontSize',12,'TextColor','blue')
grid on; grid minor;box on;