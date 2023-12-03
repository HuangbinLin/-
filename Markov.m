clear;
clc;


% 生成随机矩阵
N = 100;   %生成100x100随机矩阵
A = rand(N, N) < 0.10; %设置矩阵中出现转移的概率为0.10


% 矩阵归一化
a = sum(A, 2); 
A = A + zeros(N, N);
for k = 1:N
    A(k,:) = A(k,:) / a(k);
end
P = A;

% 人为设置部分状态转移关系
% 使得马尔可夫序列P必然存在封闭子集，分别设置
% 1. 单点闭集（1）和（3） 
% 2. 闭集（2,4,6,8,10）、（7,20,30,50,70,88,90）、(11,12,13,14,15,16)
P = Status_Set(P);


% 遍历马尔可夫矩阵，搜寻所有路径，存储在R1，并将单点闭集存放在C1
[R1,C1] = Path_Dedect(P,N);




% 从R1中找出可能的常返闭集，存放在R2矩阵
f4=1;
R2=zeros(100,100);

for p = 1:10*N
    for q = 1:N
        % 最后一个端点等于起始端点，则可能为常返闭集
        if R1(p,1) == R1(p,q) && R1(p,q+1) == 0 && q~= 1  
            R2(f4,:) = R1(p,:);
            f4 = f4+1;
        break;
        end
    end
end


% 创建Rx矩阵存储可能为常返闭集的路径，R4矩阵存储常返闭集的路径
Rx = R2;
R4 = zeros(N,N);


% 循环遍历Rx矩阵的元素及马尔可夫状态矩阵，判断Rx是否为常返闭集的同时
% 检测其余状态是否能够并入Rx矩阵后，不会影响该条路径的封闭性
% 将确定为闭集的路径存放在R4矩阵，并从Rx矩阵中删除该条路径
% 直到Rx矩阵为空，则循环结束
while(sum(any(Rx,2)) ~= 0)
    % 筛选出1. 闭集  2. 非闭集及其能到达的元素
    [R3,Rx] = is_bi(Rx,N,P);
    % 合并闭集矩阵，直到非闭集筛选完毕
    R4 = Merge(R4,R3);
end




% 从大到小进行排列,并删除单条路径的重复元素
size =  sum(any(R4,2));
R5 = zeros(N,N);
for i = 1:size
    R4(i,:) = sort(R4(i,:),"descend");
    size_l = sum(any(unique(R4(i,:)),1));
    temp = unique(R4(i,:));
    R5(i,1:size_l) = temp(2:end);
end

% 删除R5中的重复的路径，保留
R5 = unique(R5,'rows');
R5(all(R5  == 0,2),:) = [];

% 将单点闭集和常返闭集从状态空间中分离出来,得到非常返态集合D
% C1为单点闭集，R5为常返闭集集合，D为非常返态集合
I = (1:100);
C1(all(C1  == 0,2),:) = [];
D = setdiff(I,C1);  
D = setdiff(D,R5);


disp("===========================================================")
disp("马尔科夫状态空间的分解结果如下:")
disp("------------------------------------------")
disp("吸收态为：")
disp(C1);
disp(" ")
disp(" ")
disp("常返闭集为：")
for i = 1:sum(any(R5,2))
    size_l = length(nonzeros(R5(i,:)));
    disp(R5(i,1:size_l));
end
disp(" ")
disp(" ")
disp("非常返态为：")
disp(D)
disp(" ")




disp("===========================================================")
disp("开始对每个常返闭集进行分解")
Num_bi = sum(any(R5,2));
for i = 1:Num_bi
    % 选取一个常返闭集Fr，进行分解
    % 将常返闭集的路径转换为转移矩阵，注意这里将每个状态重新排序映射为12345。。。
    Fr = R5(i,:);
    R = Matrix_Extracte(P,Fr);
    % 对常返闭集进行查询周期，并进行分解
    [Period,Gn] = Periodic_Analysis(R);
    % 将分解后的子集状态映射到原来的状态
    Gn = Anti_Map(Fr,Gn);
    
    disp("-------------------------------------------------------")
    fprintf('对第%d个常返闭集进行分解 \n',i);
    disp("分解后的子集为：");
    for j = 1:sum(any(Gn,2))
        size_l = length(nonzeros(Gn(j,:)));
        disp(Gn(j,1:size_l));
    end
    disp("该常返闭集的周期为：");
    disp(Period);   
    disp(" ")
end







