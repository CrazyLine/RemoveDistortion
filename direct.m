clear;close all;clc
syms h11 h12 h13 h21 h22 h23 h31 h32
frame = 'myimg.jpg';
img = imread(frame);
imshow(img);
[xx,yy]=ginput(4);
p11 = [xx(1),yy(1),1]';
p21 = [xx(2),yy(2),1]';
p31 = [xx(3),yy(3),1]';
p41 = [xx(4),yy(4),1]';
% [xx1,yy1]=ginput(2);
s = size(img);

    figure();
    imshow(img);
    hold on;
    plot([p11(1),p41(1)],[p11(2),p41(2)],'Color','r','LineWidth',2)
    plot([p21(1),p31(1)],[p21(2),p31(2)],'Color','r','LineWidth',2)
    plot([p11(1),p21(1)],[p11(2),p21(2)],'Color','r','LineWidth',2)
    plot([p31(1),p41(1)],[p31(2),p41(2)],'Color','r','LineWidth',2)
%     plot(xx1(1),yy1(1),'r.','markersize',30)
%     plot(xx1(2),yy1(2),'r.','markersize',30)
%     plot(xx1(3),yy1(3),'r.','markersize',30)
%     plot(xx1(4),yy1(4),'r.','markersize',30)
%     plot(xx1(5),yy1(5),'r.','markersize',30)
    
real1=[0,0,1]';
real2=[0,850,1]';
real3=[1100,850,1]';
real4=[1100,0,1]';

f1=sym(h11*real1(1)+h12*real1(2)+h13-p11(1)*(h31*real1(1)+h32*real1(2)+1));
f2=sym(h21*real1(1)+h22*real1(2)+h23-p11(2)*(h31*real1(1)+h32*real1(2)+1));
f3=sym(h11*real2(1)+h12*real2(2)+h13-p21(1)*(h31*real2(1)+h32*real2(2)+1));
f4=sym(h21*real2(1)+h22*real2(2)+h23-p21(2)*(h31*real2(1)+h32*real2(2)+1));

f5=sym(h11*real3(1)+h12*real3(2)+h13-p31(1)*(h31*real3(1)+h32*real3(2)+1));
f6=sym(h21*real3(1)+h22*real3(2)+h23-p31(2)*(h31*real3(1)+h32*real3(2)+1));
f7=sym(h11*real4(1)+h12*real4(2)+h13-p41(1)*(h31*real4(1)+h32*real4(2)+1));
f8=sym(h21*real4(1)+h22*real4(2)+h23-p41(2)*(h31*real4(1)+h32*real4(2)+1));
[h11,h12,h13,h21,h22,h23,h31,h32]=solve([f1,f2,f3,f4,f5,f6,f7,f8]);
[h11,h12,h13,h21,h22,h23,h31,h32]=deal(double(h11),double(h12),double(h13),double(h21),double(h22),double(h23),double(h31),double(h32));

H=[h11,h12,h13;h21,h22,h23;h31,h32,1];

H_P=projective2d(inv(H)');
newimg=imwarp(img,H_P);
figure,imshow(newimg);
saveas(gcf, 'myimage', 'jpg')
% [xx,yy]=ginput(4);
% p11 = [xx(1),yy(1),1]';
% p21 = [xx(2),yy(2),1]';
% p31 = [xx(3),yy(3),1]';
% p41 = [xx(4),yy(4),1]';
% [xx1,yy1]=ginput(2);
% hold on;
% plot([p11(1),p41(1)],[p11(2),p41(2)],'Color','r','LineWidth',2)
% plot([p21(1),p31(1)],[p21(2),p31(2)],'Color','r','LineWidth',2)
% plot([p11(1),p21(1)],[p11(2),p21(2)],'Color','r','LineWidth',2)
% plot([p31(1),p41(1)],[p31(2),p41(2)],'Color','r','LineWidth',2)
% plot(xx1(1),yy1(1),'r.','markersize',30)
% plot(xx1(2),yy1(2),'r.','markersize',30)
% plot(xx1(3),yy1(3),'r.','markersize',30)
% plot(xx1(4),yy1(4),'r.','markersize',30)
% plot(xx1(5),yy1(5),'r.','markersize',30)


% paperlength=norm(p11(1:2)-p21(1:2));
% a=[xx1(1),yy1(1)];
% b=[xx1(2),yy1(2)];
% penlength1=norm(a-b);
% realpen1=penlength1/paperlength*8.5;
% disp(realpen1);
% realpenx1=(a(1)-p11(1))*8.5/paperlength;
% realpeny1=(a(2)-p11(2))*8.5/paperlength;
% disp(realpenx1);
% disp(realpeny1);
% 
% realpenx1=(b(1)-p11(1))*8.5/paperlength;
% realpeny1=(b(2)-p11(2))*8.5/paperlength;
% disp(realpenx1);
% disp(realpeny1);

% c=[xx1(3),yy1(3)];
% realpenx1=(c(1)-p11(1))*8.5/paperlength;
% realpeny1=(c(2)-p11(2))*8.5/paperlength;
% disp(realpenx1);
% disp(realpeny1);

