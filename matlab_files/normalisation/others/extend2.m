clc;clear
close all

load('Tokyo')
load('Tokyo_seg');
seg=seg2;
clear seg2

%%

% num_corner=2;
% [track,track_r]=seg_track(waypoint,seg,num_corner);

track=standard_track2();

policy=-[-0.2,-0.9,0.9,-0.8];
[X,Y,F]=get_norm_path2(policy,[track.S1,track.S2,track.S3]);

pp=spline(X,Y);
for i=1:length(track_r.X)
    
    if track.s(i)<=track.S1
        norm_X(i)=(track.s(i)/track.S1-1)*F(1);
    elseif track.s(i)<=track.S1+track.S2
        norm_X(i)=(track.s(i)-track.S1)/track.S2;
    else
        norm_X(i)=((track.s(i)-track.S1-track.S2)/track.S3)*F(2)+1;
    end
    Wd(i)=ppval(pp,norm_X(i));
    [path.X(i),path.Y(i)]=bias(track.X(i), track.Y(i),track.Psi(i),Wd(i)*track.WL*10);
end


%%
figure
hold on
plot(track.X,track.Y,'b')
plot(track.XL,track.YL,'m')
plot(track.XR,track.YR,'m')

plot(path.X,path.Y,'k','linewidth',2)
plot(path.X(1),path.Y(1),'ko','linewidth',2)

hold off
axis equal

