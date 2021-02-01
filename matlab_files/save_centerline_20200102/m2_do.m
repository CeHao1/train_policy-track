
close all
waypoint.Center=make_smooth(waypoint.Center,0.4,1e-7);
waypoint.Left=make_smooth(waypoint.Left,0.4,1e-7);
waypoint.Right=make_smooth(waypoint.Right,0.4,1e-7);

save('Tokyo','waypoint');