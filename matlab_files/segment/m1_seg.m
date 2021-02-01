clc;clear;
close all;

load('Tokyo');


%% initil segment
C=waypoint.Center;
width=7.5*C.len;
kap_a=abs(abs(C.Kap));
thresh=mean(kap_a)/10;

seg=segmentation1(kap_a,thresh);
seg=calculate_chara(seg,kap_a,C,width);

plot_thresh(seg,kap_a,thresh);
plot_seg(waypoint,seg);
% 
seg2=cut_staright(seg,1);
seg2=calculate_chara(seg2,kap_a,C,width);
plot_seg_colored(waypoint,seg2)

%% pick basic corner

% 1, 2, 3
% 13, 14, 15
% 8,9,10,11,12

save('Tokyo_seg','seg2');

