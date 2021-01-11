clc;clear
close all

p=parpool();
data=cell(1);


parfor i=1:5
    a=i+2;
    data{i,1}=a;
end

delete(p)