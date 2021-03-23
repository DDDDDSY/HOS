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