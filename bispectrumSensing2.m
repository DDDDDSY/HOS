%双谱域检测信号，噪声为高斯白噪声，方差为0.09。 信号形式见下面程序。


clc
clear
close all

g = [1 0 1 1 1 0 1 0 1 0 1 0 0 0 1 0 1 1 ];
[bpskWithNoise, noise] = QpskWithNoise(g,pi/2);

plot(noise,'LineWidth',1.5);grid on;
bpskWithNoise;
figure(1);
bspech_sigWithNoise = BISPECD(bpskWithNoise);title('信号 + 噪声的二维双谱 ');
xlabel('f1')
ylabel('f2')
axis tight 

figure(2);
mesh(abs(bspech_sigWithNoise));title('信号 + 噪声的三维双谱')
xlabel('f1');
ylabel('f2');
zlabel('幅度')
axis tight 







[bpsk, ~] = qpskd(g,pi/2);
figure(4);
bspech = BISPECD(bpsk);title('信号的二维双谱 ');
xlabel('f1')
ylabel('f2')
axis tight 

figure(5);
mesh(abs(bspech));title('信号的三维双谱')
xlabel('f1')
ylabel('f2')
zlabel('幅度')
axis tight 


figure(6);
diagBspec  = diag(fliplr(bspech)); % 输出主对角线上的元素
plot(abs(diagBspec));
%plot(abs(diagBspec));
axis tight 
grid on;
xlabel('f/Hz')
ylabel('幅度')
title('信号双谱估计切片图')

noise
figure(7);
Bnoise = BISPECD(noise);title('噪声的二维双谱 ');
axis tight 

figure(8);
mesh(abs(Bnoise));title('噪声的三维双谱')
xlabel('f1')
ylabel('f2')
zlabel('幅度')
axis tight 


figure(9);
diagBspecNoise  = diag(fliplr(Bnoise)); % 输出主对角线上的元素
plot(abs(diagBspecNoise));

axis tight 
grid on;
xlabel('f/Hz')
ylabel('幅度')
title('noise双谱估计切片图')

figure(3);
diagBspec  = diag(fliplr(bspech_sigWithNoise)); % 输出主对角线上的元素
diagNoise = diag(fliplr(Bnoise));
f= 0:255;
plot(f,abs(diagBspec),'r',f,abs(diagNoise),'b',f,abs(diagBspec),'k','LineWidth',1.5);
legend({'QPSK + Noise','Noise','QPSK'},'Location','northeast')
axis tight 
grid on;
xlabel('f/Hz')
ylabel('幅度')
title('信号 + 噪声双谱估计切片图')


% x=s+noise;
% plot(noise);title('噪声');
% figure(2);
% plot(x);title('噪声+s');  
% figure(3);
% bspecn=bispecd(noise);title('噪声的双谱');
%figure(1);
%bspech=BISPECD(bpsk);title('s的双谱');
% figure(5);
% bspec=bispecd(x);title('噪声+s的双谱');
% figure(6);
% mesh(abs(bspecn));title('噪声的双谱')

% figure(8);
% mesh(abs(bspec));title('噪声+s的双谱')