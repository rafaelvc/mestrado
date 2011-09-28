% Retorna os pontos considerados da fronteira e seus respectivos x_center

function [bound,x_center_bound,inner] = boundary_search_andras(data)
    
    bound = [];
    inner = [];
    x_center_bound = [];
    k = 8;
    j = 1;
    
    for x=data'
               
         rest = data;    % UGLY (removes x from data)
         rest(j,:) = [];
         j = j + 1;
         
         [knears,refs,kdist] = knearest_andras(rest, x', k);
         ei = [];
         for kn = knears' 
            ei = [ei; (kn' - x') / ( norm( (kn' - x') ) )];
         end
                  
         [lei,cei] = size(ei);
         samples = [ ei; x' ]; % origin x'
         labels  = [ ones(lei, 1); -1 ];
         
         % SVM - libsvm  
         % -t 0 means linear kernel
         % model = svmtrain(labels, samples, '-t 0'); 
         % [predict_label_L, accuracy_L, dec_values_L] = svmpredict(labels, samples, model);       
         % if accuracy_L(1) == 100 

             %% Gun's SVM return alpha = 0 for samples are not support vectors 
             %% We are considering model.sv_coef are the same as Gun's alpha 
             %% [tmp,index]=ismember(model.SVs, samples,'rows');
             %% alpha = zeros(size(ei),1);
             %% for i=index
             %%    if not(i == lei) %it 's the origin which does not matter
             %%     alpha(i) = model.sv_coef(i);
             %%   end
             %% end
             
             % [ nsv, alpha, bias ] = svc(samples, labels, 'linear');
             
             % bound = [bound; x'];
             % xcenter = [];
             % i = 1; 
             % for e = ei'
             %   xcenter = [xcenter;  e' * alpha(i) ];
             %   i = i + 1;
             % end
             % x_center_bound = [x_center_bound; sum(xcenter) ];
         % else
         %    inner = [inner; x'];   
         % end
         
         % SVM - Steve Guns
         samples_ = svdatanorm(samples,'linear');
         [ nsv, alpha, bias ] = svc(samples_, labels, 'linear');
         err = svcerror(samples_, labels, samples_, labels, 'linear', alpha, bias);
         % if ( lei+1 == sum( svcoutput(samples,labels,samples,'linear',alpha,bias,0) ) )
         if err == 0 
             bound = [bound; x'];
             xcenter = [];
             i = 1; 
             for e = ei'
                xcenter = [xcenter;  e' * alpha(i) ];
                i = i + 1;
             end
             x_center_bound = [x_center_bound; sum(xcenter) ];
         else
             inner = [inner; x'];   
         end
                 
    end
