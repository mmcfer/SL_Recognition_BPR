function plot_descriptor_shape(x)

r_inner=16;
r_outer=65/2;

r_bin_edges=logspace(log10(r_inner),log10(r_outer),3);

xx = -33:0.3:33;
 y1 = sqrt (r_bin_edges(1)^2-xx.^2);
y2 = sqrt (r_bin_edges(2)^2-xx.^2);
y3 = sqrt (r_bin_edges(3)^2-xx.^2);
% hold on
% plot(xx,y1,'y',xx,-y1,'y')
% plot(xx,y2,'b',xx,-y2,'b')
% plot(xx,y3,'r',xx,-y3,'r')
% hold off
% axis equal
x11=x(17:24);
x22=x(9:16);
x33=x(1:8);
x1=r_bin_edges(1)*im2bw(x(17:24));
x2=r_bin_edges(2)*im2bw(x(9:16));
x3=r_bin_edges(3)*im2bw(x(1:8));

ang=0:pi/4:(2*pi-pi/4);
ang=ang+pi/8;
    y11=8;
y22=20;
y33=27;
figure;
polar(ang,x3,'b*')
hold on
polar(ang,x1,'r*')
polar(ang,x2,'g*')

hold off
axis equal
axis ij