clc;clear;
close all

load('Tokyo')
load('Tokyo_seg');
seg=seg2;
clear seg2

init_pos(1)=0;
init_Vx(1)=30;
% num_corner=2;

for i=1:5
    num_corner=i+7;
    [init_pos(i+1),init_Vx(i+1)]= ...
               plan_each_seg(init_pos(i),init_Vx(i),num_corner,waypoint,seg);
    i
end


% 1, 2, 3
% 13, 14, 15
% 8,9,10,11,12