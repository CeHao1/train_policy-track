close all
t.len=1:length(waypoint.Center.X);
t.pp.Center=csaps(t.len,[waypoint.Center.X;waypoint.Center.Y], ...
                            0.4,  [], 1e-7*ones(size(t.len)));
              
t.dpp.Center=fnder(t.pp.Center,1);
t.d2pp.Center=fnder(t.pp.Center,2);

t.V.Center=ppval(t.len,t.pp.Center);
t.dV.Center=ppval(t.len,t.dpp.Center);
t.d2V.Center=ppval(t.len,t.d2pp.Center);

dX=t.dV.Center(1,:);
dY=t.dV.Center(2,:);
d2X=t.d2V.Center(1,:);
d2Y=t.d2V.Center(2,:);

t.Psi=atan2(dY,dX);
t.Kap=(dX.*d2Y-dY.*d2X)./(dX.^2+dY.^2).^1.5;
t.ds=sqrt(dX.^2+dY.^2);
t.s=cumtrapz(t.ds);

err=sqrt((waypoint.Center.X-t.V.Center(1,:)).^2+(waypoint.Center.Y-t.V.Center(2,:)).^2);


%%
figure
hold on
plot(waypoint.Center.X,waypoint.Center.Y,'b');
plot(t.V.Center(1,:),t.V.Center(2,:),'r');
hold off
axis equal

figure
subplot(2,1,1)
plot(t.Psi)
title('psi')

subplot(2,1,2)
plot(smooth(t.Kap))
title('kap')

figure
plot(err)
title('err')