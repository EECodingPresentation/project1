%��ӳ��ɵ�ƽ����źŰ���Ҫ��ı��������ڿ�
function output = DiggingHole(input,holegap)
%%��������淶��
    %���룺
    %           1.���޳���������input
    %           2.ÿ���ٵ�����һ����
    %������ڿ׺������(�ӵڶ����㿪ʼ�ڣ�
    
    %%ʾ����
    %output=DiggingHole([1+j,1-j,j,-j,0.5+0.5j],3);
    
    n=1:length(input);
    n=(mod(n,holegap)==2);
    input(n)=[];
    output=input;