function R = Matrix_Extracte(P,D)

size = length(nonzeros(D(:)));

% 创建转移矩阵R
R = zeros(size,size);

% 遍历路径中元素的关系，如果前者能够到达后者，则在矩阵R中记录转移概率
% 注意这里，我们将路径所有的状态从小到大重新映射为1，2，3.....size
for i = 1:size
    for j = 1:size        
        if( P(D(i),D(j)) > 0  )
            R(i,j) = P(D(i),D(j));
        end
    end
end
