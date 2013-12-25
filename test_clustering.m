bins = 128;
load test_deltadata.mat;
load centroids.mat;
x=test_new_D';
[test_idx,test_C]=kmeans(x,bins,'distance','city','emptyaction','drop','start',C,'replicates',1);
save test_delta_idx.mat test_idx;

load 'test_delta_idx.mat';
cutoff = 200;
for k=1:10
    for i=1:29
        X = test_idx(1:cutoff, 1);    
        test_idx = test_idx(cutoff+1:end, 1);
        x=zeros(bins,1);
        for j=1:bins
            x(j) = sum(X==j);
        end
        folder = strcat('audio',int2str(k));
        filename = 'features_';
        filename= strcat(filename,int2str(i));
        filename = strcat('testfeatures\',folder,'\',filename);
        name = strcat(filename,'.mat');
        x = x ./ sum(x);
        save (name, 'x');
    end
    i=30;
    X = test_idx(1:198, 1);
    test_idx = test_idx(199:end, 1);
    x=zeros(bins,1);
    for j=1:bins
            x(j) = sum(X==j);
    end
    folder = strcat('audio',int2str(k));
    filename = 'features_';
    filename= strcat(filename,int2str(30));
    filename = strcat('testfeatures\',folder,'\',filename);
    name = strcat(filename,'.mat');
    x = x ./ sum(x);
    save (name, 'x');
end




