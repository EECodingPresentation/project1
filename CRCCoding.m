%输入一串比特，添加CRC校验
function output=CRCCoding(input,info_len,check_len)
    %%输入输出规范：
    %输入：
    %           1.有限长01序列input
    %           2.信息序列长度，建议取5，10，25
    %           3.校验位长度，这里只取典型值4、8、12、16
    %输出：有限长01序列output
    
    %%示例：
    %output=CECCoding([1,1,1,1,1,1,1,1,0,0,0,0,0,0],5,4);
    
    
    %%思路：利用解卷积代替多项式除法，由于是二元域，最后系数模2 
    
    %%代码：
    %生成多项式
    switch check_len
        case 4
            g=[1,0,0,1,1];  %x4+x+1
        case 8
            g=[1,0,0,1,1,0,0,0,1];  %x8+x5+x4+1
        case 12
            g=[1,1,0,0,0,0,0,0,0,1,1,1,1];  %x12+x11+x3+x2+x+1
        case 16
            g=[1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1];  %x16+x15+x2+1
        otherwise
            error('invalid check_len');
    end
    len=length(input);          %输入数据长度
    output=[];
    for m=1:floor(len/info_len)             %分组计算
        d=input((m-1)*info_len+1:m*info_len);   %信息多项式
        [q,r]=deconv([d,zeros(1,check_len)],g); %通过解卷积计算多项式除法，r为余数
        r=mod(r,2);                        %2元域，需要模2
        r_len=length(r);
        output=[output,d,r(r_len+1-check_len:r_len)];   %信息序列与校验序列连接后接到输出序列中
    end
    if m*info_len<len               %对最后部分做同上的操作
        d=input(m*info_len+1:len);
          [q,r]=deconv([d,zeros(1,check_len)],g);
          r=mod(r,2);
          r_len=length(r);
        output=[output,d,r(r_len+1-check_len:r_len)];
    end
end