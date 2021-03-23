clc
clear
close all
g = [1 0 1 0 1 0];
[bpsk, bit] = qpskd(g,5);
subplot(2,1,1);plot(bit,'LineWidth',1.5);grid on;
title('Binary Signal')
axis([0 50*length(g) -1.5 1.5]);

subplot(2,1,2);plot(bpsk,'LineWidth',1.5);grid on;
title('QPSK modulation')
axis([0 50*length(g) -1.5 1.5]);
%fskd([1 0 1 1 0],1,2)

Nfft = 128;
[bspec,waxis] = BISPECI(bpsk, Nfft, 1, 64, 0);
close all


%双谱信号（包含相干信号的幅度和相位信息，幅度受信号的功率谱影响）


SS = Nfft/2+1;
waxis1 = waxis(SS:end)*Fs;
bspec1 = bspec(SS:end,SS:end);
[X1,Y1] = meshgrid(waxis1,waxis1);
mesh(X1,Y1,abs(bspec1))
axis tight
xlabel('f1/Hz')
ylabel('f2/Hz')
zlabel('幅度')
title('双谱估计三维图');

figure()
diagBspec  = diag(fliplr(bspec)); % 输出主对角线上的元素
plot(waxis1,abs(diagBspec(SS:end)));
grid on;
xlabel('f/Hz')
ylabel('幅度')
title('双谱估计切片图')
SNR=(-20:10);
Pf=zeros(1,length(SNR));
Pd=zeros(1,length(SNR));
threshhold = 0.004; % 为了取得较大的检测概率，选取较小的阀值
min_aver = zeros(1, length(SNR));