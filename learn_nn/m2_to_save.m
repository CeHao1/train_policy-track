% clc;clear 
% close all


%% 
data=[policies,Fs];

targets=[];
num_intp=100;

for i =1:num_pts
    F1=Fs(i,1);
    F2=Fs(1,2);
    x1=linspace(-F1,0,num_intp);
    x2=linspace(0,F2,num_intp);
    x3=linspace(F2,1,num_intp);
    targets(i,:)=spline(r{i,1}.X,r{i,1}.Y,[x1,x2,x3]);
    
end

% save('train_data','train_data')
% save('train_targets','train_targets')
save('train_both','data','targets')

