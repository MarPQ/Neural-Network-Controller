clear all
close all
clc

w1 = 2;
w2 = 0;

eta1 = 0.1;
eta2 = 0.1;

e_old = 0;

t = 0.01;
s = 50;
N = s/t;

xi = 0;
vi = 0;
xd = 0.5;

xi_plot = zeros(1,N);
xd_plot = zeros(1,N);
u_plot = zeros(1,N);
w_plot = zeros(2,N);

for i=1:N
    
    e = xd-xi;
    
    x1 = e;
    x2 = (e-e_old)/t;
    
    e_old = e;
    
    u = w1*x1 + w2*x2;
    
    vi = vi + u*t;
    xi = xi + vi*t + 0.5*u*t^2;
    
    w1 = w1 + eta1*u*x1;
    w2 = w2 + eta2*u*x2;
    
    if (w1 < 0)
        w1 = 0;      
    end
    
    if (w2 < 0)
        w2 = 0;
    end
    
    xi_plot(i) = xi;
    xd_plot(i) = xd;
    u_plot(i) = u;
    w_plot(:,i) = [w1; w2];
    
end

tp = t:t:s;

figure(1)
hold on
grid on
plot(tp,xd_plot,'r','LineWidth',2)
plot(tp,xi_plot,'b--','LineWidth',2)
xlabel('t')
ylabel('x(t)')
legend('xd','xi','Location','best')
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
plot(tp,w_plot(1,:),'r','LineWidth',2)
plot(tp,w_plot(2,:),'b','LineWidth',2)
xlabel('t')
ylabel('w')
legend('w1','w2','Location','best')
title('Evolucion de los pesos')