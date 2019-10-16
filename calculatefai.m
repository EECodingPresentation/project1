function optimalfai=calculatefai(channelres, bitmode,xita)
%在fai未知但固定的情况下计算出最概然的fai，参数channelres为一行向量，包含所有的接收到的符号

switch bitmode
        case 1
          x=[1,-1];
        case 2
           x=[1,1j,-1,-1j];
        case 3
             x=[1,sqrt(0.5)*(1+1j),1j,sqrt(0.5)*(-1+1j),-1,sqrt(0.5)*(-1-1j),-1j,sqrt(0.5)*(1-1j)];
        otherwise
            error('invalid bitmode!');
end
num=100;%将xita20等分作为fai的可能取值，可调整的参数
sum=zeros(1,num+1);
product=zeros(1,num+1);
fai=0:xita/num:xita;
 for m=1:length(channelres)
    for k=1:length(x)
        sum=sum+exp(-(real(x(k)*exp(1j*fai))-real(channelres(m))).^2-(imag(x(k)*exp(1j*fai))-imag(channelres(m))).^2);
        %对一个接收的符号，计算其为各个标准符号通过高斯噪声偏移而来的概率之和
    end
    product=product+log(sum);
    %将各个接受的信号的概率相乘（即log相加）
    sum=0;
 end
%比较num+1个fai的可能取值概率大小，计算出最概然的fai
minindex=find(product == max(product));
optimalfai=xita/num*(minindex(1)-1);


    
