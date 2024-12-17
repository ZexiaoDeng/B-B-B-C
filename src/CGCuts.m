function [ lhs, rhs ] = CGCuts( x, Aeq, beq, idx_i, idx_B )
%   CGCUTS generates a strongly valid inequality 
%          for pure integer programming problem.
%   CGCUTS implements the Chvatal-Gomory cut method ( CG ).
%
%           min     c'*x
%           s.t.    Aeq*x <= beq        ( linear equalities )
%                   x >= 0, 
%                   x( idx_i ) are integer variables
%   the CG cuts in the form :
%                   lhs*x >= rhs
%   Input:
%       x       : the current optimal solution
%       Aeq     : the matrix of linear equalities in optimal basis form
%       beq     : the rhs vector of linear equalities in optimal basis form
%       idx_i   : the integer indices
%       idx_B   : the optimal basis indices
%   
%   Output:
%       lhs     : the left-hand-side vector of the valid CG cuts
%       rhs     : the right-hand-side scalar of the valid CG cuts
%
%   References:
%           [1] http://github.com/dengzx/doc/manual.pdf     ;
%           [2] 最优化理论与算法, 第二版, 陈宝林, 清华大学出版社
%
%   See Also SPLEX_2STG
%
% =========================
% 初始化
% =========================
n     = size( Aeq, 2 ) ;
idx_N = setdiff( 1: n, idx_B ) ;        % 非基变量索引

lhs   = zeros( 1, n ) ;

% 整数部分, 获取分数形式的基变量
[ ~, idxc ] = max( abs( x( idx_i ) - round( x( idx_i ) ) ) ) ; 
[ ~, idxr ] = max( Aeq( :, idxc ) ) ;

bi  = beq( idxr ) ;                      % 最优基形式对应的右手边标量
aij = Aeq( idxr, idx_N ) ;               % 最优基形式对应的系数矩阵

% ===============
% 第 1 种方法
% 纯 CG cut
% ===============
lhs( 1, idx_N ) = aij - floor( aij ) ;
rhs             = bi  - floor( bi  ) ;

% ============================
% 第 2 种方法
% 第 2 种要比第 1 种约束更强
% ============================
for i = idx_N
    if lhs( 1, i ) > rhs
        lhs( 1, i ) = ( 1 - lhs( 1, i ) )*rhs/( 1 - rhs ) ;
    end
end

return ;

end








