function decode_bit = hard_viterbi(bitcode, eff, tail)
    %% 初始化
    len=length(bitcode);
    decode_bit = zeros(1, len);
    num = 8;
    if eff==2
        G=[1,1,0,1;1,1,1,1;];%1/2效率
    elseif eff==3
        G=[1,0,1,1;1,1,0,1;1,1,1,1;];%1/3效率
    end
    P = [4; 2; 1];
    dis = zeros(num, len + 1);  % 记录距离
    pos = zeros(num, len + 1);  % 记录路径
    
    dis(2: end, 1) = Inf;
    dis(: , 2: end) = Inf;
    
    Status = [0, 0, 0; 0, 0, 1; 0, 1, 0; 0, 1, 1; ...
        1, 0, 0; 1, 0, 1; 1, 1, 0; 1, 1, 1];
    trans = cell(num, 2);
    for i = 1: num
        s = Status(i, : )';
        for branch = 0: 1
            stmp = [s; branch];
            trans{i, branch + 1} = mod(G * stmp, 2);
        end
    end
    
    
    %% viterbi译码
    for i = 1: len
        for sNowNum = 1: num
            statusNow = Status(sNowNum, : );

            for branch = 0: 1
                statusNext = [statusNow(2: 3), branch];
                sNextNum = statusNext * P + 1;
                hamming = sum(trans{sNowNum, branch + 1} ~= bitcode(:, i));
                if dis(sNowNum, i) + hamming < dis(sNextNum, i + 1)
                    dis(sNextNum, i + 1) = dis(sNowNum, i) + hamming;
                    pos(sNextNum, i + 1) = sNowNum;
                end
            end
        end
    end
    
    %% 回溯求解最优路径
    if (tail)
        posEnd = 1;
    else
        [~, posEnd] = min(dis(: , end));
    end
    for i = len + 1: -1: 2
        decode_bit(i-1) = mod(posEnd - 1, 2);
        posEnd = pos(posEnd, i);
    end
    
end