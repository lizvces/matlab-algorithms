function x = newtonwithhomer(n, a, x0)
%%a is a matrix. In order to send the correct number of inputs
%%intp firsthorner, we should take the size of the array and subtract 
%%one to it and that should give us the degree of the polynomial 
answerArr = horner(n, a, x0);
i = 0;
while i<10
i++;
end



function c = horner(n, a, x0)
answer = a(n+1);
dev = a(n+1);
for i = n:-1:1
   answer = (answer * x0) + a(i);
   dev = (dev * x0) + answer;
end
A = [answer, dev];
c = A;