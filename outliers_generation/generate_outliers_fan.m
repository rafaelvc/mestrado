function outliers = generate_outliers_fan(data)

    [row,col] = size(data);
    outliers = [];
    freqval  = []; 
    
    for i=1:col
    
           val_unique_col = unique(data(:,i));         
           countMax = 0;
           for val=val_unique_col'
               indices = find( data(:,i) == val );
               [r_indices, c_indices] = size(indices);
               count = r_indices;
               freqval = [freqval; count];
               if count > countMax 
                   countMax = count;
               end
           end
           
           minv_col = min(data(:,i));
           maxv_col = max(data(:,i));
           
           for freq=freqval'
               
               newout = 0;
               while ((abs(freq - countMax) - newout)  > 0) 
                   out_i = data( round(1 + (row-1)*rand(1)), :);            
                   rand_v = minv_col + (maxv_col-minv_col) * rand(1);   
                   while (rand_v == out_i(:,i))
                       rand_v = minv_col + (maxv_col-minv_col) * rand(1);
                   end
                   out_i(:,i) = rand_v;
                   outliers = [outliers; out_i];   
                   newout = newout + 1;
               end 
          
           end 
        
    end
    