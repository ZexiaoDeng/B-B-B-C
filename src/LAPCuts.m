function [ alpha, beta ] = LAPCuts( xBar, Aineq, bineq, idx_j )
%   LAPCUTS generates a strongly valid inequality 
%          for mixed-integer programming problem.
%   LAPCUTS implements the lift-and-project cut method ( LAP ).
%
%           min     c'*x
%           s.t.    Aineq*x >= bineq        ( linear inequalities )
%                   x >= 0, 
%                   x( idx_i ) are integer variables
%   the LAP cut in the form :
%                   lhs*x >= rhs
%   Input:
%       xBar    : the current optimal solution
%       Aineq   : the system matrix of linear inequalities
%       bineq   : the rhs vector of linear inequalities
%       idx_j   : the integer index
%       params  : the solver configuration parameters
%   
%   Output:
%       lhs     : the left-hand-side vector of the valid CG cuts
%       rhs     : the right-hand-side scalar of the valid CG cuts
%
%   References:
%           [1] ...     ;
%           [2] Disjunctive programming, Egon Balas, Springer ;
%
%   See Also ...
%

[ m, n ] = size( Aineq ) ;

c = [ xBar         ; ...    % alpha
     -1            ; ...    % beta
     zeros( m, 1 ) ; ...    % u
     0             ; ...    % u0
     zeros( m, 1 ) ; ...    % v
     0             ; ...    % v0
     ] ;

ATilde = Aineq ;
bTilde = bineq ;
ej     = zeros( n, 1 ) ;
ej( idx_j ) = 1 ;

Aeq = [ eye( n )     ,  zeros( n, 1 ), -ATilde'      , ej           ,  zeros( n, m ),  zeros( n, 1 ) ; ...
        eye( n )     ,  zeros( n, 1 ),  zeros( n, m ), zeros( n, 1 ), -ATilde'      , -ej            ; ...
        zeros( 1, n ), -1            ,  bTilde'      , 0            ,  zeros( 1, m ),  0             ; ...
        zeros( 1, n ), -1            ,  zeros( 1, m ), 0            ,  bTilde'      ,  1             ; ...
        zeros( 1, n ),  0            ,  ones( 1, m ) , 1            ,  ones( 1, m ) ,  1             ; ] ;
  
beq = [ zeros( n, 1 ) ; zeros( n, 1 ) ; 0 ; 0 ; 1 ; ] ;

lb = [ -inf*ones( n, 1 ) ; -inf ; zeros( m, 1 ); 0 ; zeros( m, 1 ) ; 0 ; ] ;
ub = [] ;

% ops = optimoptions( 'linprog'  , ...
%                     'Algorithm', 'dual-simplex', ...
%                     'display'  , 'none' ) ;

% ops = optimoptions( 'linprog'  , ...
%                     'Algorithm', 'interior-point', ...
%                     'display'  , 'none' ) ;

ops = optimoptions( 'linprog'  , ...
                    'Algorithm', 'interior-point-legacy', ...
                    'OptimalityTolerance', 1e-13, ...
                    'ConstraintTolerance', 1e-8, ...
                    'display'  , 'none' ) ;
[ x       , ...
  fval    , ...
  exitflag, ...
  output  , ...
  lambda  ] = linprog( c    ,        ...
                       [], [], ...
                       Aeq  , beq  , ...
                       lb   , ub   , ops ) ;
                   
alpha = x( 1: n ) ;
beta  = x( n + 1 ) ;
















