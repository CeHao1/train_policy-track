clc;clear;
close all

load('Tokyo')
load('Tokyo_seg');
seg=seg2;
clear seg2

%%

% num_corner=3;
% [track,track_r]=seg_track(waypoint,seg,num_corner);
track=standard_track2();

init_pos=0;
init_Vx=0.1;

interval=3;
bnd=[-ones(3,1),ones(3,1)];
% binary searching

policies=cell(1,3);
policies{1}=linspace(bnd(1,1),bnd(1,2),interval);
policies{2}=linspace(bnd(2,1),bnd(2,2),interval);
policies{3}=linspace(bnd(3,1),bnd(3,2),interval);
    

tic
for iter_binary=1:1
    
    for iter=1:interval^3
    [c,b,a]=ind2sub([interval,interval,interval],iter);
    policy=[init_pos,policies{1}(a),policies{2}(b),policies{3}(c)];
    
    path=extend_normal(policy,track);
    [path.Psi,path.S,path.Kap]=get_kap(path.X,path.Y);
    [path.Vx,path.cost]=get_velocity(path.Kap,path.S,init_Vx);
    
    end_state(iter)=path.Vx(end);
    cost(iter)=path.cost;

    if rem(iter,10)==0
        iter
    end
    end
    
    
    [~,ind_cost]=min(cost);
    [~,ind_end_state]=max(end_state);
    [c,b,a]=ind2sub([interval,interval,interval],ind_cost);
    policy=[init_pos,policies{1}(a),policies{2}(b),policies{3}(c)];
    
    for i=1:3
        bnd(i,1)=policies{i}(max(a-1,1));
        bnd(i,2)=policies{i}(min(a+1,interval));
        
        policies{i}=linspace(bnd(i,1),bnd(i,2),interval);
    end
    
%     policies{1}=linspace(bnd(1,1),bnd(1,2),interval);
%     policies{2}=linspace(bnd(2,1),bnd(2,2),interval);
%     policies{3}=linspace(bnd(3,1),bnd(3,2),interval);
    
end

toc


%%
figure
subplot(2,1,1)
plot(cost)
title('cost')

subplot(2,1,2)
plot(end_state)
title('end velocity')



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