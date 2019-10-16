%% 该文件用于级联所有模块
clear all;
close all;
clc;

%% 参数设定
datalen=100;%随机生成01序列的长度
eff=2;%卷积编码效率，取值{2,3},2代表1/2编码，3代表1/3编码
tail=1;%卷积编码发端是否收尾，取值{0,1}，0代表不收尾，1代表收尾
bitmode=1;%电平映射模式，取值{1,2,3}，1代表1bit/符号，2代表2bit/符号，3代表3bit/符号
channelmode=1;%信道传输模式，取值{1,2}，1表示场景1:即依次通信过程中φ不变，每次通信有独立的φ 2表示场景2:即再一次通信过程中，每次信道使用φ均独立变化
theta=pi/10; %即θ
sigma=0.001; %即σ

knownPhi = 1;  % 解码时是否知道Phi角
%% 连接所有的模块，构成整个通信系统
data=sourcedata(datalen);  %随机生成数据流
convres=model_conv(data,eff,tail);  %卷积编码
mapres=model_map(convres,bitmode);  %电平映射
[channelres, phi]=channel(mapres,channelmode,theta,sigma);  %信道传输

% % 硬判决部分
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