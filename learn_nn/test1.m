% clc;clear
% close all


policy=[0,-0.6,0.6,-0.6];
F=[0.3,0.5];

[track,path]=construct_normal_path(policy,F);


%%

figure
hold on
plot(track.Center.X,track.Center.Y,'b')
plot(track.Left.X,track.Left.Y,'b')
plot(track.Right.X,track.Right.Y,'r')

plot(path.X,path.Y,'k','linewidth',2)
plot(path.PX,path.PY,'ro')

hold off
axis equal