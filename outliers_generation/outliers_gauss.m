function d_ = outliers_gauss(data, percent)
    nr_outliers = double(uint32((length(data) * percent)/100));
    new_data_set_ = gendatoutg(data,nr_outliers);
    d_ = new_data_set_.data;
