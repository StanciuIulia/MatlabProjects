close all
clear
clc

alpha = 1.5;
t = 0:0.01:8;
n = 0;

S0 = [0 1];
fprintf('S0:')
disp(S0)

n = n + 1;
S1 = [-1 1+alpha];
fprintf('S1:')
disp(S1)

n = n + 1;
S2 = conv([(-1/n) (2-1/n+alpha/n)], S1) + conv([0 (-1+1/n-alpha/n)], S0);
fprintf('S2:')
disp(S2)

n = n + 1;
S3 = conv([(-1/n) (2-1/n+alpha/n)], S2) + conv([0 0 (-1+1/n-alpha/n)], S1);
fprintf('S3:')
disp(S3)

n = n + 1;
S4 = conv([(-1/n) (2-1/n+alpha/n)], S3) + conv([0 0 (-1+1/n-alpha/n)], S2);
fprintf('S4:')
disp(S4)

n = n + 1;
S5 = conv([(-1/n) (2-1/n+alpha/n)], S4) + conv([0 0 (-1+1/n-alpha/n)], S3);
fprintf('S5:')
disp(S5)

%for ramdom n and alpha
n = 9;
alpha = 3;
S_before_last = S0;
S_last = S1;

for i = 2:n
    Coefficient1 = [(-1/i) (2-1/i+alpha/i)];
    Coefficient0 = [0 (-1+1/i-alpha/i)];
    
    l1 = length(S_last);
    l0 = length(S_before_last);
    
    S_before_last = [zeros(1, l1-l0), S_before_last];
    
    S = conv(Coefficient1, S_last) + conv(Coefficient0, S_before_last);
    
    S_before_last = S_last;
    S_last = S;
end

fprintf('Polynomial function of grade %d and alpha %f is S%d:', n, alpha, n)
disp(S)

ls5 = length(S5);
ls4 = length(S4);
ls3 = length(S3);
ls2 = length(S2);
ls1 = length(S1);
ls0 = length(S0);

S4 = [zeros(1, ls5-ls4), S4];
S3 = [zeros(1, ls5-ls3), S3];
S2 = [zeros(1, ls5-ls2), S2];
S1 = [zeros(1, ls5-ls1), S1];
S0 = [zeros(1, ls5-ls0), S0];

plot(t,polyval(S5,t)); hold on
plot(t,polyval(S4,t));
plot(t,polyval(S3,t))
plot(t,polyval(S2,t))
plot(t,polyval(S1,t))
plot(t,polyval(S0,t))

axis([0 8 -10 10])
grid on

xlabel('t')
ylabel('S_n(t)')
title('Sonine polynomials (fixed parameter value α = 1.5) up to degree 5')
legend('S_0', 'S_1', 'S_2', 'S_3', 'S_4', 'S_5','Location','best')