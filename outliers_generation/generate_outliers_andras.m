
% Gera outliers apartir de um conjunto de dados conforme metodo do Andras

function [outliers boundary inners] = generate_outliers_andras(data, dist, curv) 
       
    [boundary, x_center, inners] = boundary_search_andras(data);
    outliers = []; 
     
    for x=data'
        
        [knears,refs,kdist] = knearest_andras(boundary, x', 4);
        kdist_sorted = sort(kdist);
        
        last_kds = -1;
        ixref = 1;
        for kds=kdist_sorted'
            
            ref = find(kdist == kds);

            % it is for situations when there are equal dists
            if last_kds == kds     
                ixref = ixref + 1;
                ref = ref(ixref);
            else
                ixref = 1;
            end
            last_kds = kds;
            
            xb = knears(ref,:);
            xb_center = x_center(refs(ref),:);
            
            CosAngle =  dot ( xb_center,  (x' - xb) )  /  ( norm(xb_center) * norm(x' - xb) );
            T = dist / (dist*curv + CosAngle);
            v = xb - x';        
            y = v * (1 + (T / norm(v))) + x'; 
            
            % busca k(5) vizinhos normais mais proximos de y
            ei = [];
            [knears_y,refs_, kdist_] = knearest_andras(inners, y, 4);
            for kny = knears_y' 
                ei = [ei; (kny' - y) / ( norm( (kny' - y) ) )];
            end
            [lei,cei] = size(ei);
            samples = [ ei; y ];
            labels  = [ ones(lei, 1); -1 ];
            
            % SVM - libsvm 
            % -t 0 means linear kernel
            % model = svmtrain(labels, samples, '-t 0'); 
            % [predict_label_L, accuracy_L, dec_values_L] = svmpredict(labels, samples, model);
            % if accuracy_L(1) == 100 
            %    outliers = [outliers; y];
            %    break;
            % end
            
            % SVM - Steve Guns
            % Se resultado da otimizacao falha nao conseguiu separar y dos
            % vizinhos, ou seja eh um exemplo normal
            [sv, alpha, bias] = svc(samples, labels, 'linear');
            err = svcerror(samples, labels, samples, labels, 'linear', alpha, bias);
            if err == 0 
                outliers = [outliers; y];
                break;
            end            
        end
        
    end
    

