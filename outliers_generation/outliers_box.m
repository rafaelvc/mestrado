function d_ = outliers_box(data, percent)
    s = length(data);
    nr_outliers = double(uint32((s*percent)/100));
    new_data_set_ = gendatblockout(data,nr_outliers);
    d_ = new_data_set_.data((s+1):end,:);