%������յ��ķ��Ŷ�Ӧ�ڸ�����׼���ŵ���Ը���
%����channelres���յ��ķ��ţ�bitmode����/��������theta
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
            fai=0:theta/10:theta;  % �޸�Ϊ��Բ���
            x_=(x(k)*exp(1j*fai));%��תfai
            %����ŷʽ����(fai�ĺ�����
    %         p=exp(-(real(x_)-real(channelres)).*(real(x_)-real(channelres))...
    %             -(imag(x_)-imag(channelres)).*(imag(x_)-imag(channelres)));
            p = exp(-abs(x_-channelres(1, i)).^2);
            %ŷʽ�����fai���л��ֵõ���Ը��ʣ���������Ӳ�л�����
            probability(i, k)=trapz(fai,p);
        end
    end
    probability = probability ./ sum(probability(i, : ));
end