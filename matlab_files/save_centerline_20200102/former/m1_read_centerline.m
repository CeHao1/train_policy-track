clc;clear all;
close all

data0=csvread('x03.csv');

Vx=data0(:,1);
Cd=data0(:,2);
diffpsi=data0(:,3);
Dl=data0(:,4);
Dr=data0(:,5);
x1=data0(:,6);
y1=data0(:,7);
z1=data0(:,8);
rt2=data0(:,10);
lap_count=data0(:,12); 
course_v=data0(:,13); 
frame_count=data0(:,14); 

index=find(lap_count==2);
index2=[index;index(end)+1];


modified_angle=rt2-diffpsi;
% left,right,center waypoints
Lp=[x1-Dl.*cos(modified_angle),z1+Dl.*sin(modified_angle)];
Rp=[x1+Dr.*cos(modified_angle),z1-Dr.*sin(modified_angle)];
Cp=[x1-Cd.*cos(modified_angle),z1+Cd.*sin(modified_angle)];

pflag=1;
if pflag==1
    figure
    hold on;
    plot(x1,z1,'linewidth',1);
    plot(Cp(:,1),Cp(:,2),'k');
    plot(Lp(:,1),Lp(:,2),'r');
    plot(Rp(:,1),Rp(:,2),'m');
    
    
    plot(Cp(index(1),1),Cp(index(1),2),'ro');
    
    hold off
    axis equal
end

x2=x1(index);
z2=z1(index);


