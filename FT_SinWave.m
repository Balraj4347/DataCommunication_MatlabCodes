clc;
clear all;
close all;

dt=0.01;
t=-2:0.01:2;
y=sin(2*pi*t);

subplot(221);
plot(t,y);
axis([-1 1 -2 2]);

w= -15*pi :15*pi;
for i=1:length(w)
    Y(i)=trapz(t,y.* (exp(-1j*w(i)*t)));
end

subplot(222);
plot(w,(fftshift(abs(Y))));
