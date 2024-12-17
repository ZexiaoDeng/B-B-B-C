function [ lhs, rhs ] = MIGCuts( x, Aeq, beq, idx_I, idx_B )
%   MIGCUTS generates a strongly valid inequality 
%          for mixed-integer programming problem.
%   MIGCUTS implements the mixed-integer Gomory cut method ( MIG ).
%
%           min     c'*x
%           s.t.    Aeq*x <= beq        ( linear equalities )
%                   x >= 0, 
%                   x( idx_i ) are integer variables
%   the MIG cuts in the form :
%                   lhs*x >= rhs
%   Input:
%       x       : the current optimal solution
%       Aeq     : the matrix of linear equalities in optimal basis form
%       beq     : the rhs vector of linear equalities in optimal basis form
%       idx_I   : the integer indices
%       idx_B   : the optimal basis indices
%   
%   Output:
%       lhs     : the left-hand-side vector of the valid CG cuts
%       rhs     : the right-hand-side scalar of the valid CG cuts
%
%   References:
%           [1] http://github.com/dengzx/doc/manual.pdf     ;
%           [2] 最优化理论与算法, 第二版, 陈宝林, 清华大学出版社
%           [3] 整数规划:基础, 扩展及应用, 殷允强, 王杜娟, 余玉刚, 科学出版社
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
[ ~, idxc ] = max( abs( x( idx_I ) - round( x( idx_I ) ) ) ) ; 
[ ~, idxr ] = max( Aeq( :, idxc ) ) ;

bi  = beq( idxr ) ;                      % 最优基形式对应的右手边标量

rhs = bi - floor( bi ) ;

for i = idx_N
    aij = Aeq( idxr, i ) ;          % 最优基形式对应的系数矩阵
    if i <= idx_I( end )            % 判断 x 是否位于整数集内
        lhs( 1, i ) = aij - floor( aij ) ;
        if lhs( 1, i ) > rhs
            lhs( 1, i ) = rhs*( 1 - lhs( 1, i ) )/( 1 - rhs ) ;
        end
    else                            % 非整数部分
        if aij < 0
            lhs( 1, i ) = -rhs*aij/( 1 - rhs ) ;
        else
            lhs( 1, i ) = aij ;
        end
    end
end

return ;

end






