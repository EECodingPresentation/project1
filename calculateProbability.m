%������յ��ķ��Ŷ�Ӧ�ڸ�����׼���ŵ���Ը���
function probability=calculateProbability(channelres, bitmode,xita)%����channelres���յ��ķ��ţ�bitmode����/��������xita
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
x_=(x(k)*exp(1j*fai));%��תfai
%����ŷʽ����(fai�ĺ�����
p=exp(-(real(x_)-real(channelres)).*(real(x_)-real(channelres))-(imag(x_)-imag(channelres)).*(imag(x_)-imag(channelres)));
probability(k)=10*trapz(fai,p);%ŷʽ�����fai���л��ֵõ���Ը��ʣ���������Ӳ�л�����
end
end

