function seg=segmentation1(kap_a,thresh)

index1=find(kap_a>thresh);
d_ind=diff(index1);
index2=find(d_ind>1);
seg.st=[index1(1),index1(index2+1)];
seg.ed=[index1(index2),index1(end)];


end