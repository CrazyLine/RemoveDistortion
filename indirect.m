clear;close all;clc

% remove the projective distortion
frame = 'myimg4.jpg';
img = imread(frame);
imshow(img);
[xx,yy]=ginput(4);

p11 = [xx(1),yy(1),1]';
p21 = [xx(2),yy(2),1]';
p31 = [xx(3),yy(3),1]';
p41 = [xx(4),yy(4),1]';

    figure();
    imshow(img);
    hold on;
    plot([p11(1),p41(1)],[p11(2),p41(2)],'Color','r','LineWidth',2)
    plot([p21(1),p31(1)],[p21(2),p31(2)],'Color','r','LineWidth',2)
    plot([p11(1),p21(1)],[p11(2),p21(2)],'Color','r','LineWidth',2)
    plot([p31(1),p41(1)],[p31(2),p41(2)],'Color','r','LineWidth',2)

% get four lines
l1 = cross(p11, p21);
l2 = cross(p31, p41);
l3 = cross(p11, p41);
l4 = cross(p21, p31);
s = size(img);

% get our two vanishing points
p_inf1 = cross(l1,l2);
p_inf2 = cross(l3,l4);
% infinit line
l_inf = cross(p_inf1, p_inf2);
l_inf = l_inf / l_inf(3);

H = [1, 0, 0; 0, 1, 0];
H(3,:) = l_inf';

H_P=projective2d(H');
final_img=imwarp(img,H_P);
figure,imshow(final_img);


% remove the affine distortion
[xx1,yy1]=ginput(6);

p1 = [xx1(1),yy1(1), 1]';
p2 = [xx1(2),yy1(2), 1]';
p3=[xx1(3),yy1(3), 1]';

p4 = [xx1(4),yy1(4), 1]';
p5 = [xx1(5),yy1(5), 1]';
p6= [xx1(6),yy1(6), 1]';

    figure;
    imshow(final_img);
    hold on;
    plot([p1(1),p2(1)],[p1(2),p2(2)],'Color','g','LineWidth',2)
    plot([p2(1),p3(1)],[p2(2),p3(2)],'Color','g','LineWidth',2)
    plot([p4(1),p5(1)],[p4(2),p5(2)],'Color','g','LineWidth',2)
    plot([p5(1),p6(1)],[p5(2),p6(2)],'Color','g','LineWidth',2)


pl1 = cross(p1,p2);
pm1 = cross(p2,p3);

pm2 = cross(p4,p5);
pl2 = cross(p5,p6);

l11 = pl1(1);
l12 = pl1(2);
m11 = pm1(1);
m12 = pm1(2);

l21 = pl2(1);
l22 = pl2(2);
m21 = pm2(1);
m22 = pm2(2);

orth1 = [l11*m11, l11*m12 + l12*m11, l12*m12];
orth2 = [l21*m21, l21*m22 + l22*m21, l22*m22];

syms s11 s12

f1=sym(s11*orth1(1)+s12*orth1(2)+orth1(3));
f2=sym(s11*orth2(1)+s12*orth2(2)+orth2(3));
[s11,s12]=solve([f1,f2]);
[s11,s12]=deal(double(s11),double(s12));

S = [s11, s12; s12, 1];
% [U, D, V] = svd(S);
% A = U'*sqrt(D)*U;
K = chol(S, 'lower');
A=K;
H2 = [A, [0;0]; [0,0,1]];

H_A=affine2d(inv(H2)');
fnewimg=imwarp(final_img,H_A);
figure,imshow(fnewimg);