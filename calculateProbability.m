%计算接收到的符号对应于各个标准符号的相对概率
function probability=calculateProbability(channelres, bitmode,xita)%参数channelres接收到的符号，bitmode比特/符号数，xita
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
probability=zeros(1,length(x));
for k=1:length(x)
fai=0:pi/50:xita;
x_=(x(k)*exp(1j*fai));%旋转fai
%计算欧式距离(fai的函数）
p=exp(-(real(x_)-real(channelres)).*(real(x_)-real(channelres))-(imag(x_)-imag(channelres)).*(imag(x_)-imag(channelres)));
probability(k)=10*trapz(fai,p);%欧式距离对fai进行积分得到相对概率，可以用于硬判或软判
end
end

