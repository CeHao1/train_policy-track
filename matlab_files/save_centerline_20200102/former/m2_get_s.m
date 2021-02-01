% clc;clear all;
close all
course=course_v(index);

Cx0=Cp(index,1);
Cy0=Cp(index,2);
Cx=repmat(Cx0,3,1);
Cy=repmat(Cy0,3,1);

Ns=20;
SCx0=smooth(Cx,Ns);
SCy0=smooth(Cy,Ns);


%%


ld=length(index);
bias=1;
SCx=SCx0(ld+1:2*ld+bias);
SCy=SCy0(ld+1:2*ld+bias);

sv_x=SCx0(ld+1:2*ld);
sv_y=SCy0(ld+1:2*ld);

p=sqrt(diff(SCx).^2+diff(SCy).^2);
s1=cumtrapz(p);
s2=[s1;2*s1(end)-s1(end-1)];

kap=get_curvature(SCx0,SCy0,200,ld);


%% get back kap
x0=SCx0(1);
y0=SCy0(1);
psi=wrapToPi(pi/2-rt2(index2));
psi0=psi(1);
ds=diff(s2);


for i=1:length(kap)-1
    x0(i+1)=x0(i)+cos(psi(i))*ds(i);
    y0(i+1)=y0(i)+sin(psi(i))*ds(i);
    psi0(i+1)=psi0(i)+kap(i)*ds(i);
    
end
psi0=wrapToPi(psi0)';

figure
hold on
plot(SCx0,SCy0,'b')
plot(x0,y0,'r')
hold off

figure
hold on
plot(smooth(psi,100),'b')
plot(psi0,'r')
hold off


%%
% a=get_yaw(SCx0,SCy0);
% b=a(ld:2*ld-8);
% figure
% hold on
% plot(rt2(index),'b')
% plot(b,'r')
% hold off

% figure
% hold on
% plot(SCx,SCy,'b');
% plot(SCx(1),SCy(1),'bo');
% plot(SCx(end),SCy(end),'b*');
% 
% plot(x2,z2,'r');
% plot(x2(1),z2(1),'ro');
% plot(x2(end),z2(end),'r*');


% hold off


% figure
% hold on
% plot(SCx,SCy,'b')
% plot(SCx(1),SCy(1),'ro')
% plot(SCx(end),SCy(end),'r*')
% hold off

