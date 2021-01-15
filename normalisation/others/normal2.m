clc;clear
close all

load('Tokyo')
load('Tokyo_seg');
seg=seg2;
clear seg2

%% 
% pick 1
i=5;
[track,track_r]=seg_track(waypoint,seg,i);

interval=10;
policies=linspace(-0.9,0.9,interval);

for iter=1:interval^3

    [c,b,a]=ind2sub([interval,interval,interval],iter);
    policy=[policies(a),policies(b),policies(c)];
    path=plan_policy(policy,track_r);
    
    [path.Psi,path.S,path.Kap]=get_kap(path.X,path.Y);
    [path.Vx,path.cost]=get_velocity(path.Kap,path.S);
    
    end_state(iter)=path.Vx(end);
    cost(iter)=path.cost;
    
end


figure
subplot(2,1,1)
plot(cost)
title('cost')

subplot(2,1,2)
plot(end_state)
title('end velocity')

[~,ind_cost]=min(cost);
[~,ind_end_state]=max(end_state);
[c,b,a]=ind2sub([interval,interval,interval],ind_cost);
policy=[policies(a),policies(b),policies(c)];

path=plan_policy(policy,track_r);
[path.Psi,path.S,path.Kap]=get_kap(path.X,path.Y);
[path.Vx,path.cost]=get_velocity(path.Kap,path.S);
%% extend

% 
figure
hold on
plot(track_r.X,track_r.Y,'b')
plot(track_r.XL,track_r.YL,'m')
plot(track_r.XR,track_r.YR,'m')

plot(path.X,path.Y,'k','linewidth',2)

plot(path.PX,path.PY,'ro',...
     'MarkerFaceColor','r')
hold off
axis equal
