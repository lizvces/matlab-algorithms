function x = gaussian(A)
%%A is the augmented matrix (solutions attached)
[n, ~] = size(A);
sol = zeros(n+1,1);
for i = 1:n-1
   A(i+1:n,:) = A(i+1:n,:) - (A(i+1:n,i)/A(i,i))*A(i,:);
end

sol(n) = (A(n, n+1)/A(n,n));

for i = n-1:-1:1
    sol(i) = (A(i, n+1) - computeSum(A, sol, i))/A(i,i);
end
display(A);
x = sol;

function c = computeSum(A, sol, i)
n = size(A,1) - 1;
sum = A(n, i);

for j = i+1:n
   sum = sum + (A(i,j)*sol(j));
end

c = sum;