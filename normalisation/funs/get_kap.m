function [psi,dist,kap]=get_kap(X,Y)

t=1:length(X);
pp0=csape(t,[X;Y]);
dpp0=fnder(pp0,1);
d2pp0=fnder(pp0,2);
p0=ppval(dpp0,t);
dp0=ppval(d2pp0,t);

dX=p0(1,:);
dY=p0(2,:);
d2X=dp0(1,:);
d2Y=dp0(2,:);
ds=sqrt(dX.^2+dY.^2);
dist=cumtrapz(ds);

%% 
% t2=dist;
% pX=csape(t2,X);
% pY=csape(t2,Y);
% dpX=fnder(pX,1);
% dpY=fnder(pY,1);
% d2pX=fnder(pX,2);
% d2pY=fnder(pY,2);
% 
% t3=linspace(t2(1),t2(end),1000);
% dX=ppval(dpX,t3);
% dY=ppval(dpY,t3);
% d2X=ppval(d2pX,t3);
% d2Y=ppval(d2pY,t3);

kap=abs(dX.*d2Y-dY.*d2X)./(dX.^2+dY.^2).^1.5;

% ds=sqrt(ppval(dpX,t3).^2+ppval(dpY,t3).^2);
% dist=cumtrapz(ds);

psi=atan2(dY,dX);

% pause(0.01)
end