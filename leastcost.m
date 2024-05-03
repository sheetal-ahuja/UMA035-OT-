clc
clear all
cost = [2 7 4;3 3 1; 5 5 4;1 6 2];
A=[5 8 7 14]; %supply
B=[7 9 18]; %demand
if sum(A)==sum(B)
    fprintf('balanced')
else
    fprintf('unbalanced')
    if sum(A)<sum(B)
        cost(end+1,:) = zeros(1, size(cost,2))
        A(end+1) = sum(B)-sum(A)
    elseif sum(A)>sum(B)
        cost(:, end+1) = zeros(size(cost,1),1)
        B(end+1) = sum(A)-sum(B)
    end
end

initial_cost = cost;
X = zeros(size(cost))
[m n] = size(cost)
bfs = m+n-1;
for i=1:size(cost,1)
    for j=1:size(cost,2)
        ll = min(cost(:)) %finding min cost val
        [row_idx col_idx] = find(ll==cost)
        x11 = min(A(row_idx), B(col_idx))
        [val idx] = max(x11)    %find max allocation
        ii = row_idx(idx)   %identify row position
        jj = col_idx(idx)   %identify col position
        y11 = min(A(ii), B(jj))  %find the val
        X(ii, jj) = y11
        A(ii) = A(ii)-y11
        B(jj) = B(jj) - y11
        if A(ii)==0
            cost(ii,:)=Inf
        elseif B(jj)==0
            cost(:,jj)=Inf
        %cost(ii, jj) = Inf
        end
    end
end
sum(sum(initial_cost.*X))
