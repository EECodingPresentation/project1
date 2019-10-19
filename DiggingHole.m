%将映射成电平后的信号按照要求的比例进行挖孔
function output = DiggingHole(input,holegap)
%%输入输出规范：
    %输入：
    %           1.有限长复数序列input
    %           2.每多少点中挖一个孔
    %输出：挖孔后的序列(从第二个点开始挖）
    
    %%示例：
    %output=DiggingHole([1+j,1-j,j,-j,0.5+0.5j],3);
    
    n=1:length(input);
    n=(mod(n,holegap)==2);
    input(n)=[];
    output=input;