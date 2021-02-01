clc;clear
close all

load('Tokyo')
load('Tokyo_seg');
seg=seg2;
clear seg2

%% 
% pick 1
i=1;
[track,track_r]=seg_track(waypoint,seg,i);

policy=[0,0,0];
% std_track=standard_track(1);
path=plan_policy(policy,track_r);


%% extend

% 
figure
hold on
plot(track_r.X,track_r.Y,'b')
plot(track_r.XL,track_r.YL,'m')
plot(track_r.XR,track_r.YR,'m')

plot(path.X,path.Y,'k')
hold off
axis equal

