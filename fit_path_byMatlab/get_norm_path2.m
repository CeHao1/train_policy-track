function [X,Y,F]=get_norm_path2(policy,Ss)
S1=Ss(1);
S2=Ss(2);
S3=Ss(3);
F1=S1/S2;
F3=S3/S2;
F=[F1,F3];

track.Center.X=linspace(-F1,1+F3,2000);
track.Center.Y=linspace(0,0,2000);

track.WL=0.1;
track.WR=0.1;

track.Left.X=track.Center.X;
track.Left.Y=linspace(1,1,2000)*track.WL;

track.Right.X=track.Center.X;
track.Right.Y=linspace(-1,-1,2000)*track.WR;

path.PX=[-F1,0,1,1+F3];
path.S=[0,F1,F1+1,F1+1+F3];
path.PY=policy*track.WL;

%%
len=F1+1+F3;

Vx=0.01;
dT=1;
Np=floor(len/Vx);
Ns=3;
Nc=2;

%x=[X,Y,Vy]
Ac=[[0 0 0];
       [0 0 1];
       [0 0 0]];
Bc=[[1 0];
       [0 0];
       [0 1]];

Ad=eye(size(Ac))+Ac*dT;
Bd=Bc*dT;

w_ay=1000;
w_Y=0.01;

cvx_begin quiet
variables x(Ns,Np+1) u(Nc,Np)
% J=x(2,2:Np+1)-x(2,1:Np);

minimize(norm(x(3,:))+w_ay*norm(u(2,:))+w_Y*norm(x(2,:)))

subject to
u(1,:)==Vx*ones(1,Np); 

x(1,1)==path.PX(1);
for i=1:4
    ind=floor(path.S(i)/Vx)+1;
    x(2,ind)==path.PY(i);
    
end

for i=1:Np
    x(:,i+1)==Ad*x(:,i)+Bd*u(:,i);
end

-ones(1,Np+1)*track.WR<=x(2,:)<=ones(1,Np+1)*track.WL

cvx_end

X=x(1,:);
Y=x(2,:);


% figure
% hold on
% plot(track.Center.X,track.Center.Y,'b');
% plot(track.Left.X,track.Left.Y,'m');
% plot(track.Right.X,track.Right.Y,'m');
% plot(X,Y,'k','linewidth',2);
% 
% plot(path.PX,path.PY,'ro')
% hold off
% 
% axis equal
% axis off
% pause(0.01)
end