%��ӳ��ɵ�ƽ����źŰ���Ҫ��ı��������ڿ�
function output = DiggingHole(input,holegap, eff)
%%��������淶��
    %���룺
    %           1.���޳���������input
    %           2.ÿ���ٵ�����һ����
    %������ڿ׺������(�ӵڶ����㿪ʼ�ڣ�
    
    %%ʾ����
    %output=DiggingHole([1+j,1-j,j,-j,0.5+0.5j],3);
    if holegap > 2
        n=1:length(input)/eff;
        n=(mod(n,holegap)==2);
        n(end)=0;
        index = boolean(kron(n, ones(1, eff)));
        input(index)=[];
    end
    output=input;