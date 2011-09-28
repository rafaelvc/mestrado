
tmp = temp1;
tmp_test = temp5;
dim = 14;
k = find ( tmp_test(:,dim) == 1 ) ;
a = size(tmp,1) ; 
igual = false;
cont = 0;

for i=k'
    for j=1:a
        if sum( tmp_test(i,:)  == tmp(j,:) ) == 14
              igual = true;
              cont = cont + 1;
        end
    end
end 
