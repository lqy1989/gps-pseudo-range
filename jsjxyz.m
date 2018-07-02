clc;
c=299792458;
P=xlsread('lxylxyÎ±¾à¸Ä¸Ä.xlsx');
wxzb=xlsread('lxyÎÀÐÇ.xlsx');
xyz=zeros(10,3);

for i=1:10
    X0=0;Y0=0;Z0=0;
    for k=1:11
        m=P(1,2*i-1);          
        R=zeros(m,1);
        li=zeros(m,1);
        m1=zeros(m,1);
        n1=zeros(m,1);
        B1=zeros(m,1);
        L=zeros(m,1);
        for t=1:m
%           a=wxzb(P(t+1,2*i-1)+32*(i-1),1)*1000
%           b=wxzb(P(t+1,2*i-1)+32*(i-1),2)*1000
%           c=wxzb(P(t+1,2*i-1)+32*(i-1),3)*1000
          R(t,1)=sqrt((wxzb(P(t+1,2*i-1)+32*(i-1),1)*1000-X0)^2+(wxzb(P(t+1,2*i-1)+32*(i-1),2)*1000-Y0)^2+(wxzb(P(t+1,2*i-1)+32*(i-1),3)*1000-Z0)^2);
          li(t,1)=-(wxzb(P(t+1,2*i-1)+32*(i-1),1)*1000-X0)/R(t,1);
          m1(t,1)=-(wxzb(P(t+1,2*i-1)+32*(i-1),2)*1000-Y0)/R(t,1);
          n1(t,1)=-(wxzb(P(t+1,2*i-1)+32*(i-1),3)*1000-Z0)/R(t,1);
          B1(t,1)=1;
          L(t,1)=P(t+1,2*i)-R(t,1)+c*wxzb(P(t+1,2*i-1)+32*(i-1),4)*10^-6;
%         a=wxzb(P(t+1,2*i-1)+32*(i-1),4)
        end
     B=[li m1 n1 B1];
      xyzt=inv(B'*B)*B'*L;
      X0=X0+xyzt(1,1);
      Y0=Y0+xyzt(2,1);
      Z0=Z0+xyzt(3,1);
    end
    xyz(i,1)=X0;
    xyz(i,2)=Y0;
    xyz(i,3)=Z0;
end
xyz