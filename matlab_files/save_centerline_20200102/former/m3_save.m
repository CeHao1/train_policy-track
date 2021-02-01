

%% 
% computed s, X, Y, Vx, kap, psi

Vx=ones(ld+1,1)*30;
svdata=[s2,SCx,SCy,Vx,kap,psi0];

filename1 = 'centerline1.csv';
fid1 = fopen(filename1, 'w');
for i=1:length(svdata)
        fprintf(fid1, '%f,%f,%f,%f,%f,%f', svdata(i,:));
        fprintf(fid1, '\n');
end

fclose(fid1);


%%
% svdata2=[SCx,SCy,Lp(index2,:),Rp(index2,:)];
% csvwrite('centerline_map.csv',svdata2);