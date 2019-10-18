function [output, phi]=channel(input,mode,theta,sigma)  %高斯噪声信道
    %% 输入输出规范:
        % input:x
        % mode: 1表示场景1:即依次通信过程中φ不变，每次通信有独立的φ
        %       2表示场景2:即在一次通信过程中，每次信道使用φ均独立变化
        % theta: 即θ，收发端已知参数
        % sigma: 即σ，收发端已知参数
    
    %% 示例:
    %  output=channel([1,j,-j,-1],1,pi/60,0.001);
    %% 思路:
    % y=xexp(jφ)+n
    
    %% 代码:
    len=length(input);%得到输入复电平序列的长度
    n=normrnd(0,sigma,1,len)+1j*normrnd(0,sigma,1,len);%高斯噪声
    if mode==1 %将一次调用试做依次通信，本次通信φ保持不变
        phi=rand(1)*theta; %phi即φ，在本次通信中保持不变
        output=input*exp(j*phi)+n;
    elseif mode==2
        phi=rand(1,len)*theta; %每次信道使用均独立变化
        output=input.*exp(j*phi)+n;
    end
    
end