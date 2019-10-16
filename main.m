%% ���ļ����ڼ�������ģ��
clear all;
close all;
clc;

%% �����趨
datalen=100;%�������01���еĳ���
eff=2;%�������Ч�ʣ�ȡֵ{2,3},2����1/2���룬3����1/3����
tail=1;%������뷢���Ƿ���β��ȡֵ{0,1}��0������β��1������β
bitmode=1;%��ƽӳ��ģʽ��ȡֵ{1,2,3}��1����1bit/���ţ�2����2bit/���ţ�3����3bit/����
channelmode=1;%�ŵ�����ģʽ��ȡֵ{1,2}��1��ʾ����1:������ͨ�Ź����Цղ��䣬ÿ��ͨ���ж����Ħ� 2��ʾ����2:����һ��ͨ�Ź����У�ÿ���ŵ�ʹ�æվ������仯
theta=pi/10; %����
sigma=0.001; %����

knownPhi = 1;  % ����ʱ�Ƿ�֪��Phi��
%% �������е�ģ�飬��������ͨ��ϵͳ
data=sourcedata(datalen);  %�������������
convres=model_conv(data,eff,tail);  %�������
mapres=model_map(convres,bitmode);  %��ƽӳ��
[channelres, phi]=channel(mapres,channelmode,theta,sigma);  %�ŵ�����

% % Ӳ�о�����
% hard_bitcode = hard_judge(channelres, bitmode, eff, knownPhi, phi);
% % test = reshape(hard_bitcode, 1, size(hard_bitcode, 1)*size(hard_bitcode, 2));
% % Res = test - convres;
% decode_bit = hard_viterbi(hard_bitcode, eff, tail);
% Res = decode_bit ~= [data, zeros(1,3*(tail==1))];
% sum(Res)
bitProb = soft_judge(channelres, bitmode, eff, knownPhi, phi, theta);
decode_bit = soft_viterbi(bitProb, eff, tail);

Res = decode_bit ~= [data, zeros(1,3*(tail==1))];
sum(abs(Res))