load('test_data.mat');
D = test_data;
[row col] = size(test_data);

previous = zeros(13,1);
next = zeros(13,1);

delta = zeros(13,1);


test_new_D = zeros(26, col);

for i = 1:col
    
    if i==1
        previous = D(:,i);
        next = D(:,i+1);
    
    
    elseif i==col
       previous = D(:,i-1);
        next = D(:,i); 
    else
    
    
    previous = D(:,i-1);
    next = D(:,i+1);

    end
    
   delta = next-previous;
  
   test_new_D(:,i) = [D(:,i) ; delta];
end

save ('test_deltadata.mat','test_new_D');