function [outliers_ini,outliers,outliers_filtered,runs,clock1,clock2]  = generate_outliers_rns3(data, dradius, dage, decayrate, eta, knears, ndetectors, runs)

    [row,col] = size(data);
    n0 = eta;
    
    % Gaussian distribution with zero mean
    % detectors = getdata( gendatgauss(ndetectors, [ zeros(1,col) ]) );
    
    %Uniform distribution betwen max(data) and min(data)
    mind = min(data);
    maxd = max(data);
    detectors = repmat(mind,ndetectors,1) + (repmat(maxd,ndetectors,1)-repmat(mind,ndetectors,1)).*(rand(ndetectors,col));
        
    outliers_ini = detectors;
    age_detectors = zeros(1,ndetectors);

    data_ = [data;detectors];
    i = 1;
    for d=detectors' 
        dist = inf;
        normal = 1;
        for dt=data_' 
            dist_ = sqrt( sum( (dt' - d').^2 ) ); 
            if dist_ < dist && dist_ > 0
                nearest(i).dist = dist_;
                nearest(i).v = dt';
                dist = dist_; 
            end    
            normal = normal + 1;
        end
        i = i + 1;
    end 
      
       
    clock1 = clock;
    r = 1;
    while runs > 0
        % disp(clock);
        i = 1;
        for d=detectors'

            % [nearcells,refs,kdist] = knearest_andras([data;detectors],d',knears); 

            % Uses a kdtree algorithm to comput nearest (Already tested and it is slower)
            % tree = kd_buildtree([data;detectors],0);
            % [refs,nearcells,vec_vals]=kd_knn(tree,d',1,0);
            % kdist = sqrt( sum( (nearcells - d').^2 ) );
                
            kdist = nearest(i).dist;
            nearcell = nearest(i).v;
            if kdist < dradius
                
                if age_detectors(i) > dage                        
                    % Gaussian distribution with zero mean
                    % detectors(i,:) = getdata( gendatgauss(1, [ zeros(1,col) ]) );
                    %Uniform distribution betwen max(data) and min(data)
                    detectors(i,:) = mind + (maxd-mind).*(rand(1,col));
                    age_detectors(i) = 0;                   
                else
                    dir = (d' - nearcell) / norm(d' - nearcell);
                    detectors(i,:) = d' + (eta * dir);        
                    age_detectors(i) = age_detectors(i) + 1;                  
                end                
                % Update nearest new detector 
                dist = inf; 
                de = detectors(i,:);
                for dt=data'
                    dist_ = sqrt( sum( (de - dt').^2 ) ); 
                    if dist_ < dist && dist_ > 0 
                        nearest(i).dist = dist_;
                        nearest(i).v = dt';
                        dist = dist_;
                    end                        
                end
                % New detector is the nearest from another detector else
                j = 1;
                for d_=detectors' 
                    dist_ = sqrt( sum( (de - d_').^2 ) ); 
                    if dist_ < nearest(j).dist && dist_ > 0 
                        nearest(j).dist = dist_;
                        nearest(j).v = de;
                    end       
                    if dist_ < dist && dist_ > 0 
                        nearest(i).dist = dist_;
                        nearest(i).v = d_';
                        dist = dist_;
                    end                   
                    j = j + 1;
                end

            else
                age_detectors(i) = 0;
            end
            i = i + 1;
        end
        eta = n0 * exp((-1.0 * (runs-1.0))/decayrate);
        runs = runs - 1;
        if sum(age_detectors) == 0
            break
        end
        r = r + 1;
    end
    clock2 = clock; 
    outliers = detectors;
    runs = r;
    
    outliers_filtered = [];
    for d=detectors' 
        add_detector = true;
        for dt=data'
            dist = sqrt( sum( (d'-dt').^2 ) );
            if dist < dradius
                add_detector = false;
                break
            end
        end
        if add_detector
            outliers_filtered = [outliers_filtered;d'];
        end
    end
        
    return;
        

