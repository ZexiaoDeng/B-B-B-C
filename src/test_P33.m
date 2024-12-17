% ==================================
% disjunctive programming
% Egon Balas
% 2018
% Springer
% P33
% ==================================

clc ;
clear ;
close all ;

path = './bt-1.3' ;
addpath( path ) ;

x  = sdpvar( 2, 1 ) ;
F1 = [ -x(1) - x(2) >= -2 ;
        x(1)        >=  0 ;
               x(2) >=  0 ; 
        x(1)        >=  1 ; ] ;
F2 = [ -x(1) - x(2) >= -2 ;
        x(1)        >=  0 ;
               x(2) >=  0 ; 
               x(2) >=  1 ; ] ;

figure
plot( F1 ) ; 
hold on    ;
plot( F2 ) ;

y   = sdpvar( 2, 1 ) ;
F1__ = [ -x(1) - x(2) >= -2 ;
         x(1) + x(2) >=  1 ;
         x(1)        >=  0 ;
                x(2) >=  0 ; ] ;

figure
plot( F1__ ) ;













