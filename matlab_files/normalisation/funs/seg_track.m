function [track,track_r]=seg_track(W,seg,i)

if i==1
    j=length(seg.st);
    index=[seg.ed(j):length(W.Center.X),1:seg.ed(i)];
    track.ti=seg.st(i)-seg.ed(j)+length(W.Center.X);
    
    track.S=W.Center.s(seg.ed(i))-W.Center.s(seg.ed(j))+W.Center.s(end);
    track.S1=W.Center.s(seg.st(i))-W.Center.s(seg.ed(j))+W.Center.s(end);
        
else
    j=i-1;
    index=seg.ed(j):seg.ed(i);
    track.ti=seg.st(i)-seg.ed(j);
    
    track.S=W.Center.s(seg.ed(i))-W.Center.s(seg.ed(j));
    track.S1=W.Center.s(seg.st(i))-W.Center.s(seg.ed(j));
   
end

track.S2=W.Center.s(seg.peak(i))-W.Center.s(seg.st(i));
track.S3=W.Center.s(seg.ed(i))-W.Center.s(seg.peak(i));

track.s=W.Center.s(index)-W.Center.s(index(1));
ind_t=find(track.s<0);
track.s(ind_t)=track.s(ind_t)+W.Center.s(end);

%% 
track.X=W.Center.X(index);
track.Y=W.Center.Y(index);
track.Psi=W.Center.Psi(index);
track.Kap=W.Center.Kap(index);

track.XL=W.Left.X(index);
track.YL=W.Left.Y(index);
track.XR=W.Right.X(index);
track.YR=W.Right.Y(index);


%
track.WL=7.5/2;
track.RL=7.5/2;

%%
[track_r.X,track_r.Y]=rorate(track.X,track.Y, track.X(track.ti), track.Y(track.ti) ,...
                                       track.Psi(track.ti),sign(mean(track.Kap)));

[track_r.XL,track_r.YL]=rorate(track.XL,track.YL, track.X(track.ti), track.Y(track.ti) ,...
                                       track.Psi(track.ti),sign(mean(track.Kap)));                      

 [track_r.XR,track_r.YR]=rorate(track.XR,track.YR, track.X(track.ti), track.Y(track.ti) ,...
                                       track.Psi(track.ti),sign(mean(track.Kap)));                                  

track_r.Psi=track.Psi-track.Psi(1);                                   
           
track_r.WL=7.5/2;
track_r.RL=7.5/2;
track_r.Kap=track.Kap*sign(mean(track.Kap));
track_r.ti=track.ti;
[~,track_r.pk]=max(track_r.Kap);

% figure
% hold on
% plot(track.Xr,track.Yr,'b')
% plot(track.XLr,track.YLr,'r')
% hold off
% 
% axis equal
end


function [Xr,Yr]=rorate(X,Y,X0,Y0,psi,sig)


T=[cos(psi), sin(psi);
    -sin(psi), cos(psi)];

r=T*[X-X0;Y-Y0];
Xr=r(1,:);
Yr=r(2,:)*sig;


end