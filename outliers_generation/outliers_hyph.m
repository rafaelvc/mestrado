function d_ = outliers_hyph(data, percent, dr)
    s = length(data);
    nr_outliers = double(uint32((s*percent)/100));
    if dr == 0
        new_data_set_ = gendatout(data,nr_outliers);
    else
        new_data_set_ = gendatout(data,nr_outliers, dr);
    end
    d_ = new_data_set_.data((s+1):end,:);