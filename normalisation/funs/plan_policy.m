function path=plan_policy(policy,track)

% policy library

ti=track.ti;
[~,ind]=max(track.Kap);

[path.PX(1),path.PY(1)]=bias(track.X(ti),track.Y(ti), track.Psi(ti),track.WL*policy(1));
[path.PX(2),path.PY(2)]=bias(track.X(ind),track.Y(ind), track.Psi(ind),track.WL*policy(2));
[path.PX(3),path.PY(3)]=bias(track.X(end),track.Y(end), track.Psi(end),track.WL*policy(3));

[init_X,init_Y]=bias(track.X(1),track.Y(1), track.Psi(1),0);

path.PX=[init_X,path.PX];
path.PY=[init_Y,path.PY];

lp=length(path.PX);
t=1:lp;
pp=spline(t,[path.PX;path.PY]);

% pp=csape(t,[ ...
%                 [track.X(2)-track.X(1); track.Y(2)-track.Y(1) ],... 
%                 [path.PX;path.PY], ...
%                 [track.X(end)-track.X(end-1); track.Y(end)-track.Y(end-1)] ], ...
%                 [1,1]);

% pp=csape(t,[ ...
%                 [track.X(2)-track.X(1); track.Y(2)-track.Y(1) ],... 
%                 [path.PX;path.PY], ...
%                 [0;0] ], ...
%                 [1,2]);

% pp=csaps(t,[path.PX;path.PY],0.98);

temp=ppval(pp,linspace(1,lp,1000));
path.X=temp(1,:);
path.Y=temp(2,:);

path.track=track;
end