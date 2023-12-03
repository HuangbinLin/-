function AMap_M = Anti_Map(Old_M,New_M)

AMap_M = New_M;

size = sum(any(New_M,2));

% 遍历子集，将子集的中被映射为1，2，3，4....size的状态映射回初始的状态
for i = 1:size
    size_l = length(nonzeros(New_M(i,:)));
    for j = 1:size_l
        AMap_M(i,j) = Old_M(New_M(i,j)); 
    end
end