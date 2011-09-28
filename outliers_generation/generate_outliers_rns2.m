function [outliers_ini,outliers,outliers_filtered,clock_ini,clock_end] = generate_outliers_rns2(data, dradius, dage, decayrate, eta, knears, ndetectors, runs)

    [row,col] = size(data);
    n0 = eta;
    % detectors = getdata( gendatgauss(ndetectors, [ zeros(1,col) ]) );
    
    %Uniform distribution betwen max(data) and min(data)
    mind = min(data);
    maxd = max(data);
    detectors = repmat(mind,ndetectors,1) + (repmat(maxd,ndetectors,1)-repmat(mind,ndetectors,1)).*(rand(ndetectors,col));
       
    outliers_ini = detectors;
    age_detectors = zeros(1,ndetectors);
    
    clock_ini = clock;
    while runs > 0
        i = 1;
        for d=detectors'
            [nearcells,refs,kdist] = knearest_andras([data;detectors],d',knears);
            if kdist < dradius
            
                if age_detectors(i) > dage     
                    % detectors(i,:) = getdata( gendatgauss(1, [ zeros(1,col) ]) );
                    
                    %Uniform distribution betwen max(data) and min(data)
                    detectors(i,:) = mind + (maxd-mind).*(rand(1,col));
                    age_detectors(i) = 0;
                else
                    dir = ((d' - nearcells(1,:)) / norm( d' - nearcells(1,:) ));
                    detectors(i,:) = d' + (eta * dir);        
                    age_detectors(i) = age_detectors(i) + 1;
                end
                
            else
                
                % Bring back detector to the closer normal sample, should
                % be reverse to the move away operation
                % [nearcells,refs,kdist] = knearest_andras(data,d',knears);
                % dir = ((d' - nearcells(1,:)) / norm( d' - nearcells(1,:) ));
                % detectors(i,:) = d' - (eta * dir);
                
                age_detectors(i) = 0;
                
               
                % age_detectors(i) = age_detectors(i) - 1;
            end
            i = i + 1;
        end
        eta = n0 * exp((-1.0 * (runs-1.0))/decayrate);
        runs = runs - 1;
    end
    clock_end = clock;
    outliers = detectors;
    
    outliers_filtered = [];
    for d=detectors'
        i = 1;
        [nearcells,refs,kdist] = knearest_andras(data,d',knears);
        if kdist > dradius
            outliers_filtered = [outliers_filtered;d'];
        end
    end
        
    
    return;
        

