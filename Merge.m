function [Tx] = Merge(T1,T2,T3,T4,T5,T6,T7) 


% 根据输入的闭集个数进行矩阵的合并
if(nargin == 1)
    Tx = T1;

elseif (nargin ==2)
    a = sum(any(T1,2));
    b = sum(any(T2,2));
    Tx(1:a,:) = T1(1:a,:);
    Tx(a+1:a+b,:) = T2(1:b,:);

elseif (nargin ==3)
    a = sum(any(T1,2));
    b = sum(any(T2,2));
    c = sum(any(T3,2));
    Tx(1:a,:) = T1(1:a,:);
    Tx(a+1:a+b,:) = T2(1:b,:);
    Tx(a+b+1:a+b+c,:) = T3(1:c,:);

elseif (nargin ==4)
    a = sum(any(T1,2));
    b = sum(any(T2,2));
    c = sum(any(T3,2));
    d = sum(any(T4,2));
    Tx(1:a,:) = T1(1:a,:);
    Tx(a+1:a+b,:) = T2(1:b,:);
    Tx(a+b+1:a+b+c,:) = T3(1:c,:);
    Tx(a+b+c+1:a+b+c+d,:) = T4(1:d,:);

elseif (nargin ==5)
    a = sum(any(T1,2));
    b = sum(any(T2,2));
    c = sum(any(T3,2));
    d = sum(any(T4,2));
    e = sum(any(T5,2));
    Tx(1:a,:) = T1(1:a,:);
    Tx(a+1:a+b,:) = T2(1:b,:);
    Tx(a+b+1:a+b+c,:) = T3(1:c,:);
    Tx(a+b+c+1:a+b+c+d,:) = T4(1:d,:);
    Tx(a+b+c+d+1:a+b+c+d+e,:) = T5(1:e,:);

elseif (nargin ==6)
    a = sum(any(T1,2));
    b = sum(any(T2,2));
    c = sum(any(T3,2));
    d = sum(any(T4,2));
    e = sum(any(T5,2));
    f = sum(any(T6,2));
    Tx(1:a,:) = T1(1:a,:);
    Tx(a+1:a+b,:) = T2(1:b,:);
    Tx(a+b+1:a+b+c,:) = T3(1:c,:);
    Tx(a+b+c+1:a+b+c+d,:) = T4(1:d,:);
    Tx(a+b+c+d+1:a+b+c+d+e,:) = T5(1:e,:);
    Tx(a+b+c+d+e+1:a+b+c+d+e+f,:) = T6(1:f,:);

elseif (nargin ==7)
    a = sum(any(T1,2));
    b = sum(any(T2,2));
    c = sum(any(T3,2));
    d = sum(any(T4,2));
    e = sum(any(T5,2));
    f = sum(any(T6,2));
    g = sum(any(T7,2));
    Tx(1:a,:) = T1(1:a,:);
    Tx(a+1:a+b,:) = T2(1:b,:);
    Tx(a+b+1:a+b+c,:) = T3(1:c,:);
    Tx(a+b+c+1:a+b+c+d,:) = T4(1:d,:);
    Tx(a+b+c+d+1:a+b+c+d+e,:) = T5(1:e,:);
    Tx(a+b+c+d+e+1:a+b+c+d+e+f,:) = T6(1:f,:);
    Tx(a+b+c+d+e+f+1:a+b+c+d+e+f+g,:) = T6(1:g,:);
end


