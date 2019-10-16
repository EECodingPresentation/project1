%根据接收到的比特流，通过CRC校验计算误码率
function ErrorRate = CRCcheck(input,info_len,check_len)
%%输入输出规范：
    %输入：
    %           1.有限长01序列input
    %           2.信息序列长度，建议取5，10，25
    %           3.校验位长度，这里只取典型值4、8、12、16
    %输出：误码率，0到1之间
    
    %%示例：
    %output=CECCoding([1,1,1,1,1,1,1,1,0,0,0,0,0,0],5,4);
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
    Group_len=info_len+check_len;       %每组长度为信息序列长度加校验序列长度
    len=length(input);
    GroupNum=floor(len/Group_len);      %算出有多少组
    ErrorNum=0;
    for m=1:GroupNum
        d=input((m-1)*Group_len+1:m*Group_len);
        [q,r]=deconv(d,g);
        r=mod(r,2);
        if(any(r))
            ErrorNum=ErrorNum+1;
        end 
    end
    if m*Group_len<len
        GroupNum=GroupNum+1;
        d=input(m*Group_len+1:len);
        [q,r]=deconv(d,g);
       r=mod(r,2);
       if(any(r))
           ErrorNum=ErrorNum+1;
       end 
    end
 ErrorRate=ErrorNum/GroupNum;
end

