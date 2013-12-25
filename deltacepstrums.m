load('data.mat');
D = data;
[row col] = size(data);

previous = zeros(13,1);
next = zeros(13,1);

delta = zeros(13,1);

new_D = zeros(26, col);

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
  
   new_D(:,i) = [D(:,i) ; delta];
end

save ('deltadata.mat','new_D')