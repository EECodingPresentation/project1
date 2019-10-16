%% 该文件用于绘制星座图
clear all;
close all;
clc;



%% 绘制星座图

% 发射端星座图
z1=[1;-1];
angle=pi/2;
z2=[1;exp(1j*angle);exp(1j*angle*3);exp(1j*angle*2)];
angle=pi/4;
z3=[1;exp(1j*angle);exp(1j*angle*3);exp(1j*angle*2);exp(1j*angle*7);exp(1j*angle*6);exp(1j*angle*4);exp(1j*angle*5)];
figure;
hold on;
subplot(2,2,1),scatter(real(z1),imag(z1),100),axis([-1.2,1.2,-1.2,1.2]),title('1bit/符号','FontSize',16);% 画星座图
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % 画圆
L={'0','1'};
text(real(z1)+0.05,imag(z1)+0.05,L,'FontSize',16);
subplot(2,2,2),scatter(real(z2),imag(z2),100),axis([-1.2,1.2,-1.2,1.2]),title('2bit/符号','FontSize',16);% 画星座图
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % 画圆
L={'00','01','10','11'};
text(real(z2)+0.05,imag(z2)+0.05,L,'FontSize',16);
subplot(2,2,3),scatter(real(z3),imag(z3),100),axis([-1.2,1.2,-1.2,1.2]),title('3bit/符号','FontSize',16);% 画星座图
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % 画圆
L={'000','001','010','011','100','101','110','111'};
text(real(z3)+0.05,imag(z3)+0.05,L,'FontSize',16);

% 接收端星座图
figure;
datalen=10000;%随机生成01序列的长度
tail=1;%卷积编码发端是否收尾，取值{0,1}，0代表不收尾，1代表收尾
channelmode=2;%信道传输模式，取值{1,2}，1表示场景1:即依次通信过程中φ不变，每次通信有独立的φ 2表示场景2:即再一次通信过程中，每次信道使用φ均独立变化
theta=pi/6; %即θ
sigma=0.1; %即σ

%% eff=2,bitmode=1,theta=pi/6,sigma=0.1
eff=2;%卷积编码效率，取值{2,3},2代表1/2编码，3代表1/3编码
bitmode=1;%电平映射模式，取值{1,2,3}，1代表1bit/符号，2代表2bit/符号，3代表3bit/符号
data=sourcedata(datalen);  %随机生成数据流
convres=model_conv(data,eff,tail);  %卷积编码
mapres=model_map(convres,bitmode);  %电平映射
[channelres, phi]=channel(mapres,channelmode,theta,sigma);  %信道传输
% zplane(channelres.',[]);
subplot(2,2,1),scatter(real(channelres),imag(channelres),1),axis([-1.2,1.2,-1.2,1.2]),title('1bit/符号','FontSize',16);% 画星座图
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % 画圆
L={'0','1'};
text(real(z1)+0.05,imag(z1)+0.05,L,'FontSize',16);

%% eff=2,bitmode=2,theta=pi/6,sigma=0.1
eff=2;%卷积编码效率，取值{2,3},2代表1/2编码，3代表1/3编码
bitmode=2;%电平映射模式，取值{1,2,3}，1代表1bit/符号，2代表2bit/符号，3代表3bit/符号
data=sourcedata(datalen);  %随机生成数据流
convres=model_conv(data,eff,tail);  %卷积编码
mapres=model_map(convres,bitmode);  %电平映射
[channelres, phi]=channel(mapres,channelmode,theta,sigma);  %信道传输
subplot(2,2,2),scatter(real(channelres),imag(channelres),1),axis([-1.2,1.2,-1.2,1.2]),title('2bit/符号','FontSize',16);% 画星座图
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % 画圆
L={'00','01','10','11'};
text(real(z2)+0.05,imag(z2)+0.05,L,'FontSize',16);

%% eff=3,bitmode=3,theta=pi/6,sigma=0.1
eff=3;%卷积编码效率，取值{2,3},2代表1/2编码，3代表1/3编码
bitmode=3;%电平映射模式，取值{1,2,3}，1代表1bit/符号，2代表2bit/符号，3代表3bit/符号
data=sourcedata(datalen);  %随机生成数据流
convres=model_conv(data,eff,tail);  %卷积编码
mapres=model_map(convres,bitmode);  %电平映射
[channelres, phi]=channel(mapres,channelmode,theta,sigma);  %信道传输
subplot(2,2,3),scatter(real(channelres),imag(channelres),1),axis([-1.2,1.2,-1.2,1.2]),title('3bit/符号','FontSize',16);% 画星座图
rectangle('Position',[-1, -1, 2, 2],'Curvature',[1, 1]);axis equal; % 画圆
L={'000','001','010','011','100','101','110','111'};
text(real(z3)+0.05,imag(z3)+0.05,L,'FontSize',16);