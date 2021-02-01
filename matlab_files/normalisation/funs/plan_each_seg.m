function [end_pos,end_Vx]=plan_each_seg(init_pos,init_Vx,num_corner,waypoint,seg)


[track,track_r]=seg_track(waypoint,seg,num_corner);

interval=3;
bnd=[-ones(3,1),ones(3,1)];
% binary searching

policies=cell(1,3);
for i=1:3
    policies{i}=linspace(bnd(i,1),bnd(i,2),interval);
end
    
% init_pos=0;
% init_Vx=30;

for iter_binary=1:3
    
    for iter=1:interval^3
    [p(3),p(2),p(1)]=ind2sub([interval,interval,interval],iter);
    policy=[init_pos,policies{1}(p(1)),policies{2}(p(2)),policies{3}(p(3))];
    
    path=extend_normal(policy,track);
    [path.Psi,path.S,path.Kap]=get_kap(path.X,path.Y);
    [path.Vx,path.cost]=get_velocity(path.Kap,path.S,init_Vx);
    
    end_state(iter)=path.Vx(end);
    cost(iter)=path.cost;

%     if rem(iter,10)==0
%         iter
%     end
    end
    
    
    [~,ind_cost]=min(cost);
    [~,ind_end_state]=max(end_state);
    [p(3),p(2),p(1)]=ind2sub([interval,interval,interval],ind_cost);
    policy=[init_pos,policies{1}(p(1)),policies{2}(p(2)),policies{3}(p(3))];
    best_policy=policy;
    
    for i=1:3
        bnd(i,1)=(policies{i}(max(p(i)-1,1))+policies{i}(p(i)))/2;
        bnd(i,2)=(policies{i}(min(p(i)+1,interval))+policies{i}(p(i)))/2;
        
        policies{i}=linspace(bnd(i,1),bnd(i,2),interval);
    end
    
   
end

path=extend_normal(best_policy,track);
[path.Psi,path.S,path.Kap]=get_kap(path.X,path.Y);
[path.Vx,path.cost]=get_velocity(path.Kap,path.S,init_Vx);

end_pos=best_policy(end);
end_Vx=path.Vx(end);


%%

figure
subplot(2,1,1)
plot(cost)
title('cost')

subplot(2,1,2)
plot(end_state)
title('end velocity')


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


pause(0.01)
end