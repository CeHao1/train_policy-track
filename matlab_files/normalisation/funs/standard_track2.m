function track=standard_track2()

x=[0,1,2 ;
    0,1,0];

mindist=1;

pp=csape(x(1,:),[0 x(2,:) 0], [1 1]);

ipp=fnint(pp,0);

xx=linspace(0,2,2000);
theta=ppval(ipp,xx); 

funX = @(u) cos(ppval(ipp,u));
funY = @(u) sin(ppval(ipp,u));

for i=1:2000
    j=i/1000;
    qX(i)=integral(funX,0,j);
    qY(i)=integral(funY,0,j);
end

% figure
% hold on
% plot(xx,ppval(pp,xx),'b')
% plot(x(1,:),x(2,:),'or')
% hold off
% 
% xlabel('Course s / m','fontsize',12)
% ylabel('Curvature \kappa','fontsize',12)
%%

t=xx;
pX=csape(t,qX);
pY=csape(t,qY);
dpX=fnder(pX,1);
dpY=fnder(pY,1);
d2pX=fnder(pX,2);
d2pY=fnder(pY,2);

dX=ppval(dpX,t);
dY=ppval(dpY,t);
d2X=ppval(d2pX,t);
d2Y=ppval(d2pY,t);

kap=abs(dX.*d2Y-dY.*d2X)./(dX.^2+dY.^2).^1.5;

% ptheta=csape(t,atan2(dY,dX));
% dptheta=fnder(ptheta);

ds=sqrt(ppval(dpX,t).^2+ppval(dpY,t).^2);
dist=cumtrapz(ds);

psi=atan2(dY,dX);

%%

WL=0.1;
WR=0.1;

BnL.X= qX - sin(psi)*WL;
BnL.Y= qY + cos(psi)*WL;
BnR.X= qX + sin(psi)*WR;
BnR.Y= qY - cos(psi)*WR;

%% 
track.t=t;
track.pX=pX;
track.pY=pY;
track.dpX=dpX;
track.dpY=dpY;
track.d2pX=d2pX;
track.d2pY=d2pY;
track.pPsi=ipp;
track.pKap=pp;

track.pBLX=csape(t,BnL.X);
track.pBLY=csape(t,BnL.Y);
track.pBRX=csape(t,BnR.X);
track.pBRY=csape(t,BnR.Y);

ds=mean(diff(xx));
extend_X=-mindist:ds:0;
len=length(extend_X);
extend_Y=zeros(1,len);
extend_Y1=0.1*ones(1,len);

track.ti=len+1;
track.S=[extend_X,xx+1];
track.X=[extend_X ,ppval(track.pX,track.t)];
track.Y=[extend_Y,ppval(track.pY,track.t)];
track.Psi=[extend_Y,ppval(track.pPsi,track.t)];
track.Kap=[extend_Y,ppval(track.pKap,track.t)];

track.XL=[extend_X,BnL.X];
track.YL=[extend_Y1,BnL.Y];
track.XR=[extend_X,BnR.X];
track.YR=[-extend_Y1,BnR.Y];

track.WL=WL;
track.WR=WR;

track.S1=1;
track.S2=1;
track.S3=1;
track.s=linspace(0,3,length(track.X));
%%

% figure
% hold on
% plot(track.X,track.Y,'b')
% plot(track.BLX,track.BLY,'r')
% plot(track.BRX,track.BRY,'k')
% plot(track.X(1000),track.Y(1000),'mo')
% hold off
% axis equal
% 
% pause(0.01)
end