function plot_seg(W,seg)

%% map
figure
hold on
plot(W.Center.X,W.Center.Y,'b--');
plot(W.Left.X,W.Left.Y,'m');
plot(W.Right.X,W.Right.Y,'g');

for i =1:length(seg.st)
    id_t=seg.st(i):seg.ed(i);
    plot(W.Center.X(id_t),W.Center.Y(id_t),'r','linewidth',2);
    plot(W.Center.X(seg.st(i)),W.Center.Y(seg.st(i)),'bo');
    plot(W.Center.X(seg.ed(i)),W.Center.Y(seg.ed(i)),'kD');
    
    c=num2str(i);
    c=[' ',c];
    text(W.Center.X(seg.peak(i)),W.Center.Y(seg.peak(i)),c,'fontsize',15)
end
hold off
axis equal

%% plot characters

% figure
% hold on
% plot(seg.max_kap,seg.dis2next,'.');
% for i=1:length(seg.st)
%     c=num2str(i);
%     c=[' ',c];
%     text(seg.max_kap(i),seg.dis2next(i),c)
% end
% hold off
% xlabel('kap')
% ylabel('distance')
% 

%% plot straight flag
% figure
% subplot(211)
% hold on
% plot(seg.ta1,'b');
% plot(seg.ta_f1,'r')
% 
% for i=1:length(seg.ta1)
%     c=num2str(i);
%     c=[' ',c];
%     text(i,seg.ta1(i),c);
% end
% hold off
% legend('turning angle','tolerance')
% 
% subplot(212)
% hold on
% plot(seg.ta2,'b');
% plot(seg.ta_f2,'r')
% 
% for i=1:length(seg.ta2)
%     c=num2str(i);
%     c=[' ',c];
%     text(i,seg.ta2(i),c);
% end
% hold off
