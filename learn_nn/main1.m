% clc;clear
% close all

p=parpool();

r=cell(1);

tic
parfor i=1:num_pts
    policy=policies(i,:);
    F=Fs(i,:);
    [track,path]=construct_normal_path(policy,F);
    
    r{i,1}=path;
end
toc
delete(p)


save('result1')
%%



% figure
% hold on
% plot(track.Center.X,track.Center.Y,'b')
% plot(track.Left.X,track.Left.Y,'b')
% plot(track.Right.X,track.Right.Y,'r')
% 
% plot(path.X,path.Y,'k','linewidth',2)
% plot(path.PX,path.PY,'ro')
% 
% hold off
% axis equal