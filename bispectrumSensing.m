
clc
clear
close all
N = 128*64;
n = (0:N-1);
Nfft = 128;
Fs = 1; % 采样频率假定为1
t = n/Fs;
f1 = 0.6381/2/pi;
fai1 = pi/6;
% % 得到SNR为-20时候对应的双谱切片
s0 = 10*cos(2*pi*f1*t + fai1);
SNR = -20;
noi = awgn(s0,SNR(1),0) - s0;
s0 = s0 + noi;

% 使用直接双谱估计方法(基于fft)，bspec:双谱估计，一个Nfft*Nfft的数组;

[bspec,waxis] = BISPECD(s0, Nfft, 1, 64, 0);
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


for SNR_i = 1:length(SNR)
    TRY = 500;
    magnitude = zeros(1,TRY); % 保存双谱切片振幅估计
    aver = zeros(1,TRY);      % 保存每一次蒙特卡洛仿真实验得到的均值
    for Try_i = 1:TRY
        s = s0;
        noi = awgn(s,SNR(SNR_i),0) - s;
        s = s + noi;
        [bspec,waxis] = BISPECD(s, Nfft, 1, 64, 0);
        diagBspec = diag(fliplr(bspec)); % 输出主对角线上的元素
        aver(1, Try_i) = sum(abs(diagBspec))/length(diagBspec);
        magnitude(1, Try_i) = sum(abs(diagBspec))/length(diagBspec);
    end
    % 阀值是动态变化的
    min_aver(1, SNR_i) = min(aver) % 针对每一个不同的信噪比，保存500次实验得到的最小均值，最后取得一个较小的作为阀值
    count=sum(abs(magnitude)>=threshhold)
    Pd(SNR_i)=sum(abs(magnitude)>=threshhold)/TRY;
    Pf(SNR_i)=sum(abs(magnitude)<threshhold)/TRY;
end
figure();
grid on;
figure(1),plot(SNR,Pd);
xlabel('信噪比SNR');
ylabel('检测概率P_{d}');