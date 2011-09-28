
% Retorna o k vizinhos mais proximos de x em data 

function [knears,refs,kdist] = knearest_andras(data, x, k) 
    
    kfair_dist = inf;
    insertion = 1;
    
    knears = [];
    kdist  = [];
    refs   = [];
    
    ref = 1;
    for y=data' 
        dist = sqrt( sum( (x - y').^2 ) );
        if dist < kfair_dist && dist > 0.0   % dist = 0, same target point 
            if insertion < k 
                knears = [knears; y'];
                kdist  = [kdist; dist];
                refs   = [refs; ref];
                insertion = insertion + 1;
            else
                if insertion == k 
                    knears = [knears; y'];
                    kdist  = [kdist; dist];
                    refs   = [refs; ref];
                    insertion = insertion + 1;
                else
                    knears(kfair_pos,:) = y';
                    kdist(kfair_pos,:) = dist;
                    refs(kfair_pos,:) = ref;
                end
                
                kfair_dist = 0;
                pos = 1; 
                for kd=kdist'                   
                    if kd > kfair_dist
                        kfair_dist = kd;
                        kfair_pos = pos; 
                    end
                    pos = pos + 1;
                end
            end
        end
        ref = ref + 1;
     end
             
    
%       pseudo-code: 
%         
%       kmaior_dist = inf
%             
%       para cada y do D
%          
%          dist = distancia x e y
%          
%          se dist < kmaior_dist
%          
%              se insercao < k
%   
%                insere y em K
%                insercao = insercao + 1
%              
%              senao
%                 
%                 se insercao = k 
%                 
%                     insere y em K
%                     insercao = insercao + 1
%                 
%                 senao 
%                 
%                      insere y na pos kmaior_pos  
%                 fimse
%                 
%                 kmaior_dist = 0 
%                 kmaior_pos = 1
%              
%                 para cada k' de K
%          
%                    se dist_k'_x > kmaior_dist 
%                    
%                         kmaior_dist = dist_k'
%                         kmaior_pos = pos
%                    
%                    fimse 
%                    pos = pos + 1
% 
%                 fimpara
%                                 
%              fimse 
%                
%          fimse
%             
%       fimpara  
      
