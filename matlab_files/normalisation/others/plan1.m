clc;clear;
close all

load('Tokyo')
load('Tokyo_seg');
seg=seg2;
clear seg2

%%

num_corner=3;
[track,track_r]=seg_track(waypoint,seg,num_corner);

% policy=-[-0.2,-0.9,0.9,-0.8];

interval=3;
policies=linspace(-1,1,interval);
init_pos=0;
init_Vx=30;

for iter=1:interval^3
    [c,b,a]=ind2sub([interval,interval,interval],iter);
    policy=[init_pos,policies(a),policies(b),policies(c)];
    
    path=extend_normal(policy,track);
    [path.Psi,path.S,path.Kap]=get_kap(path.X,path.Y);
    [path.Vx,path.cost]=get_velocity(path.Kap,path.S,init_Vx);
    
    end_state(iter)=path.Vx(end);
    cost(iter)=path.cost;

    if rem(iter,10)==0
        iter
    end
end


%%
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
policy=[init_pos,policies(a),policies(b),policies(c)];

path=extend_normal(policy,track);
[path.Psi,path.S,path.Kap]=get_kap(path.X,path.Y);
[path.Vx,path.cost]=get_velocity(path.Kap,path.S,init_Vx);

figure
hold on
plot(track.X,track.Y,'b')
plot(track.XL,track.YL,'m')
plot(track.XR,track.YR,'m')

plot(path.X,path.Y,'k','linewidth',2)

plot(path.X(1),path.Y(1),'ko','linewidth',1)

% plot(path.PX,path.PY,'ro',...
%      'MarkerFaceColor','r')
hold off
axis equal
