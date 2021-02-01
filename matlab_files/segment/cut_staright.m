function seg2=cut_staright(seg,flag)

fileds=fieldnames(seg);

for i= 1:length(fileds)
        k = fileds(i);
        key = k{1};
        seg2.(key)=[];
end

if flag==1% cut straight
    cutflag=seg.is_straight;
end

for j=1:length(seg.st)
    if cutflag(j)==0
        seg2.st=[seg2.st,seg.st(j)];
        seg2.ed=[seg2.ed,seg.ed(j)];
    end
end
    
end


