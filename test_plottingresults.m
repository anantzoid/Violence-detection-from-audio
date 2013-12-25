load 'test_result.mat';cutoff=30;
for i=1:10
    result = group(1:cutoff,1);
    group = group(cutoff+1:end,1);
    filename= strcat('testresults\audio',int2str(i),'.mat');
    save(filename, 'result');
end

for i=1:10
    filename= strcat('testresults\audio',int2str(i),'.mat');
    load(filename);
    new = zeros(10,1);
    for j=0:9
        if(result(3*j+1,1)==1 & result(3*j+2,1)==1)
            new(j+1,1)=1;
        elseif(result(3*j+1,1)==1 & result(3*j+3,1)==1)
            new(j+1,1)=1;
        elseif(result(3*j+2,1)==1 & result(3*j+3,1)==1)
            new(j+1,1)=1;
        else
            new(j+1,1)=0;
        end
    end
    filename= strcat('testresults\audio_ten',int2str(i),'.mat');
    save(filename,'new');
end