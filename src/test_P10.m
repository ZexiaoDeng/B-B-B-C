% ==================================
% disjunctive programming
% Egon Balas
% 2018
% Springer
% P10
% ==================================
clc ;
clear ;
close all ;

format long

Aeq  = [ 1, 0,  0.4, 1.3, -0.01, 0.07 ; 
         0, 1, -0.3, 0.4, -0.04,  0.1 ; ] ;
beq = [ 0.2 ; 0.9 ; ] ;

idx_B = 1: 2 ;      % 基变量索引
idx_N = 3: 6 ;      % 非基变量索引

idx_I = 1: 2 ;      % 只有前两个是整数

x = [ 0.5 ; 0 ; ] ;
% [ lhs, rhs ] = MIGCuts( x, Aeq, beq, idx_I, idx_B )
% lhs/rhs

% [ lhs, rhs ] = CGCuts( x, Aeq, beq, idx_I, idx_B ) ;
% lhs/rhs
% 
% x = [ 0 ; 0.5 ; ] ;
% % [ lhs, rhs ] = MIGCuts( x, Aeq, beq, idx_I, idx_B )
% % lhs/rhs
% 
% [ lhs, rhs ] = CGCuts( x, Aeq, beq, idx_I, idx_B ) ;
% lhs/rhs

% 整数部分, 获取分数形式的基变量
[ ~, idxc ] = max( abs( x( idx_I ) - floor( x( idx_I ) ) ) ) ; 
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
        lhs( 1, i ) = ( lhs( 1, i ) - 1 ) ;
    end
end
rhs
lhs

rhs
lhs/( 1 - rhs )





% [ lhs, rhs ] = CGCuts( x, Aeq, beq, idx_I, idx_B )
% lhs/rhs
% 
% 
% x = [ 0 ; 0.5 ; ] ;
% % 整数部分, 获取分数形式的基变量
% [ ~, idxc ] = max( abs( x( idx_I ) - floor( x( idx_I ) ) ) ) ; 
% [ ~, idxr ] = max( Aeq( :, idxc ) ) ;
% 
% bi  = beq( idxr ) ;                      % 最优基形式对应的右手边标量
% aij = Aeq( idxr, idx_N ) ;               % 最优基形式对应的系数矩阵
% 
% % ===============
% % 第 1 种方法
% % 纯 CG cut
% % ===============
% lhs( 1, idx_N ) = aij - floor( aij ) ;
% rhs             = bi  - floor( bi  ) ;
% 
% % ============================
% % 第 2 种方法
% % 第 2 种要比第 1 种约束更强
% % ============================
% for i = idx_N
%     if lhs( 1, i ) > rhs
%         lhs( 1, i ) = ( lhs( 1, i ) - 1 ) ;
%     end
% end
% rhs
% lhs
% 
% [ lhs, rhs ] = CGCuts( x, Aeq, beq, idx_I, idx_B )
% lhs/rhs









