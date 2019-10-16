%% ���ļ����ڻ�������ͼ
clear all;
close all;
clc;



%% ��������ͼ

% ���������ͼ
z1=[1;-1];
angle=pi/2;
z2=[1;exp(1j*angle);exp(1j*angle*3);exp(1j*angle*2)];
angle=pi/4;
z3=[1;exp(1j*angle);exp(1j*angle*3);exp(1j*angle*2);exp(1j*angle*7);exp(1j*angle*6);exp(1j*angle*4);exp(1j*angle*5)];
figure;
hold on;
subplot(2,2,1),scatter(real(z1),imag(z1),100),axis([-1.2,1.2,-1.2,1.2]),title('1bit/����','FontSize',16);% ������ͼ
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % ��Բ
L={'0','1'};
text(real(z1)+0.05,imag(z1)+0.05,L,'FontSize',16);
subplot(2,2,2),scatter(real(z2),imag(z2),100),axis([-1.2,1.2,-1.2,1.2]),title('2bit/����','FontSize',16);% ������ͼ
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % ��Բ
L={'00','01','10','11'};
text(real(z2)+0.05,imag(z2)+0.05,L,'FontSize',16);
subplot(2,2,3),scatter(real(z3),imag(z3),100),axis([-1.2,1.2,-1.2,1.2]),title('3bit/����','FontSize',16);% ������ͼ
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % ��Բ
L={'000','001','010','011','100','101','110','111'};
text(real(z3)+0.05,imag(z3)+0.05,L,'FontSize',16);

% ���ն�����ͼ
figure;
datalen=10000;%�������01���еĳ���
tail=1;%������뷢���Ƿ���β��ȡֵ{0,1}��0������β��1������β
channelmode=2;%�ŵ�����ģʽ��ȡֵ{1,2}��1��ʾ����1:������ͨ�Ź����Цղ��䣬ÿ��ͨ���ж����Ħ� 2��ʾ����2:����һ��ͨ�Ź����У�ÿ���ŵ�ʹ�æվ������仯
theta=pi/6; %����
sigma=0.1; %����

%% eff=2,bitmode=1,theta=pi/6,sigma=0.1
eff=2;%�������Ч�ʣ�ȡֵ{2,3},2����1/2���룬3����1/3����
bitmode=1;%��ƽӳ��ģʽ��ȡֵ{1,2,3}��1����1bit/���ţ�2����2bit/���ţ�3����3bit/����
data=sourcedata(datalen);  %�������������
convres=model_conv(data,eff,tail);  %�������
mapres=model_map(convres,bitmode);  %��ƽӳ��
[channelres, phi]=channel(mapres,channelmode,theta,sigma);  %�ŵ�����
% zplane(channelres.',[]);
subplot(2,2,1),scatter(real(channelres),imag(channelres),1),axis([-1.2,1.2,-1.2,1.2]),title('1bit/����','FontSize',16);% ������ͼ
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % ��Բ
L={'0','1'};
text(real(z1)+0.05,imag(z1)+0.05,L,'FontSize',16);

%% eff=2,bitmode=2,theta=pi/6,sigma=0.1
eff=2;%�������Ч�ʣ�ȡֵ{2,3},2����1/2���룬3����1/3����
bitmode=2;%��ƽӳ��ģʽ��ȡֵ{1,2,3}��1����1bit/���ţ�2����2bit/���ţ�3����3bit/����
data=sourcedata(datalen);  %�������������
convres=model_conv(data,eff,tail);  %�������
mapres=model_map(convres,bitmode);  %��ƽӳ��
[channelres, phi]=channel(mapres,channelmode,theta,sigma);  %�ŵ�����
subplot(2,2,2),scatter(real(channelres),imag(channelres),1),axis([-1.2,1.2,-1.2,1.2]),title('2bit/����','FontSize',16);% ������ͼ
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % ��Բ
L={'00','01','10','11'};
text(real(z2)+0.05,imag(z2)+0.05,L,'FontSize',16);

%% eff=3,bitmode=3,theta=pi/6,sigma=0.1
eff=3;%�������Ч�ʣ�ȡֵ{2,3},2����1/2���룬3����1/3����
bitmode=3;%��ƽӳ��ģʽ��ȡֵ{1,2,3}��1����1bit/���ţ�2����2bit/���ţ�3����3bit/����
data=sourcedata(datalen);  %�������������
convres=model_conv(data,eff,tail);  %�������
mapres=model_map(convres,bitmode);  %��ƽӳ��
[channelres, phi]=channel(mapres,channelmode,theta,sigma);  %�ŵ�����
subplot(2,2,3),scatter(real(channelres),imag(channelres),1),axis([-1.2,1.2,-1.2,1.2]),title('3bit/����','FontSize',16);% ������ͼ
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % ��Բ
L={'000','001','010','011','100','101','110','111'};
text(real(z3)+0.05,imag(z3)+0.05,L,'FontSize',16);