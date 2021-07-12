clc
clear zall
close all

q1 = [3 0 0 1];
q2 = [-3 0 0 1];
syms x y z
scale = 4;
q = 10e-6;
q_l = -10e-6;
k= 1/(4*pi* 1/(36*pi)); 

x = -5:5 ;
y =-5:5 ; 
z =-5:5 ;

[x, y ,z]= meshgrid(x,y,z);

rx1 = x - q1(1);
ry1 = y - q1(2);
rz1 = z - q1(3);

rx2 = x - q2(1);
ry2 = y - q2(2);
rz2 = z - q2(3);

for i= 0:11
    v1 = [rx1 ; ry1 ; rz1]
    v2 = [rx2 ; ry2 ; rz2]
    k1 = rx1.^2 + ry1.^2 + rz1.^2
    norm1 = k1.^0.5
    k2 = rx2.^2 + ry2.^2 + rz2.^2
    norm2 = k2.^0.5
end

for i = 0:4
a = [ q1 ; q2]
end

F1= k* q^2;  
F2 = k* q_l^2;

a1x = rx1./(norm1.^1.5) ;
a1y = ry1./(norm1.^1.5) ;
a1z = rz1./(norm1.^1.5) ;

a2x = rx2./(norm2.^1.5);
a2y = ry2./(norm2.^1.5);
a2z = rz2./(norm2.^1.5);

for i = 0:11
    F1_x = F1.*a1x;
    F1_y = F1.*a1y; 
    F1_z = F1.*a1z;
    F2_x = F2.*a2x ;
    F2_y = F2.*a2y ;
    F2_z = F2.*a2z;
   end

F_tot_x = F1_x + F2_x; 
F_tot_y = F1_y + F2_y;
F_tot_z = F1_z + F2_z; 


%F_tot_X = [1 0 0;0 0 0;0 0 0]*F1 + [1 0 0;0 0 0;0 0 0]*F2;
%F_tot_Y = [0 0 0;0 1 0;0 0 0]*F1 + [0 0 0;0 1 0;0 0 0]*F2;
%F_tot_Z = [0 0 0;0 0 0;0 0 1]*F1 + [0 0 0;0 0 0;0 0 1]*F2;

%F_tot = F_tot_X + F_tot_Y + F_tot_Z;

E_tot_x1 = 1/(10*q) .* F1_x;
E_tot_y1 = 1/(10*q) .* F1_y;
E_tot_z1 = 1/(10*q) .* F1_z;

E_tot_x2 = 1/q .* F2_x;
E_tot_y2 = 1/q .* F2_y;
E_tot_z2 = 1/q .* F2_z;

figure (1)
hold on 
[n k w]= sphere
grid on
c1 = surf(n*a(1,4)+a(1,1),k*a(1,4)+ a(1,2),w*a(1,4) +a(1,3));
c2 = surf(n*a(2,4)+a(2,1),k*a(2,4)+ a(2,2),w*a(2,4) +a(2,3));

%quiver3(x,y,z,F1_x ,F1_y ,F1_z ,1);
%quiver3(x,y,z,F2_x, F2_y, F2_z, 1);
quiver3(x,y,z,E_tot_x1 , E_tot_y1, E_tot_z1,scale);
quiver3(x,y,z,E_tot_x2 , E_tot_y2, E_tot_z2,scale);

axis([-10 10 -10 10 -10 10])
Xlabel('X-axis','fontsize',14)
Ylabel('Y-axis','fontsize',14)
Zlabel('Z-axis','fontsize',14)
title('FIELD X Y Z','fontsize',14)
hold off

figure (2)
hold on
grid on
G1 = plot(-3,0,'.','markersize',60);
set(G1,'MarkerEdgeColor','r')
G2 = plot(3,0,'.','markersize',60);
set(G2,'MarkerEdgeColor','b')

quiver(x,y,E_tot_x1 , E_tot_y1 ,scale);
quiver(x,y,E_tot_x2 , E_tot_y2 ,scale);
axis([-10 10 -10 10])
Xlabel('X-axis','fontsize',14)
Ylabel('Y-axis','fontsize',14)
title('FIELD X Y','fontsize',14)
hold off