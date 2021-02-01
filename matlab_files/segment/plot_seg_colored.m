function plot_seg_colored(W,seg)

%% map
figure
hold on
plot(W.Center.X,W.Center.Y,'b--');
plot(W.Left.X,W.Left.Y,'m');
plot(W.Right.X,W.Right.Y,'g');

for i =1:max(seg.sector)
    acc=[]; % accumulation
    ls_st=min(find(seg.sector==i));
    ls_ed=max(find(seg.sector==i));
    for j=ls_st:ls_ed
        acc=[acc,seg.st(j):seg.ed(j)];
    end
    plot(W.Center.X(acc),W.Center.Y(acc),'.','linewidth',2);
    
    for j=ls_st:ls_ed
        plot(W.Center.X(seg.st(j)),W.Center.Y(seg.st(j)),'r*');
    end
    
end

for i =1:length(seg.st)
%     id_t=seg.st(i):seg.ed(i);
%     plot(pos(2,id_t),pos(3,id_t),'r','linewidth',2);
    
    c=num2str(i);
    c=[' ',c];
    text(W.Center.X(seg.peak(i)),W.Center.Y(seg.peak(i)),c,'fontsize',15)
end
hold off
axis equal

