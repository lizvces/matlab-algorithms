function nevilles(fileName)

% Here I am opening the file using the given file name and 
%scanning the inputs into array temp.
fileID = fopen(fileName, 'r');
temp = fscanf(fileID, '%f', [1 Inf]); 

%I break up array temp (the inputs) in the perspective parts. n = the first
%element, then cord (the array of ALL coordinates, both x and y) = everything 
%from index 2 to index n+1. x0 is the element after the last coordinate
%point. A is the matrix where the values will be stored. 

n = temp(1);
n=n+1;
n2 = (n*2)+1;
cord = zeros(1,n2);
A = zeros(n);

for i = 2:size(temp,2)-1
    cord(i-1) = temp(i);
end

x0 = temp(size(temp,2));

%In this sectio, I am breaking up my array cord (containing both x and y coordinates)
%into two array that contain exclusively x or exclusively y coordinates.
%xcord contains my x coordinates and ycord my y coordinates.

xcord = zeros(1,n);

for i = 1:numel(xcord)
    xcord(i) = cord(i*2-1);
end
ycord = zeros(1,n);

for i=1:numel(ycord)
    ycord(i) = cord(i*2);
end

%Here I am filling the diagonal values of my matrix A with the initial y
%vales that are stored in my ycord array.

for i = 1:n
   A(i,i) = ycord(i); 
end

%This is the main part of the algorithm where the remaining parts of the
%array are filled in using the equation Pi+1,j(x)(x ? xi) ? Pi,j?1(x)(x ?
%xj)/xj ? xi that was given in the lecture 12 notes.

for d=2:n
    for i=1:n-d+1
        j=i+d-1;
        A(i,j) = (((x0-xcord(i))*A(i+1,j))-((x0-xcord(j))*A(i,j-1)))/(xcord(j)-xcord(i)); 
    end
end

%The element at 1,n of matrix A is the printed out. 

fprintf("P(x_0) = " + A(1,n) + "\n");