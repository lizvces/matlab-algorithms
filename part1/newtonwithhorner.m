function newtonwithhorner(fileName)

% Here I am opening the file using the given file name and 
%scanning the inputs into array A. The file is no longer needed at this
%point so it is closed.

fileID = fopen(fileName, 'r');
A = fscanf(fileID, '%f', [1, Inf]);
fclose(fileID);

%I break up array A (the inputs) in the perspective parts. n = the first
%element, then a (the array of coefficients) = everything from index 2 to
%index n+1. x0 is the element that comes after the last coeffient. Then,
%epsilon is is the element after that and num (N in the algorithm) is the
%final element;

n = A(1);
a = zeros(1,n+1);

for i = 1:n+1
    a(i) = A(i+1);
end

x0 = A(n+3);
epsilon = A(n+4);
num = A(n+5);

%Here, I initialize err to equal 1 more than epsilon so that is can pass
%through the first iteration of the while loop. Once, in the while loop, it
%will be properly computed. 

err = epsilon+1;

%This is the main part of the algorithm. i is initialized to be zero. I
%the evaluate f(x) and f'(x) in the seperate horner's function (same
%function from the other file). This function returns f(x) and f'(x) in an
%array where arr(1) = f(x) and arr(2) = f'(x). These values along with x0
%are then used to evaluate x1, i is incremented, err is evaluated based on
%the vales and x0 is set to x1.
i = 0;
while(i<num ||epsilon<err)
    answer = horners(n, a, x0);
    x1 = x0 - (answer(1)/answer(2));
    i=i+1;
    err = abs(x1-x0);
    x0 = x1;
end

%This is the final check to makes sure that the root was found within the
%bounds of N. If this is not the case, then No root is found is printed
%out. 
if i <= num
    fprintf('Root: %f\n', x1);
else 
    fprintf('No solution found\n');
end

end


%This is the function that evaluates f(x) and f'(x) based on the algorithm
%in lecture 5 notes. The same thing occurs as in horners.m except that
%nothing is display (instead in returns [f(x),f'(x)]) and there is no need
%to break things up since it has been broken up in the previous function.
function x = horners(n, a, x0)

answer = a(n+1);
dev = a(n+1);
for i = n:-1:1
   answer = (answer * x0) + a(i);
   dev = (dev * x0) + answer;
end

x = [answer, dev];
end