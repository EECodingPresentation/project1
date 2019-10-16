function optimalfai=calculatefai(channelres, bitmode,xita)
%��faiδ֪���̶�������¼�������Ȼ��fai������channelresΪһ���������������еĽ��յ��ķ���

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
num=100;%��xita20�ȷ���Ϊfai�Ŀ���ȡֵ���ɵ����Ĳ���
sum=zeros(1,num+1);
product=zeros(1,num+1);
fai=0:xita/num:xita;
 for m=1:length(channelres)
    for k=1:length(x)
        sum=sum+exp(-(real(x(k)*exp(1j*fai))-real(channelres(m))).^2-(imag(x(k)*exp(1j*fai))-imag(channelres(m))).^2);
        %��һ�����յķ��ţ�������Ϊ������׼����ͨ����˹����ƫ�ƶ����ĸ���֮��
    end
    product=product+log(sum);
    %���������ܵ��źŵĸ�����ˣ���log��ӣ�
    sum=0;
 end
%�Ƚ�num+1��fai�Ŀ���ȡֵ���ʴ�С����������Ȼ��fai
minindex=find(product == max(product));
optimalfai=xita/num*(minindex(1)-1);


    
