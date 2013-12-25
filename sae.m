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
trainlimit = 640;
train_x = train(1:trainlimit,:);
train_y = y(1:trainlimit,:);
train_yy = yy(1:trainlimit,:);
 
test_x = train(trainlimit+1:800,:);
test_y = y(trainlimit+1:800,:);
test_yy = yy(trainlimit+1:800,:);

%%
batch = 2;
epoch = 5;
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
sae = saetrain(sae,train_x,opts);

nn = nnsetup([arch 2]);
nn.activation_function  = 'sigm';
nn.learningRate = 0.5;
for i=1:layers 
    nn.W{i} = sae.ae{i}.W{1};
end
 
% Train the FFNN
opts.numepochs =   epoch;
opts.batchsize = batch;
nn = nntrain(nn, train_x, train_yy, opts);


for i=1:layers
   train_x = [ones(size(train_x,1),1) train_x];
   train_x = sigmoid(train_x * nn.W{i}');
   
   test_x = [ones(size(test_x,1),1) test_x];
   test_x = sigmoid(test_x * nn.W{i}');
 end
%%
c = 3;
sigma = exp(2);  

svmstruct = svmtrain(train_x,train_y,'boxconstraint',c,'rbf_sigma',sigma,'kernel_function','rbf'); 
group = svmclassify(svmstruct,test_x);
score = measures(group,test_y)
