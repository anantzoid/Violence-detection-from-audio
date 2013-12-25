load train.mat;
load y.mat;
%This is for NN
load yy.mat;

train1 = [train yy y];
rand('state',0)
train1 = train1(randperm(size(train1,1)),:);

train = train1(:,1:128);
yy = train1(:,129:130);
y = train1(:,end);

%%
batch = 2;
epoch = 1;
classes = 2;
layers = 2;
dim = 96;
arch = [128 112 96];

sae = saesetup(arch);
for i=1:layers
    sae.ae{i}.activation_function       = 'sigm';
    sae.ae{i}.learningRate              = 0.5;
    %sae.ae{i}.inputZeroMaskedFraction   = 0.5;
end

opts.numepochs =   epoch;
opts.batchsize = batch;
sae = saetrain(sae,train,opts);

nn = nnsetup([arch 2]);
nn.activation_function              = 'sigm';
nn.learningRate                     = 0.5;
for i=1:layers 
    nn.W{i} = sae.ae{i}.W{1};
end
 
% Train the FFNN
opts.numepochs =   epoch;
opts.batchsize = batch;
nn = nntrain(nn, train, yy, opts);


for i=1:layers
   train = [ones(size(train,1),1) train];
   train = sigmoid(train * nn.W{i}');
end

train = [train y];
%% 5 fold cross validation

seg1 = train(1:160,:);
seg2 = train(161:320,:);
seg3 = train(321:480,:);
seg4 = train(481:640,:);
seg5 = train(641:end,:);
 
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


%%
c = 3;
sigma = exp(2);

svmstruct1 = svmtrain(t1(:,1:dim),t1(:,end) ,'boxconstraint',c,'rbf_sigma',sigma,'kernel_function','rbf'); 
group1 = svmclassify(svmstruct1,cv1(:,1:dim));
score1 = measures(group1,cv1(:,end));

svmstruct2 = svmtrain(t2(:,1:dim),t2(:,end) ,'boxconstraint',c,'rbf_sigma',sigma,'kernel_function','rbf'); 
group2 = svmclassify(svmstruct2,cv2(:,1:dim));
score2 = measures(group2,cv2(:,end));

svmstruct3 = svmtrain(t3(:,1:dim),t3(:,end) ,'boxconstraint',c,'rbf_sigma',sigma,'kernel_function','rbf'); 
group3 = svmclassify(svmstruct3,cv3(:,1:dim));
score3 = measures(group3,cv3(:,end));
 
svmstruct4 = svmtrain(t4(:,1:dim),t4(:,end) ,'boxconstraint',c,'rbf_sigma',sigma,'kernel_function','rbf'); 
group4 = svmclassify(svmstruct4,cv4(:,1:dim));
score4 = measures(group4,cv4(:,end));
 
svmstruct5 = svmtrain(t5(:,1:dim),t5(:,end) ,'boxconstraint',5,'rbf_sigma',exp(3),'kernel_function','rbf'); 
group5 = svmclassify(svmstruct5,cv5(:,1:dim));
score5 = measures(group5,cv5(:,end));
 
(score1(1,5)+score2(1,5)+score3(1,5)+score4(1,5)+score5(1,5))/5
(score1(1,4)+score2(1,4)+score3(1,4)+score4(1,4)+score5(1,4))/5