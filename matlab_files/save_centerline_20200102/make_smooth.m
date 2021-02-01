function output=make_smooth(input,p,w)

t.len=1:length(input.X);
t.pp=csaps(t.len,[input.X;input.Y], ...
                            p,  [], w*ones(size(t.len)));

t.dpp=fnder(t.pp,1);
t.d2pp=fnder(t.pp,2);

t.V=ppval(t.len,t.pp);
t.dV=ppval(t.len,t.dpp);
t.d2V=ppval(t.len,t.d2pp);

X=t.V(1,:);
Y=t.V(2,:);
dX=t.dV(1,:);
dY=t.dV(2,:);
d2X=t.d2V(1,:);
d2Y=t.d2V(2,:);

t.Psi=atan2(dY,dX);
t.Kap=(dX.*d2Y-dY.*d2X)./(dX.^2+dY.^2).^1.5;
t.ds=sqrt(dX.^2+dY.^2);
t.s=cumtrapz(t.ds);

err=sqrt((input.X-X).^2+(input.Y-Y).^2);                        

%%
t.X=X;
t.Y=Y;

output=t;
%%
% figure
% hold on
% plot(input.X,input.Y,'b');
% plot(X,Y,'r');
% hold off
% axis equal
% 
% figure
% subplot(2,1,1)
% plot(t.Psi)
% title('psi')
% 
% subplot(2,1,2)
% plot(smooth(t.Kap))
% title('kap')
% 
% figure
% plot(err)
% title('err')
%                         
end