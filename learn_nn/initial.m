clc;clear 
close all


num_pts=1000;
num_policy=20;
num_F=20;
a=round(rand(num_pts,1)*num_policy^4*num_F^2);


sz=[num_F,num_F,num_policy,num_policy,num_policy,num_policy];
[p(1,:),p(2,:),p(3,:),p(4,:),f(1,:),f(2,:)]=ind2sub(sz,a);


policy_base=linspace(-1,1,num_policy);
F_base=linspace(0,1,num_F);

policies=policy_base(p);
Fs=F_base(f);

