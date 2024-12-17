% % =======================================
% % 最优化理论与方法
% % 第二版
% % 陈宝林 编著
% % 清华大学出版社
% % P450
% % =======================================
% clc ;
% clear ;
% close all ;
% 
% c = [ 1; 2 ; 3 ; 4 ; 5 ; ] ;
% Aineq = [ 2, 3, 5, 4, 7 ; ...
%           1, 1, 4, 2, 2 ; ] ;
% bineq = [ 8 ; 5 ] ;
% Aeq = [] ;
% beq = [] ;
% lb  = zeros( 5, 1 ) ;
% ub  =  ones( 5, 1 ) ;
% 
% intcon = 1: 5 ;
% [ x       , ...
%   fval    , ...
%   exitflag, ...
%   info ] = intlinprog( c', ...
%                       intcon, ...
%                       -Aineq, ...
%                       -bineq, ...
%                        Aeq  , ...
%                        beq  , ...
%                        lb   , ...
%                        ub ) 
% 
% % ==============
% MICDC.n     = 5 ;                       % 整数决策变量个数
% MICDC.p     = 0 ;                       % 连续决策变量个数
% MICDC.vtype = 0 ;                       % 决策变量类型为两个连续变量
% 
% MICDC.lb    = zeros( 5, 1 ) ;        % 决策变量下边界
% MICDC.ub    =  ones( 5, 1 ) ;        % 决策变量上边界
% 
% MICDC.c     = c ;
% MICDC.Aineq = -Aineq ;
% MICDC.bineq = -bineq ;
% MICDC.Aeq   = [] ;
% MICDC.beq   = [] ;
% 
% MICDC.x      = [] ;
% MICDC.fval   = [] ;
% MICDC.output = [] ;
% 
% [ x, fval, output ] = branch_and_cuts( MICDC )
% 
% [ x, fval, output ] = branch_and_bound( MICDC )


% % ================
% % 测试4
% % ================
clc
clear
close all ;
fprintf( 'test 4 =========================================\n' ) ;

MICDC.n     = 10 ;                      % 整数决策变量个数
MICDC.p     = 0 ;                       % 连续决策变量个数
MICDC.vtype = 0 ;                       % 决策变量类型为两个连续变量

MICDC.c     = -[3 9 4 7 5 5 4 3 2 1]' ;
MICDC.Aineq = [ 0.1 0.7 0.6 0.2 0.9 0.5 0.1 0.5 0.7 0.4] ;
MICDC.bineq = 2.5 ;

MICDC.Aineq = [ MICDC.Aineq ; ] ;
MICDC.bineq = [ MICDC.bineq ; ] ;

MICDC.Aeq   = [] ;
MICDC.beq   = [] ;

MICDC.lb    = zeros( 10, 1 ) ;        % 决策变量下边界
MICDC.ub    =  ones( 10, 1 ) ;        % 决策变量上边界

% ==============
% 直接调用求解器
intcon = 1: 10 ;
[ x, fval, exitflag, info ] = intlinprog( MICDC.c, ...
                                          intcon , ...
                                          MICDC.Aineq, ...
                                          MICDC.bineq, ...
                                          MICDC.Aeq  , ...
                                          MICDC.beq  , ...
                                          MICDC.lb   , ...
                                          MICDC.ub )
% ===================
% 分支定界方法
[ x, fval, output ] = branch_and_bound( MICDC ) ;
x
fval
iternum_bab = output.k

% ===================
% 分支切割方法
[ x, fval, output ] = branch_and_cuts( MICDC ) ;
x
fval
iternum_bac = output.k


% % ================
% % 测试5
% % ================
% clear
% fprintf( 'test 5 =========================================\n' ) ;
% 
% MICDC.n     = 5 ;                      % 整数决策变量个数
% MICDC.p     = 0 ;                       % 连续决策变量个数
% MICDC.vtype = 0 ;                       % 决策变量类型为两个连续变量
% 
% MICDC.lb    = zeros( 5, 1 ) ;        % 决策变量下边界
% MICDC.ub    =  ones( 5, 1 ) ;        % 决策变量上边界
% 
% MICDC.c     = [ 1, 3, 4, 6, 7 ]' ;
% MICDC.Aineq = -[ 1, -5,  3, -4, 6 ; 
%                  4,  1, -2,  3, 1 ;
%                 -2,  2,  4, -1, 4 ; ] ;
% MICDC.bineq = -[ 2, 1, 1 ; ]' ;
% MICDC.Aeq   = [] ;
% MICDC.beq   = [] ;
% 
% [ x, fval, output ] = branch_and_bound( MICDC )
% 
% intcon = 1: 5 ;
% [ x, fval, exitflag, info ] = intlinprog( MICDC.c, ...
%                                           intcon , ...
%                                           MICDC.Aineq, ...
%                                           MICDC.bineq, ...
%                                           MICDC.Aeq  , ...
%                                           MICDC.beq  , ...
%                                           MICDC.lb   , ...
%                                           MICDC.ub )
                                      