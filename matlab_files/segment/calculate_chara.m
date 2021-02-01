function seg=calculate_chara(seg,kap_a,W,width)
% width=7.5/2;

for i =1:length(seg.st)
    st=seg.st(i);
    ed=seg.ed(i);
    id_t=st:ed;
    
    seg.len(i)=abs(W.s(st)-W.s(ed)); % length of corner
    [~,tmp]=max(kap_a(id_t));
    seg.peak(i)=tmp+st-1;
    
    seg.max_kap(i)=max(kap_a(id_t)); % maximum curvature at each corner
    seg.turn_angle(i)=abs(W.Psi(st)-W.Psi(ed)); % total turning angle
    seg.ta1(i)=abs(W.Psi(st)-W.Psi(seg.peak(i))); % turning angle before peak
    seg.ta2(i)=abs(W.Psi(seg.peak(i))-W.Psi(ed)); % turning angle after peak
    
    % calculate the length of the corner before and after the peak
    seg.len1(i)=abs(W.s(st)-W.s(seg.peak(i)));
    seg.len2(i)=abs(W.s(seg.peak(i))-W.s(ed));
    
    if i <length(seg.st) % not the last corner
        seg.dis2next(i)=(W.s(seg.st(i+1))-W.s(ed));        
    % the distance from the last corner to the next pass the start of the
    % track
    else 
        seg.dis2next(i)=(W.s(end)-W.s(ed)+W.s(seg.st(1)));        
    end
    
    R1=1/kap_a(seg.peak(i))-width(i)/2; % radius at peak
%     R2=1/kap_a(seg.st(i))+width/2;
%     R3=1/kap_a(seg.ed(i))+width/2;
    R2=1/kap_a(seg.peak(i))+width(i)/2; % radius before peak
    R3=1/kap_a(seg.peak(i))+width(i)/2; % radius after peak
    seg.ta_f1(i)=acos(R1/R2); % maximum turning angle tolerance before peak
    seg.ta_f2(i)=acos(R1/R3); % maximim turning angle tolerance after peak
    
    % if the turning angle is under the tolerance, if so, it's a straight
    % way
%     gain=1.5;
    gain=5;
    
    if seg.ta_f1(i)>seg.ta1(i)*gain && seg.ta_f2(i)>seg.ta2(i)*gain
        seg.is_straight(i)=1;
    else
        seg.is_straight(i)=0;
    end
    
end

% if distance to the next corner > length(before peak)+length(after peak)
% 
for i =1:length(seg.st)
    if i<length(seg.st)
        seg.len12(i)=seg.len2(i)+seg.len1(i+1);
    else
       seg.len12(i)=seg.len2(i)+seg.len1(1);
    end
    if seg.dis2next(i)<seg.len12(i) % should be combined
        seg.comb(i)=1;
    else
        seg.comb(i)=0;
    end
end
% divide sector
sec=1;
for i=1:length(seg.st)
    seg.sector(i)=sec;
    if seg.comb(i)==0
        sec=sec+1;
    end    
end


end