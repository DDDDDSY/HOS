%˫�������źţ�����Ϊ��˹������������Ϊ0.09�� �ź���ʽ���������


clc
clear
close all

g = [1 0 1 1 1 0 1 0 1 0 1 0 0 0 1 0 1 1 ];
[bpskWithNoise, noise] = QpskWithNoise(g,pi/2);

plot(noise,'LineWidth',1.5);grid on;
bpskWithNoise;
figure(1);
bspech_sigWithNoise = BISPECD(bpskWithNoise);title('�ź� + �����Ķ�ά˫�� ');
xlabel('f1')
ylabel('f2')
axis tight 

figure(2);
mesh(abs(bspech_sigWithNoise));title('�ź� + ��������ά˫��')
xlabel('f1');
ylabel('f2');
zlabel('����')
axis tight 







[bpsk, ~] = qpskd(g,pi/2);
figure(4);
bspech = BISPECD(bpsk);title('�źŵĶ�ά˫�� ');
xlabel('f1')
ylabel('f2')
axis tight 

figure(5);
mesh(abs(bspech));title('�źŵ���ά˫��')
xlabel('f1')
ylabel('f2')
zlabel('����')
axis tight 


figure(6);
diagBspec  = diag(fliplr(bspech)); % ������Խ����ϵ�Ԫ��
plot(abs(diagBspec));
%plot(abs(diagBspec));
axis tight 
grid on;
xlabel('f/Hz')
ylabel('����')
title('�ź�˫�׹�����Ƭͼ')

noise
figure(7);
Bnoise = BISPECD(noise);title('�����Ķ�ά˫�� ');
axis tight 

figure(8);
mesh(abs(Bnoise));title('��������ά˫��')
xlabel('f1')
ylabel('f2')
zlabel('����')
axis tight 


figure(9);
diagBspecNoise  = diag(fliplr(Bnoise)); % ������Խ����ϵ�Ԫ��
plot(abs(diagBspecNoise));

axis tight 
grid on;
xlabel('f/Hz')
ylabel('����')
title('noise˫�׹�����Ƭͼ')

figure(3);
diagBspec  = diag(fliplr(bspech_sigWithNoise)); % ������Խ����ϵ�Ԫ��
diagNoise = diag(fliplr(Bnoise));
f= 0:255;
plot(f,abs(diagBspec),'r',f,abs(diagNoise),'b',f,abs(diagBspec),'k','LineWidth',1.5);
legend({'QPSK + Noise','Noise','QPSK'},'Location','northeast')
axis tight 
grid on;
xlabel('f/Hz')
ylabel('����')
title('�ź� + ����˫�׹�����Ƭͼ')


% x=s+noise;
% plot(noise);title('����');
% figure(2);
% plot(x);title('����+s');  
% figure(3);
% bspecn=bispecd(noise);title('������˫��');
%figure(1);
%bspech=BISPECD(bpsk);title('s��˫��');
% figure(5);
% bspec=bispecd(x);title('����+s��˫��');
% figure(6);
% mesh(abs(bspecn));title('������˫��')

% figure(8);
% mesh(abs(bspec));title('����+s��˫��')