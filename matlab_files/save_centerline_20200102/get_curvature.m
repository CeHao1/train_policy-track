function kap=get_curvature(p1,p2,Ns2,ld)

dx0=diff(p1);
dy0=diff(p2);
dx0(end)=[];
dy0(end)=[];

dx=smooth(dx0,Ns2);
dy=smooth(dy0,Ns2);

d2x0=diff(p1,2);
d2y0=diff(p2,2);

d2x=smooth(d2x0,Ns2);
d2y=smooth(d2y0,Ns2);

k=(dx.*d2y-dy.*d2x)./(dx.^2+dy.^2).^1.5;
k2=k(ld:2*ld);
kap=smooth(k2,Ns2/2);

end