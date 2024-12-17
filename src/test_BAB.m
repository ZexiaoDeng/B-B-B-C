% ===================================
% 子程序 brand_and_bound.m 测试文件
% 
% ===================================




% clc ;
% clear ;
% close all ;
% % ================
% % 测试 1
% % ================
% fprintf( 'test 1 =========================================\n' ) ;
% 
% MICDC.n     = 2 ;                       % 整数决策变量个数
% MICDC.p     = 0 ;                       % 连续决策变量个数
% MICDC.vtype = 0 ;                       % 决策变量类型为两个连续变量
% 
% MICDC.lb    =    zeros( 2, 1 ) ;        % 决策变量下边界
% MICDC.ub    = inf*ones( 2, 1 ) ;        % 决策变量上边界
% 
% MICDC.c     = [ 100 ; ...
%                 150 ; ] ;
% MICDC.Aineq = [ 2, 1 ; ...
%                 3, 6 ; ] ;
% MICDC.bineq = [ 10 ; ...
%                 40 ; ] ;
% MICDC.Aeq   = [] ;
% MICDC.beq   = [] ;
% 
% MICDC.x      = [] ;
% MICDC.fval   = [] ;
% MICDC.output = [] ;
% 
% [ x, fval, output ] = branch_and_bound( MICDC )
% 
% intcon = 1:2;
% [ x, fval, exitflag, info ] = intlinprog( MICDC.c, ...
%                                           intcon , ...
%                                           MICDC.Aineq, ...
%                                           MICDC.bineq, ...
%                                           MICDC.Aeq  , ...
%                                           MICDC.beq  , ...
%                                           MICDC.lb   , ...
%                                           MICDC.ub ) 
% 
% % ================
% % 测试2
% % ================
% fprintf( 'test 2 =========================================\n' ) ;
% clear ;
% 
% MICDC.n     = 2 ;                       % 整数决策变量个数
% MICDC.p     = 0 ;                       % 连续决策变量个数
% MICDC.vtype = 0 ;                       % 决策变量类型为两个连续变量
% 
% MICDC.lb    =    zeros( 2, 1 ) ;        % 决策变量下边界
% MICDC.ub    = inf*ones( 2, 1 ) ;        % 决策变量上边界
% 
% MICDC.c     = [ -7 ; ...
%                 -9 ; ] ;
% MICDC.Aineq = [ 1, 3 ; ...
%                 7, 1 ; ] ;
% MICDC.bineq = [ 6  ; ...
%                 35 ; ] ;
% MICDC.Aeq   = [] ;
% MICDC.beq   = [] ;
% 
% MICDC.x      = [] ;
% MICDC.fval   = [] ;
% MICDC.output = [] ;
% 
% [ x, fval, output ] = branch_and_bound( MICDC )
% 
% intcon = 1:2;
% [ x, fval, exitflag, info ] = intlinprog( MICDC.c, ...
%                                           intcon , ...
%                                           MICDC.Aineq, ...
%                                           MICDC.bineq, ...
%                                           MICDC.Aeq  , ...
%                                           MICDC.beq  , ...
%                                           MICDC.lb   , ...
%                                           MICDC.ub ) 
% 
% % ================
% % 测试3
% % ================
% clear 
% close all
% fprintf( 'test 3 =========================================\n' ) ;
% 
% MICDC.n     = 10 ;                      % 整数决策变量个数
% MICDC.p     = 0 ;                       % 连续决策变量个数
% MICDC.vtype = 0 ;                       % 决策变量类型为两个连续变量
% 
% MICDC.lb    = zeros( 10, 1 ) ;        % 决策变量下边界
% MICDC.ub    = 3*ones( 10, 1 ) ;        % 决策变量上边界
% 
% MICDC.c     = -[ 1 ; ... 
%                 1 ; ...
%                 2 ; ...
%                 0 ; ...
%                 0 ; ...
%                 0 ; ...
%                 0 ; ...
%                 0 ; ...
%                 2 ; ...
%                 1 ; ] ;
% MICDC.Aineq = [ 1, 2, 3, 5, 3, 0, 0, 0, 0, 0 ; ...
%                 0, 0, 0, 2, 2, 3, 5, 3, 0, 0 ; ...
%                 0, 0, 0, 0, 0, 0, 0, 1, 1, 3 ; ...
%                 2, 0, 1, 0, 0, 0, 0, 3, 3, 2 ; ...
%                 0, 0, 0, 0, 0, 0, 0, -1, -1, -3 ; ...
%                 0, 0, 0, 0, -2, -2, -1, -5, -3, 0 ; ] ;
% MICDC.bineq = [ 8  ; ...
%                 10 ; ...
%                 4  ; ...
%                 8  ; ...
%                 1  ; ...
%                 4  ; ] ;
% MICDC.Aeq   = [] ;
% MICDC.beq   = [] ;
% 
% MICDC.x      = [] ;
% MICDC.fval   = [] ;
% MICDC.output = [] ;
% 
% [ x, fval, output ] = branch_and_bound( MICDC )
% 
% intcon = 1: 10 ;
% [ x, fval, exitflag, info ] = intlinprog( MICDC.c, ...
%                                           intcon , ...
%                                           MICDC.Aineq, ...
%                                           MICDC.bineq, ...
%                                           MICDC.Aeq  , ...
%                                           MICDC.beq  , ...
%                                           MICDC.lb   , ...
%                                           MICDC.ub )

