function [ x, fval, output ] = branch_and_cuts( MICDC )
% =========================
% 分支定切算法
% 最优化理论与方法, 陈宝林, 清华大学出版社, P434
% 
% lift-and-project cuts method: LAPCuts

upper_bound =  inf ;
% upper_bound =  20 ;
% lower_bound = -inf ;

% ==================================
% 随意给的根节点
% ==================================
root.model          = MICDC ;

root.solution       = []    ;
root.obj_values     = []    ;
root.output         = []    ;

root.candidate_vars = [ 1: MICDC.n ]' ;

% 候选活跃节点 List
candidate_list(1)   = { root } ;

% 记录使用
LB = [] ;
UB = [] ;
k  = 0  ;

while ( ~isempty( candidate_list ) )
    
    % 选择节点, 深度优先搜索, 后进先出
    [ node, candidate_list ] = node_choice_DFS( candidate_list ) ;
    
    % 求解 LP 松弛问题
    [ node.solution , ...
      node.obj_value, ...
      node.output   ] = MICDCSolver( node.model ) ;
    
    if ( node.output.exitflag <= 0 )
        % 节点的问题是一个不可行问题
        lower_bound = inf ;
        fprintf( 'prune by infeasiblity!\n' ) ;
        continue ;
    end

    if ( node.obj_value >= upper_bound )
        % 节点的下边界大于当前最好解( 全局上边界 ), 剪枝
        fprintf( 'prune by bound!\n' ) ;
        continue ;
    end
    
    
    if ( is_integer( node ) == true )
        % 如果松弛解比当前最好解更优, 且满足整数约束, 则更新当前最好解
        upper_bound = node.obj_value ;
        opt_node    = node ;
        continue ;
    end % fi

    % ==========================
    % 添加有效不等式
    % ==========================
    params.Method = -1 ;
    params.OutputFlag = 0 ;
    [ ~, idx_j ] = max(    abs( node.solution( 1: node.model.n ) ...
                       - floor( node.solution( 1: node.model.n ) ) ) ) ; % 找到 x 最大分量的下标
    tmp_Aineq    = [ -node.model.Aineq ; eye( node.model.n ) ; -eye( node.model.n ) ; ] ;
    tmp_bineq    = [ -node.model.bineq ; node.model.lb       ; -node.model.ub       ; ] ;
    [ lhs, rhs ] = LAP( tmp_Aineq, ...
                        tmp_bineq, ...
                        node.solution , ...
                        idx_j         , ...
                        params        ) ;
                    
%     [ lhs, rhs ] = LAPCuts( node.solution , ...
%                             tmp_Aineq     , ...
%                             tmp_bineq     , ...
%                             idx_j ) ;
                    
    node.model.Aineq = [ node.model.Aineq ; -lhs' ; ] ;
    node.model.bineq = [ node.model.bineq ; -rhs ; ] ;
    
    if node.candidate_vars
        % 分支情况
        left_node  = node ;
        right_node = node ;

        [ branch_index, condidate_child_vars ] = choice_branch( node ) ;

        left_node.candidate_vars  = condidate_child_vars ;
        right_node.candidate_vars = condidate_child_vars ;
        
        % 这样松弛了 box constraints
        left_node.model.ub( branch_index )  = floor( node.solution( branch_index ) ) ;
        right_node.model.lb( branch_index ) = floor( node.solution( branch_index ) ) + 1 ;
        
%         % 第二种方法
%         % 如此添加约束与前面添加的 box constraints 将导致数值问题.
%         tmp_Aineq                    = zeros( 1, size( left_node.model.Aineq, 2 ) ) ;
%         tmp_Aineq( 1, branch_index ) = 1 ;
%         tmp_bineq                    = floor( node.solution( branch_index ) ) ;
%         left_node.model.Aineq        = [ left_node.model.Aineq ; ...
%                                          tmp_Aineq             ; ] ;
%         left_node.model.bineq        = [ left_node.model.bineq ; ...
%                                          tmp_bineq             ; ] ;
%         
%         tmp_Aineq                    = zeros( 1, size( right_node.model.Aineq, 2 ) ) ;
%         tmp_Aineq( 1, branch_index ) = -1 ;
%         tmp_bineq                    = -( ceil( node.solution( branch_index ) ) ) ;
%         right_node.model.Aineq       = [ right_node.model.Aineq ; ...
%                                          tmp_Aineq              ; ] ;
%         right_node.model.bineq       = [ right_node.model.bineq ; ...
%                                          tmp_bineq              ; ] ;

        len = length( candidate_list ) ;
        candidate_list( len + 1 ) = { left_node  } ;
        candidate_list( len + 2 ) = { right_node } ;
        k = k + 1 ;
    end

    % 更新节点下边界
    lower_bound = node.obj_value ;
    
    LB = [ LB ; lower_bound ] ;
    UB = [ UB ; upper_bound ] ;
    
end

LB = [ LB ; lower_bound ] ;
UB = [ UB ; upper_bound ] ;
    
if abs( lower_bound - upper_bound ) <= 1e-7
    fprintf( 'Optimal solution found!\n' ) ;
    output.message = 'Optimal solution found!' ;
end
            
x        = opt_node.solution ;
fval     = upper_bound ;
output   = node.output ;
output.k = k ;

plot( LB, '-^' ), hold on ;
plot( UB, '-s' ) ;



end

function [ node, candidate_list ] = node_choice_DFS( candidate_list )
    % 选择节点策略, 深度优先搜索, 后进先出
    len                   = length( candidate_list ) ;
    node                  = candidate_list{ len } ;
    candidate_list( len ) = []                    ;     % 分析后删除节点
    return ;
end

function flag = is_integer( node )
    % 判断求得的解是否为整数
    flag = true ;
    for idx = 1: node.model.n
        if ( abs( floor( node.solution( idx ) ) - node.solution( idx ) ) ) >= 1e-7
            flag = false ;
        end
    end
    return ;
end

function [ branch_index, condidate_child_vars ] = choice_branch( node )
    % 选择分支的那个量
    condidate_child_vars    = node.candidate_vars     ;
    branch_index            = condidate_child_vars(1) ;
    condidate_child_vars(1) = []                      ;
    return ;
end













