close all
clear
clc

R = 10;
K = 20;
a = 5 .* R.^2;
 
x = -60:5:60;
y = x;
[xx,yy] = meshgrid(x,y);

z = -1 .* K .* exp((xx.^2+yy.^2)/-a);
mesh(x,y,z); hold on

psi = linspace(0,pi,13);
theta = linspace(0,2*pi,23);
psi = [psi; psi];
theta = [theta; theta];
[psi,theta] = meshgrid(psi,theta);

X = R.*sin(psi).*cos(theta);
Y = R.*sin(psi).*sin(theta);
Z = R.*cos(psi) - K + R;
mesh(X,Y,Z)

title("Distorted plane 2022 - Stanciu Iulia")
axis off
axis equal 

