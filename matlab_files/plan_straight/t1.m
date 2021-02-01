clc;clear
close all

track.Center.X=linspace(-2,2,2000);
track.Center.Y=linspace(0,0,2000);

track.WL=0.1;
track.WR=0.1;

track.Left.X=linspace(-2,2,2000);
track.Left.Y=linspace(1,1,2000)*track.WL;

track.Right.X=linspace(-2,2,2000);
track.Right.Y=linspace(-1,-1,2000)*track.WR;

policy=[0,-1,0,-1];

path.PX=[-2,0,1,2];
path.PY=policy*track.WL;

len=length(path.PX);
t=1:len;
pp=spline(t,[path.PX;path.PY]);


t2=linspace(1,len,2000);
r=ppval(pp,t2);

path.X=r(1,:);
path.Y=r(2,:);


%%

figure
hold on
plot(track.Center.X,track.Center.Y,'b');
plot(track.Left.X,track.Left.Y,'m');
plot(track.Right.X,track.Right.Y,'m');
plot(path.X,path.Y,'k','linewidth',2);

plot(path.PX,path.PY,'ro','MarkerFaceColor','r')
hold off

axis equal

