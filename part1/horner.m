function horner(fileName)

% Here I am opening the file using the given file name and 
%scanning the inputs into array A. 

fileID = fopen(fileName, 'r');
A = fscanf(fileID, '%f', [1 Inf]);

%I break up array A (the inputs) in the perspective parts. n = the first
%element, then a (the array of coefficients) = everything from index 2 to
%index n+1. x0 is the last element of the array.
n = A(1);
a = zeros(1,n+1);

for i = 1:n+1
    a(i) = A(i+1);
end

x0 = A(size(A,2));

%I initialize my answer and derivatives (based on the algorithm in the lecture 5 notes)

answer = a(n+1);
dev = a(n+1);

%This is the main part of the algorithm, where you iterate from a(n) all
%the way down to a(1) and do the computations to evaluate the alpha abd
%beta

for i = n:-1:1
   answer = (answer * x0) + a(i);
   dev = (dev * x0) + answer;
end

fprintf("ans:%d\n", answer);
fprintf("dev:%d\n", dev);