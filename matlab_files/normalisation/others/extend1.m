clc;clear
close all

load('Tokyo')
load('Tokyo_seg');
seg=seg2;
clear seg2

%%

std_track=standard_track2();

policy=[-0.2,-0.9,0.9,-0.8];
[X,Y]=get_norm_path(policy,[1,1,1]);

t=1:length(X);
pp=spline(t,[X;Y]);
% dpp=fnder(pp,1);

t2=linspace(1,length(X),length(std_track.X));
r=ppval(pp,t2);
% dr=ppval(dpp,t2);

for i=1:length(r)
    [path.X(i),path.Y(i)]=bias(std_track.X(i),std_track.Y(i),std_track.Psi(i),r(2,i));
    
end

[path.Psi,path.dist,path.Kap]=get_kap(X,Y);
figure
plot(path.Kap)

%%
figure
hold on
plot(std_track.X,std_track.Y,'b')
plot(std_track.XL,std_track.YL,'m')
plot(std_track.XR,std_track.YR,'m')

plot(path.X,path.Y,'k','linewidth',2)
% 
% plot(path.PX,path.PY,'ro',...
%      'MarkerFaceColor','r')
hold off
axis equal

