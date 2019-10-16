%����һ�����أ����CRCУ��
function output=CRCCoding(input,info_len,check_len)
    %%��������淶��
    %���룺
    %           1.���޳�01����input
    %           2.��Ϣ���г��ȣ�����ȡ5��10��25
    %           3.У��λ���ȣ�����ֻȡ����ֵ4��8��12��16
    %��������޳�01����output
    
    %%ʾ����
    %output=CECCoding([1,1,1,1,1,1,1,1,0,0,0,0,0,0],5,4);
    
    
    %%˼·�����ý����������ʽ�����������Ƕ�Ԫ�����ϵ��ģ2 
    
    %%���룺
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
    len=length(input);          %�������ݳ���
    output=[];
    for m=1:floor(len/info_len)             %�������
        d=input((m-1)*info_len+1:m*info_len);   %��Ϣ����ʽ
        [q,r]=deconv([d,zeros(1,check_len)],g); %ͨ�������������ʽ������rΪ����
        r=mod(r,2);                        %2Ԫ����Ҫģ2
        r_len=length(r);
        output=[output,d,r(r_len+1-check_len:r_len)];   %��Ϣ������У���������Ӻ�ӵ����������
    end
    if m*info_len<len               %����󲿷���ͬ�ϵĲ���
        d=input(m*info_len+1:len);
          [q,r]=deconv([d,zeros(1,check_len)],g);
          r=mod(r,2);
          r_len=length(r);
        output=[output,d,r(r_len+1-check_len:r_len)];
    end
end