% ===============================
% 整数规划
% 孙小玲, 李端, 科学出版社
% 例题8.5, P91
% ================================
%   min     -4x1 +  x2
%   s.t.     7x1 - 2x2 <= 14
%                  1x2 <= 3
%            2x1 - 2x2 <= 3
%             x1,   x2 in Z+
% ================================




clc ;
clear ;
close all ;
format rat ;                            % 元素使用分数表示

c = [ -4  ; 1  ; ] ;
A = [  7  , -2 ; ...
       0  ,  1 ; ...
       2  , -2 ; ] ;
b = [  14 ; ...
       3  ; ...
       3  ; ] ;
D = [ -1 ; -1 ; -1 ; ] ;        % 符号索引 <=

idx_I = 1: 2 ;                  % 整数索引, x1, x2 in Z+

maxIter = 500 ;                     % 最大迭代步数门限
k       = 0 ;

while true && k <= maxIter
    
    % 单纯形法求解最优解 x 及最优基 B
    [ x, fval, info ] = SplexSolver02( c, A, b, 'sign', D ) ;
    
    % ===============
    % 停止准则
    % ===============
    if max( abs( x( idx_I ) - round( x( idx_I ) ) ) ) < 1e-9
        break ;
    end

    % ================================
    % Mixed-integer Gomory cuts 产生
    % ================================
    c     = info.c                         % 目标函数向量 c
    Aeq   = info.Aeq                       % 最优单纯形表 A
    beq   = info.beq                       % 最优单纯形 RHS 向量
    idx_B = info.idx_B                     % 基变量索引
    x
    tmp = Aeq*x
    beq

    [ lhs, rhs ] = MIGCuts( x, Aeq, beq, idx_I, idx_B )
    
    % =======================
    % 添加 MIG cut 到模型
    % =======================
    A = [  Aeq ; ...
           lhs ; ] ;
    b = [  beq ; ...
           rhs ; ] ;
    m1 = size( Aeq, 1 ) ;
    n2 = size( rhs, 2 ) ;
    D = [ zeros( m1, 1 ) ; ...
           ones( n2, 1 ) ; ] ;       % 添加 CG cut 为 >= 不等式

    k = k + 1 ;                      % 迭代计数器
    
end

x
fval
k



