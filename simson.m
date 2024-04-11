clc
clear all
C=[2 5];
a = [1 4; 3 1; 1 1];
b=[24; 21; 9];
s = eye(size(a,1));
A = [a s b];
cost = zeros(1, size(A,2));
nv = size(a,2);
cost(1:nv) = C;
bv = nv+1:size(A,2)-1;
zjcj = cost(bv)*A-cost;
zcj = [zjcj;A];
simplextable = array2table(zcj)
simplextable.Properties.VariableNames(1:size(zcj,2))={'x1','x2','s1','s2','s3','sol'}

if any(zjcj<0)
    zc = zjcj(1:end-1)
    [enter_val,pvt_col]=min(zc)
    if all(A(:,pvt_col)<=0)
            error('LPP is unbounded all enteries are <=0 in column %d',pvt_col);
        else
            sol=A(:,end)
            column=A(:,pvt_col)
            for i=1:size(A,1)
                if column(i)>0
                    ratio(i)=sol(i)./column(i)
                else
                    ratio(i)=inf
                end 
            end
            [leaving_var, pvt_row]=min(ratio)
    end
end
