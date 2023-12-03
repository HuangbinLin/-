function [Period,Gn] = Periodic_Analysis(P)


N=sum(any(P,2));

T1=zeros(N,N);          %过渡矩阵，用来存储某状态经一步转移能进入的状态
f1=1;

% 第一列存储该状态，从第二列开始存储该状态一步转移能够达到的状态
for i=1:N
    T1(i,f1)=i;
    for j=1:N
        if P(i,j)>0     
            f1=f1+1;
            T1(i,f1)=j;
        end
    end
    f1=1;
end
 
% 将能够达到的状态提取出来，即提取2-N列
T2=T1(:,2:N);

% 创建状态空间子集矩阵，每一行为一个子集
Gn=zeros(N,N);       


% 遍历每个状态能够到达的状态，如果当前状态和其他状态能够到达的状态存在包含关系，则二者为同一个子集
f2=1;
for p=1:N
    Gn(p,f2)=p;
    for q=p:N
        % 能达到的状态和其他点能到达的状态存在包含关系，则这2点为同一个子集
        if (ismember(T2(q,:),T2(p,:)) | ismember(T2(p,:), T2(q,:)))  
            f2=f2+1;                     
            Gn(p,f2)=q;                  
        end

        % 当前子集的第一个点和以前子集的存在包含关系，则当前子集清空为0
        if ismember(Gn(p,1),Gn(1:p-1,:))
            Gn(p,:)=0;
        end
    end
    f2=1;
end

% 除去每个子集中重复的第一个状态，即去除第一列
Gn = Gn(:,2:end);


% 检测周期是否为1，即如果状态空间分解后的子集，相互之间存在包含关系
size = sum(any(Gn,2));
flag = 0;
for i = 1:size
    size_l = length(nonzeros(Gn(i,:)));
    for j = 1:size_l
        for k = 1:N
            if(   P(Gn(i,j),k  ) > 0 )
                if(ismember(k,Gn(i,:)))
                    flag = 1;
                end
            end
        end
    end
end

% 如果周期为1，则为为非周期，且状态空间无法分解，仅有一个子集，即为状态空间
if(flag == 1)
    Gn(:,:) = 0;
    for i = 1:N
         Gn(1,i) = i;
         Period = 1;
    end
else
    Period = sum(any(Gn,2));
end

% 删除空状态
Gn(all(Gn  == 0,2),:) = [];


