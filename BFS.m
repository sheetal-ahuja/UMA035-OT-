BFS Code
clc
clear all
A = [2 3 -1 4; 1 -2 6 -7];
C = [2 3 4 7];
B = [8 ;-3];
n = size(A,2);
m = size(A,1);
if n>m
    %number of solutions
    NS = nchoosek(n,m);
    sol = [];
    NC = nchoosek(1:n,m);
    for i=1:NS
       y = zeros(n,1);
       X = A(:, NC(i,:))\B;
      if all(X>=0 & X~=inf & X~=-inf)
          y(NC(i,:))=X;
          sol = [sol y]
       end
    end
else
    print("no of var less than constraints")
end
Z = C*sol
max(Z)