% % ================
% % 测试4
% % ================
% clear
% fprintf( 'test 4 =========================================\n' ) ;
% 
% MICDC.n     = 2 ;                      % 整数决策变量个数
% MICDC.p     = 0 ;                       % 连续决策变量个数
% MICDC.vtype = 0 ;                       % 决策变量类型为两个连续变量
% 
% MICDC.lb    = zeros( 2, 1 ) ;        % 决策变量下边界
% MICDC.ub    = inf*ones( 2, 1 ) ;        % 决策变量上边界
% 
% MICDC.c     = [ 2 ; -1 ; ] ;
% MICDC.Aineq = [ 5, 4 ; -3, 1 ; ] ;
% MICDC.bineq = [ 20 ; 3 ; ] ;
% MICDC.Aeq   = [] ;
% MICDC.beq   = [] ;
% 
% MICDC.x      = [] ;
% MICDC.fval   = [] ;
% MICDC.output = [] ;
% 
% [ x, fval, output ] = branch_and_bound( MICDC )
% 
% intcon = 1: 2 ;
% [ x, fval, exitflag, info ] = intlinprog( MICDC.c, ...
%                                           intcon , ...
%                                           MICDC.Aineq, ...
%                                           MICDC.bineq, ...
%                                           MICDC.Aeq  , ...
%                                           MICDC.beq  , ...
%                                           MICDC.lb   , ...
%                                           MICDC.ub )
% 
% % ================
% % 测试4
% % ================
% clear
% fprintf( 'test 4 =========================================\n' ) ;
% 
% MICDC.n     = 10 ;                      % 整数决策变量个数
% MICDC.p     = 0 ;                       % 连续决策变量个数
% MICDC.vtype = 0 ;                       % 决策变量类型为两个连续变量
% 
% MICDC.lb    = zeros( 10, 1 ) ;        % 决策变量下边界
% MICDC.ub    =  ones( 10, 1 ) ;        % 决策变量上边界
% 
% MICDC.c     = -[3 9 4 7 5 5 4 3 2 1]' ;
% MICDC.Aineq = [ 0.1 0.7 0.6 0.2 0.9 0.5 0.1 0.5 0.7 0.4] ;
% MICDC.bineq = 2.5 ;
% MICDC.Aeq   = [] ;
% MICDC.beq   = [] ;
% 
% [ x, fval, output ] = branch_and_bound( MICDC )
% iternum = output.k
% 
% intcon = 1: 10 ;
% [ x, fval, exitflag, info ] = intlinprog( MICDC.c, ...
%                                           intcon , ...
%                                           MICDC.Aineq, ...
%                                           MICDC.bineq, ...
%                                           MICDC.Aeq  , ...
%                                           MICDC.beq  , ...
%                                           MICDC.lb   , ...
%                                           MICDC.ub )
                                      
                               
% ================
% 测试5
% ================
clear
fprintf( 'test 5 =========================================\n' ) ;

MICDC.n     = 5 ;                      % 整数决策变量个数
MICDC.p     = 0 ;                       % 连续决策变量个数
MICDC.vtype = 0 ;                       % 决策变量类型为两个连续变量

MICDC.lb    = zeros( 5, 1 ) ;        % 决策变量下边界
MICDC.ub    =  ones( 5, 1 ) ;        % 决策变量上边界

MICDC.c     = [ 1, 3, 4, 6, 7 ]' ;
MICDC.Aineq = -[ 1, -5,  3, -4, 6 ; 
                 4,  1, -2,  3, 1 ;
                -2,  2,  4, -1, 4 ; ] ;
MICDC.bineq = -[ 2, 1, 1 ; ]' ;
MICDC.Aeq   = [] ;
MICDC.beq   = [] ;

[ x, fval, output ] = branch_and_bound( MICDC )

intcon = 1: 5 ;
[ x, fval, exitflag, info ] = intlinprog( MICDC.c, ...
                                          intcon , ...
                                          MICDC.Aineq, ...
                                          MICDC.bineq, ...
                                          MICDC.Aeq  , ...
                                          MICDC.beq  , ...
                                          MICDC.lb   , ...
                                          MICDC.ub )
                                      
                                      