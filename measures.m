function [scores] = measures(group,y1)
    mismatch = sum(abs(group-y1));
%     rmse = sqrt((sum((group-y1) .^ 2))/size(cases,2));
    tp=0;fp=0;fn=0;tn=0;
    for i=1:size(y1,1)
        if y1(i,1)== group(i,1) && y1(i,1)==1
            tp = tp+1;
        elseif y1(i,1)== group(i,1) && y1(i,1)==0
            tn = tn+1;
        elseif y1(i,1)~= group(i,1) && y1(i,1)==1
            fn = fn+1;
        else
            fp = fp+1;
        end
    end
    prec = tp/(tp+fp);
    recall = tp/(tp+fn);
    fscore = 2*(prec*recall)/(prec+recall);
    accu= (tp+tn)/(tp+tn+fp+fn);    
    scores = [mismatch prec recall fscore accu];
end