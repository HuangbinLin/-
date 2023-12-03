function [R4,Rx]= is_bi(R2,N,P) 

% 创建Rx可能闭集矩阵和R4闭集路径矩阵
R3 = R2(1:N,:);
R4 = zeros(N,N);
Rx = zeros(N,N);
fx_n = 1;
f5 = 1;



for p = 1:N       % 遍历R3的路径
    fx = 0;
    count = 0;
    for q = 1:N   % 遍历当前路径的所有节点
        a1 = 0;
        m = R3(p,q);  % 取出当前路径的当前节点
        n = length(nonzeros(R3(p,:))); % 计算当前路径非零元素的个数
        if m ~= 0
            for k = 1:N  % 遍历马尔可夫空间的所有状态
                % k不在路径里面，m为路径中的遍历单个元素，m到k的概率均为0，则称对k元素闭，即k元素进来不能再出去了
                if (ismember(k,R3(p,:)) == 0) && (P(m,k) == 0)
                    a1 = a1 + 1;  % 记录对元素闭的个数  
                    if a1 == N - n + 1 % 当前节点对N-n+1个元素闭，则当前节点为闭节点
                        count= 1 + count;
                    end 
                % 不在路径里面的k，但是路径内的却能到达，记录下来k和路径
                elseif (ismember(k,R3(p,:)) == 0) && (P(m,k) ~= 0)
                    if(fx == 0)
                        Rx(fx_n,:) = R3(p,:);
                    end
                    fx = fx + 1;
                    Rx(fx_n,n+fx) = k;       
                end 
            end
        end
    end
    if count == n  % 如果当前路径所有元素都是闭节点，则为闭集
        R4(f5,:) = R3(p,:);  % 保存到R4
        f5 = f5 + 1;
    end
    fx_n = fx_n + 1;
end
% 整理可能为闭集的路径矩阵
Rx = sortrows(Rx,-1);