for i=1:450
    if i<10
        fv = 'featurevector000';
    elseif i<100    
        fv = 'featurevector00';
    else
        fv = 'featurevector0';
    end
    filename = strcat('training_features\',fv,num2str(i),'.mat');
    load(filename);
    if i==1
        train = x;
        y = 1;
        yy = [1 0];
    else
        train = [train x];
        y = [y;1];
        yy = [yy;1 0];
      end
end
for i=1:270
    if i<10
        fv = 'featurevector100';
    elseif i<100    
        fv = 'featurevector10';
    else
        fv = 'featurevector1';
    end    
    filename = strcat('training_features\',fv,num2str(i),'.mat'); 
    load(filename);
        train = [train x];
        y = [y;0];
        yy = [yy;0 1];
    
end    
 
train = train';
save y.mat y;
%Deciciosn Tree
tree= ClassificationTree.fit(train,y);    
%SVM
svmstruct = svmtrain(train,y,'kernel_function','quadratic');
%model1= svmTrain(t1(:,1:64),t1(:,end) ,c(i), @(x1, x2) gaussianKernel(x1, x2, sigma)); 
%Random Forest
treebag = TreeBagger(50,train,y);
%Boosted Tree
btree = fitensemble(train,y,'AdaBoostM1',100,'tree');


init = 451;
cases = init:500;
for j=cases
    
    if j<10
        fv = 'featurevector000';
    elseif j<100    
        fv = 'featurevector00';
    else
        fv = 'featurevector0';
    end 
    filename = strcat('training_features\',fv,num2str(j),'.mat'); 
    load(filename);
    if j==init
        test = x;
        y1 = 1;
        yy1 = [1 0];
    else
        test = [test x];
        y1 = [y1;1];
        yy1 = [yy1;1 0];
    end
end    

cases = 271:300;
for j=cases    
    if j<10
        fv = 'featurevector100';
    elseif j<100  
        fv = 'featurevector10';
    else
        fv = 'featurevector1';
    end
    filename = strcat('training_features\',fv,num2str(j),'.mat'); 
    load(filename);
    test = [test x];
    y1 = [y1;0];
    yy1 = [yy1;0 1];    
end
test = test';


train = [train; test];
y = [y; y1];
yy = [yy; yy1];
save train.mat train;
save y.mat y;
save yy.mat yy;

% %D Tree
group = predict(tree,test);
[scores] = measures(group,y1);
results = scores;

% %SVM
group = svmclassify(svmstruct,test);
[scores] = measures(group,y1);
results = [results;scores];
%Random
group = str2double(predict(treebag,test));
[scores] = measures(group,y1);
results = [results;scores];

%BTree
group = predict(btree,test);
[scores] = measures(group,y1);
results = [results;scores];


cnames = {'Mismatch','Precision','Recall','F score','Accuracy'};
rnames = {'Decision Trees','SVM','Random Forests','Boosted Tree'};
f = figure('Position',[200 500 800 150]);
tab = uitable('Data',results,'ColumnName',cnames,...
    'RowName',rnames,'Position',[50 50 700 100]);