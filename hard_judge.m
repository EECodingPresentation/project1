function bitcode = hard_judge(channelres, bitmode, eff, knownPhi, phi)
    G1 = [1, 0];
    G2 = [0, 0, 1, 1; 0, 1, 1, 0];%1/2效率
    G3 = [0, 0, 0, 0, 1, 1, 1, 1; 0, 0, 1, 1, 1, 1, 0, 0; ...
        0, 1, 1, 0, 0, 1, 1, 0];%1/3效率
    %% 分情况，是否已知Phi角
    if knownPhi
        channelres = channelres .* exp(-1j*phi);
    else
        channelres = channelres .* exp(-1j*theta/2);
    end
    %% 硬判决划分为bit
    switch bitmode
        case 1
            ang = angle(channelres);
            bitcode = G1(mod(round(ang/pi), 2) + 1);
        case 2
            ang = angle(channelres);
            bitcode = G2(: , mod(round(ang*2/pi), 4) + 1);
        case 3
            ang = angle(channelres);
            bitcode = G3(: , mod(round(ang*4/pi), 8) + 1);
        otherwise
            error('invalid bitmode!');
    end
    bitcode = reshape(bitcode, eff, size(bitcode, 1)*size(bitcode, 2)/eff);
end