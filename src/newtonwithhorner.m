function newtonwithhorner(fileName)
fileID = fopen(fileName, 'r');
A = fscanf(fileID, '%f', [1, Inf]);
fclose(fileID);
n = A(1);
a = zeros(1,n+1);
for i = 1:n+1
    a(i) = A(i+1);
end
x0 = A(n+3);
epsilon = A(n+4);
num = A(n+5);
err = epsilon+1;
i = 0;
while(i<num ||epsilon<err)
    answer = horners(n, a, x0);
    x1 = x0 - (answer(1)/answer(2));
    i=i+1;
    err = abs(x1-x0);
    x0 = x1;
end
if i <= num
    fprintf('Root: %f\n', x1);
else 
    fprintf('No solution found\n');
end

end

function x = horners(n, a, x0)

answer = a(n+1);
dev = a(n+1);
for i = n:-1:1
   answer = (answer * x0) + a(i);
   dev = (dev * x0) + answer;
end

x = [answer, dev];
end