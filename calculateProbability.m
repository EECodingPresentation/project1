%计算接收到的符号对应于各个标准符号的相对概率
%参数channelres接收到的符号，bitmode比特/符号数，theta
function probability=calculateProbability(channelres, bitmode,theta)
    switch bitmode
            case 1
                x=[1,-1];
            case 2
                x=[1,1j,-1,-1j];
            case 3
                x=[1,sqrt(0.5)*(1+1j),1j,sqrt(0.5)*(-1+1j),...
                    -1,sqrt(0.5)*(-1-1j),-1j,sqrt(0.5)*(1-1j)];
            otherwise
                error('invalid bitmode!');
    end
    probability=zeros(length(channelres),length(x));
    for i = 1: length(channelres)
        for k=1:length(x)
            fai=0:theta/10:theta;  % 修改为相对步长
            x_=(x(k)*exp(1j*fai));%旋转fai
            %计算欧式距离(fai的函数）
    %         p=exp(-(real(x_)-real(channelres)).*(real(x_)-real(channelres))...
    %             -(imag(x_)-imag(channelres)).*(imag(x_)-imag(channelres)));
            p = exp(-abs(x_-channelres(1, i)).^2);
            %欧式距离对fai进行积分得到相对概率，可以用于硬判或软判
            probability(i, k)=trapz(fai,p);
        end
    end
    probability = probability ./ sum(probability(i, : ));
end