clear all
close all
clc

w1 = 5.0;
w2 = 0.0;

eta1 = 0.2;
eta2 = 0.2;

e_old = 0;

t = 0.01;
s = 30;
N = s/t;

m = 1;
b = 0.1;
k = 5;

q = [0.2; 0];
qd= [0; 0];

q_plot = zeros(1,N);
qd_plot = zeros(1,N);
u_plot = zeros(1,N);
w_plot = zeros(2,N);

for i=1:N
    
    e = qd(1)-q(1);
    
    x1 = e;
    x2 = (e - e_old)/t;
    
    e_old = e;
    
    u = w1*x1 + w2*x2;
    
    q(1) = q(1) + t*q(2);
    q(2) = q(2) + t*((1/m)*(u-k*q(1)-b*q(2)));

    w1 = w1 + eta1*u*x1;
    w2 = w2 + eta2*u*x2;
    
    if (w1 < 0)
        w1 = 0;      
    end
    
    if (w2 < 0)
        w2 = 0;
    end
    
    q_plot(i) = q(1);
    qd_plot(i) = qd(1);
    u_plot(i) = u;
    w_plot(:,i) = [w1; w2];
    
end

tp = t:t:s;

figure(1)
hold on
grid on
plot(tp,qd_plot,'r','LineWidth',2)
plot(tp,q_plot,'b--','LineWidth',2)
xlabel('t')
ylabel('x(t) (m)')
legend('x_d','x_a','Location','best')
title('Trayectoria')

figure(2)
hold on
grid on
plot(tp,u_plot,'b','LineWidth',2)
xlabel('t')
ylabel('u(t)')
title('Accion de control')

figure(3)
hold on
grid on
plot(tp,w_plot(1,:),'g','LineWidth',2)
plot(tp,w_plot(2,:),'m','LineWidth',2)
xlabel('t')
ylabel('w')
legend('w1','w2','Location','best')
title('Evolucion de los pesos')