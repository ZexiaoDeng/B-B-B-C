function [ x, y, info ] = SplexSolver( C, A, B, varargin )
% 2020-4-2 臻orz
%inputs:
%   A:系数矩阵 m*n
%   B:右端向量 m*1
%   C:价格系数向量 n*1
%alternative inputs:
%   target:优化目标 0 ~ min; 1 ~ max;
%   sign:约束条件符号向量 m*1 其中
%       -1 ~ '<=';0 ~ '=';1 ~ '>'; 默认为0,即为等式
%outputs:
%   x:最优解 n*1
%   y:最优值 num
%   exitflag:是否找到最优解

%check inputs
ip = inputParser;
ip.addRequired('A',@(x)validateattributes(x,{'double'},...
    {'finite','nonnan'},'BigMSimplexAlgorithm','A',1));
ip.addRequired('B',@(x)validateattributes(x,{'double'},...
    {'size',[size(A,1),1]},'BigMSimplexAlgorithm','B',2));
ip.addRequired('C',@(x)validateattributes(x,{'double'},...
    {'size',[size(A,2),1]},'BigMSimplexAlgorithm','C',3));
ip.addParameter('target',0,@(x)validateattributes(x,...
    {'double'},{'scalar'},'BigMSimplexAlgorithm','target'));
ip.addParameter('sign',zeros(size(A,1),1),@(x)validateattributes(x,...
    {'double'},{'size',[size(A,1),1]},'BigMSimplexAlgorithm','sign'));
ip.parse(A,B,C,varargin{:});

%initialize
target = ip.Results.target;
sign = ip.Results.sign;
[m,n] = size(A);
idx_B = [];
x = zeros(n,1);
y = 0;
exitflag = 0;
j = 0;

%standardization
if target
    C = -C;%目标函数的转化
end
A(B<0,:) = -A(B<0,:);
sign(B<0,:) = -sign(B<0,:);
B = abs(B);%约束条件的转化
for i = sign'
    j = j+1;
    switch i
        case -1%引入松弛变量
            a = zeros(m,1);a(j) = 1;
            A = [A a];
            C = [C;0];
        case 1%引入剩余变量
            a = zeros(m,1);a(j) = -1;
            A = [A a];
            C = [C;0];
    end
end
n1 = size(A,2);%记录转化标准型的未知量的个数
C1 = C;
C = zeros(n1,1);

%找寻单位矩阵
for i = 1:m
    a = 0;
    for j = find(A(i,:)==1)
        if sum(A(:,j)==0) == m-1
            idx_B = [idx_B j];
            a = 1;
        end
    end
    if ~a%若该行无基解,引入人工变量
        j = zeros(m,1);j(i) = 1;
        A = [A j];
        idx_B = [idx_B size(A,2)];
        C = [C;1];
    end
end

idx_B = idx_B(1:m);
CB = C(idx_B);%基变量对应的价值系数
sigma = C'-CB'*inv(A(:,idx_B))*A;
sigma(idx_B) = 0;
SimplexAlgorithmIteration();%第一阶段迭代
if y
    exitflag = 0;%如果返回目标值不为0，则不存在最优解
    return;
end
C = C1;
A = A(:,1:size(C,1));
CB = C(idx_B);
sigma = C'-CB'*inv(A(:,idx_B))*A;
sigma(idx_B) = 0;
SimplexAlgorithmIteration();%第二阶段迭代

info.Aeq = A ;
info.beq = B ;
info.c   = C ;
info.idx_B = idx_B ;

info.exitflag = exitflag ;


function []=SimplexAlgorithmIteration()
    while 1       
        if ~sum(sigma<0)
            if sum(idx_B>n1)%如果基变量含有人工变量
                return;
            end
            x = zeros(n1,1);
            x(idx_B) = B;
            x = x(1:n);%舍去引入的松弛变量与剩余变量
            if target
                y = -CB'*B;
            else
                y = CB'*B;
            end
            exitflag = 1;
            return;
        end
        pivot_y = find(sigma==min(sigma));
        pivot_y = pivot_y(1);
        if sum(A(:,pivot_y)<0) == m
            return;
        end
        theta_index = find(A(:,pivot_y)>0);
        theta = B(theta_index)./A(theta_index,pivot_y);
        pivot_x = theta_index(theta==min(theta));%确定主元
        pivot_x = pivot_x(1);
        idx_B(pivot_x) = pivot_y;%更新idx_B
        CB(pivot_x) = C(pivot_y);%更新CB
        %更新系数矩阵
        B(pivot_x) = B(pivot_x)/A(pivot_x,pivot_y);
        A(pivot_x,:) = A(pivot_x,:)./A(pivot_x,pivot_y);
        a = 1:m;
        a(pivot_x) = [];
        for i = a
            B(i) = B(i)-A(i,pivot_y)*B(pivot_x);
            A(i,:) = A(i,:)-A(i,pivot_y)*A(pivot_x,:);    
        end
        sigma = sigma-sigma(pivot_y)*A(pivot_x,:);%更新sigma
    end
end




end
