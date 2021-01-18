function [Vx,cost]=get_velocity(kap,dist,Vx_init)

len=length(kap);
% Vx_max
ay=10*0.01;
Vx_m=sqrt(ay./kap);

% ax
ax_max=1.3*ones(1,len)*0.1;
ax_min=-9*ones(1,len)*0.1;

% ds
ds0=extend(diff(dist));
%%

Vmax=Vx_m;
amax=ax_max;
amin=ax_min;
ds=ds0;

Np=len;
% forward

% V1(1)=Vmax(1);
V1(1)=Vx_init;
for i=1:Np-1
    V1(i+1)=min([Vmax(i+1),sqrt(2*amax(i)*ds(i)+V1(i)^2)]);
end

V2(Np)=Vmax(Np);
for i= Np:-1:2   
    V2(i-1)=min([Vmax(i-1),sqrt(-2*amin(i)*ds(i-1)+V2(i)^2)]);
end

Va=min([V1;V2]);


Vx=Va;

%%
cost=sum(ds0./Vx);

%%
% figure
% hold on;
% h1=plot(dist,Vmax,'b');
% h2=plot(dist,V1,'r');
% h3=plot(dist,V2,'g');
% h4=plot(dist,Va,'k','linewidth',2);
% xlabel('distance (m)');
% ylabel('velocity (m/s)');
% 
% h=legend([h1,h2,h3,h4],'Vx max','Forward integration','Backward integration','True velocity');
% set(h,'fontsize',12);
end

