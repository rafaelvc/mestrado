
% Normalize data columns into [-1,1] scale 

function nm_data = normalize(data)
   
    max_ = max(data);
    min_ = min (data);
    n = size(data,1);
    
    nm_data = -1.0 + ( abs(data-repmat(min_,n,1))  .* repmat((2.0 ./ abs(max_ - min_)),n,1) );
    
    
%     nm_data = [];
%     col = 1;
%     
%     for e=data(1,:) 
%         min_c = min(data(:,col));
%         max_c = max(data(:,col));
%         cl_ = []; 
%         for i=data(:,col) 
%             value = (2.0 * ((i - min_c) / (max_c - min_c))) - 1.0;
%             cl_ = [cl_; value];
%         end
%         nm_data = [nm_data cl_];
%         col = col + 1;
%     end
    
        
        
    
    