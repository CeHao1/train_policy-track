function [tX,tY]=bias(X,Y,Psi,W)


tX=X-sin(Psi)*W;
tY=Y+cos(Psi)*W;


end