clc;clear;close all;
[num,txt,raw] = xlsread('Resting State.xlsx');
%% one-way ANOVA
x=num(:,1);
group=num(:,4);
%正态性检验
for i=1:3
    x_i=x(group==i); %提取第i个group的睁眼状态下的脑电信号功率值
    [h,p]=lillietest(x_i); %正态性检验
    result(i,:)=p; 
end
result %检验正态检验的p值
 
%方差齐性检验
[p,stats]=vartestn(x,group); %调用vartestn函数进行方差齐次性检验
 
%方差分析
[p,tbl,stats] = anova1(x,group);%单因素一元方差分析
%多重比较
[c,m,h,gnames]=multcompare(stats); %多重比较
head={'组序号','组序号','置信下限','置信上限','组均值差','p-value'};
[head;num2cell(c)]  %将矩阵c转为元胞数组，并与head一起显示
head={'组序号','均值的估计值','标准误差'};
[head;gnames num2cell(m)]  %将m转为元胞数组，和gnames一起显示