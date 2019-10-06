%% 连接所有的模块，构成整个通信系统
data=sourcedata(20);
convres=model_conv(data,2,1);
mapres=model_map(convres,2);
channelres=channel(mapres,1,pi/60,0.001);