%���ݽ��յ��ı�������ͨ��CRCУ�����������
function ErrorRate = CRCcheck(input,info_len,check_len)
%%��������淶��
    %���룺
    %           1.���޳�01����input
    %           2.��Ϣ���г��ȣ�����ȡ5��10��25
    %           3.У��λ���ȣ�����ֻȡ����ֵ4��8��12��16
    %����������ʣ�0��1֮��
    
    %%ʾ����
    %output=CECCoding([1,1,1,1,1,1,1,1,0,0,0,0,0,0],5,4);
        %���ɶ���ʽ
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
    Group_len=info_len+check_len;       %ÿ�鳤��Ϊ��Ϣ���г��ȼ�У�����г���
    len=length(input);
    GroupNum=floor(len/Group_len);      %����ж�����
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

