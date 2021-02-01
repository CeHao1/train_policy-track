function plot_thresh(seg,kap_a,thresh)

%% kap

figure
hold on
plot(kap_a,'b')
hs=plot(ones(1,length(kap_a))*thresh,'k');

for i =1:length(seg.st)
    id_t=seg.st(i):seg.ed(i);
    plot(id_t,kap_a(id_t),'r');
    
    c=num2str(i);
    c=[' ',c];
    text(seg.peak(i),kap_a(seg.peak(i)),c)
end
hold off

xlabel('Waypoints','fontsize',12)
ylabel('Curvature','fontsize',12)
legend([hs],'Threshold')

end