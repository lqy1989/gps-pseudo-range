wxzb=xlsread('wxzb.xls');%卫星位置;
for i=1:9
    o(i,:)=dianliceng(wxzb(i,:));
end
jsj=xlsread('jsj5.xls');
for k=1:10
    p(k,:)=dianliceng(jsj(k,:));
end
for s=1:9
phi1=p(1,2); %接收机经度
phi2=o(s,2); %卫星轨位经度
P=p(1,1); %接收站纬度
E=atan((cos(phi2-phi1)*cos(P)-0.15)/sqrt(1-(cos(phi2-phi1)*cos(P))^2));%仰角
Q=atan((tan(phi2-phi1))/sin(P));%方位角
sigma=0.0137/(E+0.11)-0.022;
phiI=P+sigma*cos(Q);%IPP
if phiI>0.416
    phiI=0.416;
else if phiI<-0.416
        phiI=-0.416;
    end
end
lamdaI=phi1+sigma*sin(Q)/cos(phiI);%IPP经度
phim=phiI+0.064*cos(lamdaI-1.617);
t=43200*lamdaI+26100; %IPP TIME
while t>=86400
    t=t-86400;
end
while t<0
    t=t+86400;
end
Ai=4.657E-09+(1.490E-08)*phim+(-5.960E-08)*(phim)^2+(-1.192E-07)*(phim)^3;
if Ai<0
    Ai=0;
end
Pi=8.192E+04+(9.830E+04)*phim +(-6.554E+04)*(phim)^2+(-5.243E+05)*(phim)^3;
if Pi<72000
    Pi=72000;
end
Xi=2*pi*(t-50400)/Pi;
F=1.0+16.0*(0.53-E)^3;
if abs(Xi)<=1.57
    Igps=(5*10^-9+Ai*(1-Xi*Xi/2+(Xi^4)/24))*F;
else if abs(Xi)>=1.57
    Igps=5*10^-9*F;
    end
end
xzwj(s)=Igps*299792458;
end
xzwj