function [ result,recall,Precision,fmeasure,TPR,FPR ] = peformance( confusionMatrix ,param  )
    %hitung peformance classifier dengan confusion matrix

    TruePositive = zeros(length(confusionMatrix),1); 
    TrueNegative = zeros(length(confusionMatrix),1);
    FalsePositive = zeros(length(confusionMatrix),1);
    FalseNegative = zeros(length(confusionMatrix),1);
    
    for i=1:length(confusionMatrix)
        TruePositive(i) = confusionMatrix(i,i);
        TrueNegative(i) = sum(sum(confusionMatrix)) - sum(FalsePositive)-sum(FalseNegative)-TruePositive(i);
        FalsePositive(i) = sum(confusionMatrix(:,i)) - TruePositive(i);
        FalseNegative(i) = sum(confusionMatrix(i,:)) - TruePositive(i);
    end
    
    if param == 1
        result = (sum(TruePositive) + sum(TrueNegative)) /  (sum(TruePositive) + sum(TrueNegative) + sum(FalsePositive) + sum(FalseNegative)); %menghitung akurasi
        recall=sum(TruePositive)/(sum(FalseNegative)+sum(TruePositive));
        Precision=sum(TruePositive)/(sum(FalsePositive)+sum(TruePositive));
        fmeasure=(2*recall*Precision)/(Precision+recall);
        TPR=sum(TruePositive)/(sum(FalseNegative)+sum(TruePositive));
        FPR=sum(FalsePositive)/(sum(FalsePositive)+sum(TrueNegative));
    end

end