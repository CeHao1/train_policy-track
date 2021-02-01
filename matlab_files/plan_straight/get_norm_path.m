function [X,Y]=get_norm_path(policy)

track.Center.X=linspace(-2,2,2000);
track.Center.Y=linspace(0,0,2000);

track.WL=0.1;
track.WR=0.1;

track.Left.X=linspace(-2,2,2000);
track.Left.Y=linspace(1,1,2000)*track.WL;

track.Right.X=linspace(-2,2,2000);
track.Right.Y=linspace(-1,-1,2000)*track.WR;

path.PX=[-2,0,1,2];
path.S=[0,2,3,4];
path.PY=policy*track.WL;

%%
len=4;

Vx=0.01;
dT=1;
Np=len/Vx;
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

w_ay=10;
w_Y=0.01;

cvx_begin quiet
variables x(Ns,Np+1) u(Nc,Np)
% J=x(2,2:Np+1)-x(2,1:Np);

minimize(norm(x(3,:))+w_ay*norm(u(2,:))+w_Y*norm(x(2,:)))

subject to
u(1,:)==Vx*ones(1,Np); 

x(1,1)==path.PX(1);
for i=1:len
    ind=path.S(i)/Vx+1;
    x(2,ind)==path.PY(i);
    
end

for i=1:Np
    x(:,i+1)==Ad*x(:,i)+Bd*u(:,i);
end

-ones(1,Np+1)*track.WR<=x(2,:)<=ones(1,Np+1)*track.WL

cvx_end

X=x(1,:);
Y=x(2,:);

end