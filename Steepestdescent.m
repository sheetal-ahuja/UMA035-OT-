clc
clear all
format short
syms x1 x2
f = x1-x2+2*x1*x1+2*x1*x2+x2*x2;
fx=inline(f);
x0=[1 1];
fxx=@(x)fx(x(1),x(2));
g=gradient(f);
gx=inline(g);
gxx=@(x)gx(x(1),x(2));
h=hessian(f);
hx=inline(h);
tol=1e-3;
max_iteration=50;
iter=0;
while(norm(gxx(x0))>tol && iter<max_iteration)
    s=-gxx(x0);
    lambda=(s'*s)/(s'*hx(x0)*s);
    xnew=x0+(lambda*s');
    x0=xnew;
    iter=iter+1;
end
iter
lambda
x0
