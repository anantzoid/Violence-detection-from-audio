bins = 128;
load deltadata.mat;

x=new_D';
idx=kmeans(x,bins);
save delta_idx.mat idx;

load 'delta_idx.mat';
for i=1:500
    load 'dimensions.mat';
    cutoff = dimensions(i);
    X = idx(1:cutoff, 1);    
    idx = idx(cutoff+1:end, 1);
    x=zeros(bins,1);
    for j=1:bins
        x(j) = sum(X==j);
    end
    if(i<10)
        filename = '000';
    elseif (i<100)
        filename = '00';
    else
        filename = '0';
    end
    filename= strcat(filename,int2str(i));
    filename = strcat('training_features\','featurevector',filename);
    name = strcat(filename,'.mat');
    x = x ./ sum(x);
    save (name, 'x');
end

for i=1:300
    load 'dimensions.mat';
    cutoff = dimensions(1000+i);
    X = idx(1:cutoff, 1);    
    idx = idx(cutoff+1:end, 1);
    x=zeros(bins,1);
    for j=1:bins
        x(j) = sum(X==j);
    end
    if(i<10)
         filename = '100';
    elseif (i<100)
         filename = '10';
    else
        filename = '1';  
    end
    filename= strcat(filename,int2str(i));
    filename = strcat('training_features\','featurevector',filename);
    name = strcat(filename,'.mat');
    x = x / sum(x);
    save (name, 'x');
end

% compare hist code
load 'delta_idx.mat';
[counts,binValues]= hist(idx(1:269045),bins);
normalised_count = 100*counts/sum(counts);
bar(binValues,normalised_count,'barwidth',1);
figure;
[counts,binValues]= hist(idx(269046:550000),bins);
normalised_count = 100*counts/sum(counts);
bar(binValues,normalised_count,'barwidth',1);
