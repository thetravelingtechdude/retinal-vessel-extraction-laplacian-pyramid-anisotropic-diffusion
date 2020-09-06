function [sens,spec,acc]=evaluation(S,GT)

TP_1=zeros(size(S,1),size(S,2));
TP_1(GT==S)=1;
TP=(sum(sum(TP_1.*GT)));

FP_1=zeros(size(S,1),size(S,2));
FP_1(GT~=S)=1;
FP=(sum(sum(FP_1.*S)));

TN_1=zeros(size(S,1),size(S,2));
TN_1(GT==S)=1;
TN=(sum(sum(TN_1.*abs(S-1))));

FN_1=zeros(size(S,1),size(S,2));
FN_1(GT~=S)=1;
FN=(sum(sum(FN_1.*abs(S-1))));

TP_X = sprintf('True Positives = %d',TP);
TN_X = sprintf('True Negatives = %d',TN);
FP_X = sprintf('False positives = %d',FP);
FN_X = sprintf('False Negatives = %d',FN);

disp(TP_X);
disp(TN_X);
disp(FP_X);
disp(FN_X);


total=TP+FP+TN+FN;

%Evaluation metrics
sens = TP/(TP+ FN); %sensitivity
spec = TN/(TN+ FP); %specificity
acc = (TP+TN)/total; %accuracy
prec = TP/(TP+FP); %precision
rec = TP/(TP+FN); %recall
%f1_score = 2.*(prec.*rec)./(prec+rec);

%intersection = S & GT;
%union = S | GT;
%iou_score = sum(intersection) / sum(union);


sens_X = sprintf('SENSITIVITY = %0.6f',sens);
spec_X = sprintf('SPECIFICITY = %0.6f',spec);
acc_X = sprintf('ACCURACY = %0.6f',acc);
prec_X = sprintf('PRECISION = %0.6f',prec);
rec_X = sprintf('RECALL = %0.6f',rec);
%f1score_X = sprintf('F1 SCORE = %0.6f',f1_score);
%iou_X = sprintf('IoU = %0.6f',iou_score);



disp(sens_X)
disp(spec_X)
disp(acc_X)
disp(prec_X);
disp(rec_X);
%disp(f1score_X);
%disp(iou_score);
     
end