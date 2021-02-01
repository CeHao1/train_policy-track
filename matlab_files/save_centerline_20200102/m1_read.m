clc;clear
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

modified_angle=rt2-diffpsi;
% left,right,center waypoints
Lp=[x1-Dl.*cos(modified_angle),z1+Dl.*sin(modified_angle)];
Rp=[x1+Dr.*cos(modified_angle),z1-Dr.*sin(modified_angle)];
Cp=[x1-Cd.*cos(modified_angle),z1+Cd.*sin(modified_angle)];

%%

waypoint.Center.X=[Cp(index,1)',Cp(index(1),1)];
waypoint.Center.Y=[Cp(index,2)',Cp(index(1),2)];
waypoint.Left.X=[Lp(index,1)',Lp(index(1),1)];
waypoint.Left.Y=[Lp(index,2)',Lp(index(1),2)];
waypoint.Right.X=[Rp(index,1)',Rp(index(1),1)];
waypoint.Right.Y=[Rp(index,2)',Rp(index(1),2)];




figure
hold on

plot(waypoint.Center.X,waypoint.Center.Y,'b');
plot(waypoint.Left.X,waypoint.Left.Y,'r');
plot(waypoint.Right.X,waypoint.Right.Y,'m');

plot(waypoint.Center.X(1),waypoint.Center.Y(1),'ro');

hold off
axis equal
