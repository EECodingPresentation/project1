clear all;
close all;
clc;

%% �����趨
datalen=120;%�������01���еĳ���
% eff=2;%�������Ч�ʣ�ȡֵ{2,3},2����1/2���룬3����1/3����
tail=1;%������뷢���Ƿ���β��ȡֵ{0,1}��0������β��1������β
% bitmode=1;%��ƽӳ��ģʽ��ȡֵ{1,2,3}��1����1bit/���ţ�2����2bit/���ţ�3����3bit/����
channelmode=2;%�ŵ�����ģʽ��ȡֵ{1,2}��1��ʾ����1:������ͨ�Ź����Цղ��䣬ÿ��ͨ���ж����Ħ� 2��ʾ����2:����һ��ͨ�Ź����У�ÿ���ŵ�ʹ�æվ������仯
theta=pi/6; %����
sigma=0.5; %����
% S=[0.5,1,1.5,2,2.5,3,3.5,4,4.5,5];

Bitmode=[1,1,2,2,3,3,1,1,3,3];
Eff=[2,2,2,2,2,2,3,3,3,3];
% Tail=[0,1,0,1,0,1,0,1,0,1];
Sigma=[0.3,0.6,0.3,0.6,0.3,0.6,0.3,0.6,0.3,0.6];

figure ;

for k=1:10
%     sigma=S(k);
    bitmode=Bitmode(k);
    eff=Eff(k);
    sigma=Sigma(k);
    knownPhi = 0;  % ����ʱ�Ƿ�֪��Phi��
    holegap = 4;
    %% �������е�ģ�飬��������ͨ��ϵͳ
    data=sourcedata(datalen);  %�������������
    convres=model_conv(data,eff,tail);  %�������

    convres = DiggingHole(convres, holegap, eff);

    mapres=model_map(convres,bitmode);  %��ƽӳ��
    [channelres, phi]=channel(mapres,channelmode,theta,sigma);  %�ŵ�����

    %����̶����ǲ���֪phi�ǣ��ȼ��������ܵ�phi
    if (~knownPhi) && (channelmode)
        phi=calculatefai(channelres,bitmode,theta);
        knownPhi=1;
    end

    % Ӳ�о�����
    hard_bitcode = hard_judge(channelres, bitmode, eff, knownPhi, phi);
    decode_bit = hard_viterbi(hard_bitcode, eff, tail, holegap);
    Res = decode_bit(1:length([data,zeros(1,3*(tail==1))])) ~= [data, zeros(1,3*(tail==1))];
    subplot(5,2,k);
    stem(Res,'MarkerSize',1);
    title([num2str(bitmode),'bit/����;�������Ч��1/',num2str(eff),';��=',num2str(sigma)]) 
    sum(abs(Res))
end