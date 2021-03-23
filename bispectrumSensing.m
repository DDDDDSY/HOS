
clc
clear
close all
N = 128*64;
n = (0:N-1);
Nfft = 128;
Fs = 1; % ����Ƶ�ʼٶ�Ϊ1
t = n/Fs;
f1 = 0.6381/2/pi;
fai1 = pi/6;
% % �õ�SNRΪ-20ʱ���Ӧ��˫����Ƭ
s0 = 10*cos(2*pi*f1*t + fai1);
SNR = -20;
noi = awgn(s0,SNR(1),0) - s0;
s0 = s0 + noi;

% ʹ��ֱ��˫�׹��Ʒ���(����fft)��bspec:˫�׹��ƣ�һ��Nfft*Nfft������;

[bspec,waxis] = BISPECD(s0, Nfft, 1, 64, 0);
close all


%˫���źţ���������źŵķ��Ⱥ���λ��Ϣ���������źŵĹ�����Ӱ�죩
SS = Nfft/2+1;
waxis1 = waxis(SS:end)*Fs;
bspec1 = bspec(SS:end,SS:end);
[X1,Y1] = meshgrid(waxis1,waxis1);
mesh(X1,Y1,abs(bspec1))
axis tight
xlabel('f1/Hz')
ylabel('f2/Hz')
zlabel('����')
title('˫�׹�����άͼ');

figure()
diagBspec  = diag(fliplr(bspec)); % ������Խ����ϵ�Ԫ��
plot(waxis1,abs(diagBspec(SS:end)));
grid on;
xlabel('f/Hz')
ylabel('����')
title('˫�׹�����Ƭͼ')
SNR=(-20:10);
Pf=zeros(1,length(SNR));
Pd=zeros(1,length(SNR));
threshhold = 0.004; % Ϊ��ȡ�ýϴ�ļ����ʣ�ѡȡ��С�ķ�ֵ
min_aver = zeros(1, length(SNR));


for SNR_i = 1:length(SNR)
    TRY = 500;
    magnitude = zeros(1,TRY); % ����˫����Ƭ�������
    aver = zeros(1,TRY);      % ����ÿһ�����ؿ������ʵ��õ��ľ�ֵ
    for Try_i = 1:TRY
        s = s0;
        noi = awgn(s,SNR(SNR_i),0) - s;
        s = s + noi;
        [bspec,waxis] = BISPECD(s, Nfft, 1, 64, 0);
        diagBspec = diag(fliplr(bspec)); % ������Խ����ϵ�Ԫ��
        aver(1, Try_i) = sum(abs(diagBspec))/length(diagBspec);
        magnitude(1, Try_i) = sum(abs(diagBspec))/length(diagBspec);
    end
    % ��ֵ�Ƕ�̬�仯��
    min_aver(1, SNR_i) = min(aver) % ���ÿһ����ͬ������ȣ�����500��ʵ��õ�����С��ֵ�����ȡ��һ����С����Ϊ��ֵ
    count=sum(abs(magnitude)>=threshhold)
    Pd(SNR_i)=sum(abs(magnitude)>=threshhold)/TRY;
    Pf(SNR_i)=sum(abs(magnitude)<threshhold)/TRY;
end
figure();
grid on;
figure(1),plot(SNR,Pd);
xlabel('�����SNR');
ylabel('������P_{d}');