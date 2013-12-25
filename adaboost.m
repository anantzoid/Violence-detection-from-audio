
% %classes +1,-1
% %N = no.of file
% cls = 2;%classifiers
% alpha = zeros(cls,1);
% group = zeros(size(train,1),cls);
% wts = (1/265) * ones(size(train,1),1);
% for i=1:cls
% %     c(i)  = train(X,y,wts);
%     switch i
%         case 1
%              svmstruct =  svmtrain(train,y,'kernel_function','linear');  
%              group(:,i) = svmclassify(svmstruct,train);  
%         case 2
%              svmstruct =  svmtrain(train,y,'kernel_function','linear');  
%              group(:,i) = svmclassify(svmstruct,train);  
% 
% %              treebag = TreeBagger(50,train,y);  
% %              group(:,i) = str2double(predict(treebag,train)); 
%     end
%      
%     e = wts' * [group(:,i)~=y]; 
%     alpha(i) = 0.5 * log10((1-e)/e);
%     wts = wts .* exp(-alpha(i) .* y .* group(:,i));
%     wts = wts/sum(wts);
% 
% %     yy = predict(C(i),X);
% %     e = wts * (y ~= yy)';
% %     alpha(i) = 0.5* log(1-e)/e;
% %     wts =wts *( exp(-alpha(i)*y*yy));
% %     wts = wts/sum(wts);
% 
%     
% end 
% h = sum([alpha(1)*group(:,1) alpha(2)*group(:,2)],2);
% final = sign(h);
% alpha
