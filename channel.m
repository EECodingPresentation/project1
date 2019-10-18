function [output, phi]=channel(input,mode,theta,sigma)  %��˹�����ŵ�
    %% ��������淶:
        % input:x
        % mode: 1��ʾ����1:������ͨ�Ź����Цղ��䣬ÿ��ͨ���ж����Ħ�
        %       2��ʾ����2:����һ��ͨ�Ź����У�ÿ���ŵ�ʹ�æվ������仯
        % theta: ���ȣ��շ�����֪����
        % sigma: ���ң��շ�����֪����
    
    %% ʾ��:
    %  output=channel([1,j,-j,-1],1,pi/60,0.001);
    %% ˼·:
    % y=xexp(j��)+n
    
    %% ����:
    len=length(input);%�õ����븴��ƽ���еĳ���
    n=normrnd(0,sigma,1,len)+1j*normrnd(0,sigma,1,len);%��˹����
    if mode==1 %��һ�ε�����������ͨ�ţ�����ͨ�Ŧձ��ֲ���
        phi=rand(1)*theta; %phi���գ��ڱ���ͨ���б��ֲ���
        output=input*exp(j*phi)+n;
    elseif mode==2
        phi=rand(1,len)*theta; %ÿ���ŵ�ʹ�þ������仯
        output=input.*exp(j*phi)+n;
    end
    
end