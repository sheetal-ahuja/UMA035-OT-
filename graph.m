%Graph
clc
clear all
C = [3 2];
A=[1 2; 1 1; 0 1];
B=[2000; 1500; 600];
p = max(B);
x1 = 0:p;
x21 = (B(1) - A(1,1).*x1)/A(1,2);
x22 = (B(2) - A(2,1).*x1)/A(2,2);
x23 = (B(3) - A(3,1).*x1)/A(3,2);
x21 = max(0,x21);
x22 = max(0,x22);
x23 = max(0,x23);
% plotting the graph
plot(x1,x21,'red',x1, x22, 'green', x1, x23, 'blue');
grid on  
%corner points
cxpos1 = find(x21==0);
cypos1 = find(x1==0);
line1 = [x1([cxpos1 cypos1]);x21( [cxpos1 cypos1])]';

cxpos2 = find(x22==0);
line2 = [x1([cxpos2 cypos1]);x22( [cxpos2 cypos1])]';

cxpos3 = find(x23==0);
line3 = [x1([cxpos3 cypos1]);x23( [cxpos3 cypos1])]';

coraxes = [line1; line2; line3];
cor_axes = unique(coraxes, 'rows')

%Intersecting points
GM = [0;0]
for i=1:size(A,1)
    l1=A(i,:);
        b1=B(i);
    for j=i+1:size(A,1)
        l2=A(j,:);
        b2=B(j);
        Aa=[l1;l2];
        Bb=[b1;b2];
        X=Aa\Bb
        GM=[GM X]
    end    
end
GM = GM'
%feasible points
points=[cor_axes;GM]
X1 = points(:,1)
X2 = points(:,2)

for i=1:size(points,1)
    const1(i) = A(1,1)*X1(i)+A(1,2)*X2(i)-B(1);
    const2(i) = A(2,1)*X1(i)+A(2,2)*X2(i)-B(2);
    const3(i) = A(3,1)*X1(i)+A(3,2)*X2(i)-B(3);

    s1 = find(const1>0)
    s2 = find(const2>0)
    s3 = find(const3>0)
    S=unique([s1 s2 s3])

end
points(S,:)=[]
for i = 1:size(points,1)
    obj(i) = sum(points(i,:).*C);
    
end

[opt_val idx] = max(obj)
pt=points(idx,:)
