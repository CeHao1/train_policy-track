function [track,path]=construct_normal_path(policy,F)

F1=F(1);
F2=F(2);

num=200;

track.Center.X=linspace(-F1,1,num);
track.Center.Y=linspace(0,0,num);

track.WL=0.1;
track.WR=0.1;

track.Left.X=track.Center.X;
track.Left.Y=linspace(1,1,num)*track.WL;

track.Right.X=track.Center.X;
track.Right.Y=linspace(-1,-1,num)*track.WR;

path.PX=[-F1,0,F2,1];
path.PY=policy*track.WL;
path.S=[0,F1,F1+F2,F1+1];

%%

len=F1+1;
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

w_ay=1e2;


cvx_begin quiet
variables x(Ns,Np+1) u(Nc,Np)
% J=x(2,2:Np+1)-x(2,1:Np);

minimize(norm(x(3,:))+w_ay*norm(u(2,:)))

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

path.X=x(1,:)';
path.Y=x(2,:)';
path.Vy=x(3,:);
end
