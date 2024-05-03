%bigmmethod
clc
clear all
m=1000;
c=[3 -1 0 0 0 -m 0];
a=[2 1 1 1 0 0; 1 3 0 -1 0 1; 0 1 0 0 1 0];
b=[2; 3;4];
a1=[a b];
bv=[3 6 5];
zc=c(bv)*a1-c;
stable=[a1;zc];
array2table(stable,'VariableNames',{'x1','x2','s1','s2','s3','a1','sol'});

run=true
while  run
    if(any(zc(1:end-1)<0))
        [minzc pvt_col_no]=min(zc(1:end-1));
        pvt_col=a1(:,pvt_col_no);
        sol=a1(:,end);
        if all(pvt_col<=0)
            fprintf('unbounded');
        else
            for i=1:size(a1,1)
                if(pvt_col(i)>0)
                    ratio(i)=sol(i)./pvt_col(i);
                else
                    ratio(i)=inf;
                end
            end
            [minratio pvt_row_no]=min(ratio);
        end
        bv(pvt_row_no)=pvt_col_no;
        pvt_key=a1(pvt_row_no,pvt_col_no);
        a1(pvt_row_no,:)=a1(pvt_row_no,:)./pvt_key;
        for i=1:size(a1,1)
            if(i~=pvt_row_no)
                a1(i,:)=a1(i,:)-a1(i,pvt_col_no).*a1(pvt_row_no,:);
            end
        end
        zc=c(bv)*a1-c;
          stable=[a1;zc];
          array2table(stable,'VariableNames',{'x1','x2','s1','s2','s3','a1','sol'});

    else
        run=false;
        fprintf('final optimal solution is %f\n',zc(end))
   
    end
end

for i = 1:length(bv)
    fprintf('Value of x%d is %f\n', bv(i), a1(i, end));
end
