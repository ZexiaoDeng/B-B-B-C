

clc ;
clear ;
close all ;

path = './bt-1.3' ;
addpath( path ) ;

c = [ -1 ;
      -1 ;] ;
n = 2 ;
x = sdpvar( n, 1 ) ;
K = [  -4*x(1) + 12*x(2) >=  -1 ;
      -12*x(1) -  4*x(2) >= -13 ;
          x >= 0 ;
          x <= 1 ; ] ;
f = c'*x ;

plot( K ) ; 
hold on   ;

V = [ 0   , 0    ; 
      0   , 1    ; 
      0.25, 0    ; 
      0.75, 1    ; 
      1   , 0.25 ; ]; % each row is a vertex
  

ops = sdpsettings( 'solver' , 'gurobi', ...
                   'verbose', 0       ) ;
params.Method = -1 ;
params.OutputFlag = 0 ;

obj = export( K ) ;         % 获得约束
optimize( K, f, ops ) ;     % 优化问题
x0 = double(x) ;            % 获得最优解
plot( x0(1), x0(2), 'x', 'LineWidth', 3 ) ; % 标出最优解位置

if norm( x0 - floor( x0 ) ) == 0    % check optimality
    fprintf( '* Optimized! the optimal solution is:\n' ) ;
    disp( x0') ; 
    return ;
end

[ ~, idx_j ] = max( abs( x0 - floor( x0 ) ) ) ; % 找到 x 最大分量的下标
[ lhs, rhs ] = LAP( -obj.A  , ...
                    -obj.rhs, ...
                    x0      , ...
                    idx_j   , ...
                    params   )
lhs/rhs           
[ alpha, beta ] = LAPCuts( x0      , ...
                           -obj.A  , ...
                           -obj.rhs, ...
                            idx_j ) 
alpha/beta
K = K + [ lhs'*x >= rhs ] ;
plot( K )








