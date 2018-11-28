function horner(fileName)
fileID = fopen(fileName, 'r');
A = fscanf(fileID, '%f', [1 Inf]);
n = A(1);
a = zeros(1,n+1);
for i = 1:n+1
    a(i) = A(i+1);
end
x0 = A(size(A,2));
answer = a(n+1);
dev = a(n+1);
for i = n:-1:1
   answer = (answer * x0) + a(i);
   dev = (dev * x0) + answer;
end

fprintf("ans:%d\n", answer);
fprintf("dev:%d\n", dev);