load('train.mat');
load('y.mat');
train = [train y];
train = train(randperm(size(train,1)),:);
seg = int8(size(train,1)/5);

seg1 = train(1:160,:);
%train = train(seg:end,:);
seg2 = train(161:320,:);
%train = train(seg:end,:);
seg3 = train(321:480,:);
%train = train(seg:end,:);
seg4 = train(481:640,:);
%train = train(seg:end,:);
seg5 = train(641:800,:);


t1 = [seg1; seg2; seg3; seg4];
cv1 = seg5;
t2 = [seg1; seg2; seg3; seg5];
cv2 = seg4;
t3 = [seg1; seg2; seg4; seg5];
cv3 = seg3;
t4 = [seg1; seg3; seg4; seg5];
cv4 = seg2;
t5 = [seg2; seg3; seg4; seg5];
cv5 = seg1;

x1 = t1(5,:);
x2 = t5(100,:);   
c=[exp(-5) exp(-4) exp(-3) exp(-2) exp(-1) exp(0) exp(1) exp(2) exp(3) exp(4) exp(5)];
y=[3 4 5 6 7 8 9 10 11 12 13];
x=[exp(-5) exp(-4) exp(-3) exp(-2) exp(-1) exp(0) exp(1) exp(2) exp(3) exp(4) exp(5)];
prterr = zeros(11,11);
    for i=1:length(c)
      for k= 1:length(c)
    for j=1:5
        varname = [int2str(j)];
        eval(['model' varname '=svmtrain(t' varname '(:,1:128),t' varname '(:,129),''rbf_sigma'',c(i),''boxconstraint'',x(k),''kernel_function'',''rbf'');']);
        eval(['group' varname '=svmclassify(model' varname ',cv' varname '(:,1:128));']);
        eval(['error' varname '= mean(double(group' varname '~= cv' varname '(:,129)));']);
    
    end
    
     avg = (error1+error2+error3+error4+error5)/5 ; 
     prterr(i,k)=avg;
     
%      for j=1:5
%         varname = [int2str(j)];
%         eval(['model' varname '=svmtrain(t' varname '(:,1:128),t' varname '(:,129),''polyorder'',2,''kernel_function'',''polynomial'');']);
%         eval(['group' varname '=svmclassify(model' varname ',cv' varname '(:,1:128));']);
%         eval(['error' varname '= mean(double(group' varname '~= cv' varname '(:,129)));']);
%     
%     end
%     
%      avg = (error1+error2+error3+error4+error5)/5
%       prterr(1,k)=avg;
%      
   
%      disp = avg1;
%     for j=1:5
%         varname = [int2str(j)];
%         eval(['model' varname '=svmTrain(t' varname '(:,1:64),t' varname '(:,end),name,type);']);
%         eval(['group' varname '= svmPredict(model' varname ',cv' varname '(1:64));']);
%         eval(['error' varname '= mean(double(group' varname '~= cv' varname '(:,end)));']);
%    
%        
%     end
%    avg2 = (error1+error2+error3+error4+error5)/5  ;  
%    disp = [disp; avg2];      
%     for j=1:5
%         varname = [int2str(j)];
%         eval(['model' varname '=svmTrain(t' varname '(:,1:128),t' varname '(:,129),c(i), @(x1, x2) sum(x1 .* x2));']);
%         eval(['group' varname '= svmPredict(model' varname ',cv' varname '(:,1:128));']);
%         eval(['error' varname '= mean(double(group' varname '~= cv' varname '(:,129)));']);
%         
%     end
%     
%     avg3 = (error1+error2+error3+error4+error5)/5;
%     prterr(2,i)=avg3;
%     disp = [disp; avg3];
    end
    end
prterr
 

