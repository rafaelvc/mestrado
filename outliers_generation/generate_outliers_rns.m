function [outliers,outliers0] = generate_outliers_rns(data, dradius, dage, decayrate, eta, knears, ndetectors, runs)

    [row,col] = size(data);
    
    n0 = eta;
    % detectors = rand(ndetectors,col);
    detectors = getdata( gendatgauss(ndetectors, [ zeros(1,col) ]) );
    outliers0 = detectors;
    
    % generate detectors 
%     detectors = [];
%     for i=1:nd
%         d = rand(1,col);
%         for j=1:col
%             min_col = min(data(:,j));
%             max_col = max(data(:,j));
%             d(:,j) = min_col + (max_col - min_col) * d(:,j);           
%         end 
%         detectors = [detectors; d];
%     end
    
    age_detectors = zeros(1,ndetectors);
    
    % stop criteria
    j = 1;
    while runs > 0
        i = 1;
        for d=detectors'
            
            [nearcells,refs,kdist] = knearest_andras([data;detectors],d',knears);
            
             

            % nearcell_mean = mean(nearcells,1); 
            % if isempty(nearcells) 
            %     continue
            % end
            dist = sqrt( sum( (d' - nearcell_mean).^2 ) );
            if dist < dradius
                
%               sum_d = zeros(1,col);
%               for nearc = nearcells' 
%                    sum_d = sum_d + (d' - nearc);
%               end
%               dir = sum_d  / norm(nearcells);
                
                % dir = sum( repmat(d',knears,1) - nearcells )  / norm(nearcells);
                % dir = sum( repmat(d',knears,1) - nearcells )  / knears;
                
                dir = ((d' - nearcell) / norm( d' - nearcell ));
                
                % replace the detector 
                % if age_detectors(i) > dage 
                    
%                    d = rand(1,col);
%                     for j=1:col
%                         min_col = min(data(:,j));
%                         max_col = max(data(:,j));
%                         d(:,j) = min_col + (max_col - min_col) * d(:,j);           
%                     end 
%                    detectors(i,:) = d;

                 %   detectors(i,:) = getdata( gendatgauss(1, [ zeros(1,col) ]) );
                 %   age_detectors(i) = 0;
                
                % else
                  %  age_detectors(i) = age_detectors(i) + 1;
                  %  detectors(i,:) = d' + (eta * dir);
                    
                % end
                detectors(i,:) = d' + (eta * dir);

            else
                %mu_d = 0.0;
                %for dd=detectors'
                %    mu_d = mu_d + exp(-1.0 * ((norm(d'-dd') ^ 2) / (2*(dradius^2))));
                %end 
                %mu_d = abs(1.0 - mu_d);
                
                % dir =  sum ( mu_d * ( repmat(d',ndetectors,1) - detectors ) ) / mu_d ;
                
                %dir =  mu_d / ndetectors-1 ;
                
                
                
                %detectors(i,:) = d' + eta * dir;
                % age_detectors(i) = 0;
            end
            
            i = i + 1;
        end
        
        eta = n0 * exp((-1.0 * j)/decayrate);

        
        runs = runs - 1;
        j = j + 1;
    end 
    
    outliers = detectors;
    return;

    
%     function c = mu(x)
%         c = (-1.0*eps(1)) ^ ((norm( x - r ) ^ 2)  /  (2*(r^2)));
%         return;
