% ==================================
% disjunctive programming
% Egon Balas
% 2018
% Springer
% P37
% ==================================

clc ;
clear ;
close all ;
format rat

path = './bt-1.3' ;
addpath( path ) ;

F1.M = eye( 2 ) ;
F1.B = [ -1 , 2 ; ] ;
F1.a =    6 ;
F1.l = [ 0 ; 0 ; ] ;
F1.u = [ 1 ; 4 ; ] ;

P     = polyh( F1 ) ;               % 多面体表示形式
CH    = vrep( eval( P ) ) ;         % 多面体 P 的顶点集 V( P )
A     = adj( P )  ;                 % 对应顶点的邻接顶点

figure ;
opt.color = [0.5 0.5 0.5] ;
plot( P, opt ) ;
hold on
% axis equal
grid on ;
fprintf( 'F1:\n' ) ;
for i = 1: size( CH.V', 1 )  
    for j = 1: length( CH.V( :, i ) )
        fprintf( '%8.4f\t', CH.V( j, i ) ) ;    % 顶点
    end
    for k = 1: length( A{i} )
        fprintf( '%8d\t', A{i}(k) ) ;           % 顶点对应的链表
    end
    fprintf( '\n' ) ;
end

F2.M = eye( 2 ) ;
F2.B = [ 4  , 2 ; ] ;
F2.a =   11 ;
F2.l = [ 1   ; 0 ; ] ;
F2.u = [ 2.5 ; 4 ; ] ;

P     = polyh( F2 ) ;               % 多面体表示形式
CH    = vrep( eval( P ) ) ;         % 多面体 P 的顶点集 V( P )
A     = adj( P )  ;                 % 对应顶点的邻接顶点

opt.color = [0.5 0.7 0.5] ;
plot( P, opt ) ;
axis equal
grid on ;
fprintf( 'F2:\n' ) ;
for i = 1: size( CH.V', 1 )  
    for j = 1: length( CH.V( :, i ) )
        fprintf( '%8.4f\t', CH.V( j, i ) ) ;    % 顶点
    end
    for k = 1: length( A{i} )
        fprintf( '%8d\t', A{i}(k) ) ;           % 顶点对应的链表
    end
    fprintf( '\n' ) ;
end

F3.M = eye( 2 ) ;
F3.B = [ -1  , 1 ; ] ;
F3.a =   -2 ;
F3.l = [ 2.5 ; 0 ; ] ;
F3.u = [ 4   ; 4 ; ] ;

P     = polyh( F3 ) ;               % 多面体表示形式
CH    = vrep( eval( P ) ) ;         % 多面体 P 的顶点集 V( P )
A     = adj( P )  ;                 % 对应顶点的邻接顶点

opt.color = [0.5 0.7 0.7] ;
plot( P, opt ) ;
axis equal
grid on ;
fprintf( 'F3:\n' ) ;
for i = 1: size( CH.V', 1 )  
    for j = 1: length( CH.V( :, i ) )
        fprintf( '%8.4f\t', CH.V( j, i ) ) ;    % 顶点
    end
    for k = 1: length( A{i} )
        fprintf( '%8d\t', A{i}(k) ) ;           % 顶点对应的链表
    end
    fprintf( '\n' ) ;
end

F4.M = eye( 2 ) ;
F4.B = [  1 , 1 ; ] ;
F4.a =   6 ;
F4.l = [ 4 ; 0 ; ] ;
F4.u = [ 6 ; 4 ; ] ;

P     = polyh( F4 ) ;               % 多面体表示形式
CH    = vrep( eval( P ) ) ;         % 多面体 P 的顶点集 V( P )
A     = adj( P )  ;                 % 对应顶点的邻接顶点

opt.color = [0.7 0.7 0.4] ;
plot( P, opt ) ;
axis equal
grid on ;
fprintf( 'F4:\n' ) ;
for i = 1: size( CH.V', 1 )  
    for j = 1: length( CH.V( :, i ) )
        fprintf( '%8.4f\t', CH.V( j, i ) ) ;    % 顶点
    end
    for k = 1: length( A{i} )
        fprintf( '%8d\t', A{i}(k) ) ;           % 顶点对应的链表
    end
    fprintf( '\n' ) ;
end

% clear ;
c     =  [ 5 ; 1 ; 0 ; 0 ; 0 ; 0 ] ;
Aineq = -[ 1, 0,  1,  0,  0,  0 ; ...
           0, 1, -2,  0,  0,  0 ; ...
           1, 0,  0, -4,  1,  0 ; ...
           0, 1,  0, -2, -1,  0 ; ...
           1, 0,  0,  0,  0, -1 ; ...
           0, 1,  0,  0,  0, -1 ; ...
           0, 0,  6,  0,  0,  0 ; ...
           0, 0,  0, 11, -2,  0 ; ...
           0, 0,  0,  0,  0,  6 ; ] ;
bineq = -[ 0 ; ...
           0 ; ...
           0 ; ...
           0 ; ...
           0 ; ...
           0 ; ...
           1 ; ...
           1 ; ...
           1 ; ] ;
Aeq   = [] ;
beq   = [] ;
lb    = zeros( 6, 1 ) ;
ub    = [] ;

ops = optimoptions( 'linprog', ...
                    'Algorithm', ...
                    'dual-simplex', ...
                    'display', ...
                    'none' ) ;
[ y1, fval ] = linprog( c  , ...
                       Aineq, bineq, ...
                       Aeq  , beq  , ...
                       lb   , ub   , ops )


c = [ 5 ; 1 ; 0 ; 0 ; 0 ; ] ;

Aineq = -[ 1, 0, -1/3,  1,  0 ; ...
           0, 1, -1/3, -1,  0 ; ...
           1, 0,    0,  0, -1 ; ...
           0, 1,    0,  0, -1 ; ...
           0, 0,    1, -2,  0 ; ...
           0, 0,    0,  0,  6 ; ] ;
bineq = -[ 0 ; ...
           0 ; ...
           0 ; ...
           0 ; ...
           1 ; ...
           1 ; ] ;
      
Aeq   = [] ;
beq   = [] ;
lb    = zeros( 5, 1 ) ;
ub    = [] ;

ops = optimoptions( 'linprog', ...
                    'Algorithm', ...
                    'dual-simplex', ...
                    'display', ...
                    'none' ) ;
[ y2, fval ] = linprog( c  , ...
                       Aineq, bineq, ...
                       Aeq  , beq  , ...
                       lb   , ub   , ops )






