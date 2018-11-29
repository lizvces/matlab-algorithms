
function cramers(fileName)

% Here I am opening the file using the given file name and 
%scanning the inputs into array temp. 
fileID = fopen(fileName, 'r');
temp = fscanf(fileID, '%f', [1, Inf]);

%I break up array temp (the inputs) in the perspective parts. n = the first
%element, then A (the matrix that is nxn) = everything from index 2 to
%index n+1. Vector b is everything that happens after the last element of
%matrixA.

n = temp(1);
A = zeros(n,n);
index = 2;

%Storing everything into matrix A
for i = 1:n
   for j = 1:n
      A(i,j) = temp(index); 
      index = index+1;
   end
end

%storing the remaining things into vector b
b = zeros(n,1);
b(1,1) = 1;
index2 = 1;
for i = index+1:size(temp,2)
    b(index2,1) = temp(i);
    index2 = index2+1;
end

%This is the main part of the algorithm. First I evaluate the determinant
%of the unchanged matrix A in my gaussian function and print out the value.
detA = gaussian(A);
fprintf("determinant A: " + detA + "\n");

%I create a temp array A_ and store A. A_ is the array that will be
%modified. I also initialize the solutions vector.

A_ = A;
answer = zeros(n,1);

%Then, I replace each column i with the vector b. I also make sure to
%change back the previous colum to its original value (only in the case 
%that i does not equal 1)

for i = 1:n
   if(i ~=1)
    A_(:,i-1) = A(:,i-1);
   end
    A_(:,i) = b;
    
    %Here, I calculate the determinant of the modified array by calling the
    %gaussian function. I evaluate the solution for xi and then print out
    %the determinant. 
    gA = gaussian(A_);
    answer(i) = gA/detA;
    fprintf("determinant A" + i + ": " + gA + "\n");
end

%printing out the solution vector. 

for i = 1:size(answer)
    fprintf("x" + i + ": " + answer(i) +"\n");
end

end

%The gaussian function changes the matrix in a upper triangular matrix
%(this algorithm uses partial pivoting)andthen calculates the determinant 
%by multiplying the diagonal value and then multiplying that value by 
%(-1)^how many row switches occurs

function x = gaussian(A)

%Changing the values to floating point values and calculating the size of
%the array. rowSwitches is set to 0 to begin.
A = A-eps(1);
n = size(A,1);
rowSwitches = 0;
for i = 1:n-1
    for j = i+1:n
        for k = 1:n
            %This section checks that the values under the absolute value of the
            %diagonal value is greates than the absolute value of all the
            %values underneath the diagonal value. If it finds a value
            %whose absolute value is greater than the absolute value of the
            %diagonal value, then those two rows are switched and
            %rowSwitches is increased by one. 
            val1 = A(i,i);
            val2 = A(j,i);
            if  abs(val1) < abs(val2)
             A([i j],:)=A([j i],:);
             rowSwitches = rowSwitches+1;
            end
        end
    end
    
    %after the row switches are done, this line computes the rest of the
    %matrix by computing the row operations. 
   A(i+1:n,:) = A(i+1:n,:) - ((A(i+1:n,i)/A(i,i))*A(i,:));
   
end 

%This next part computes the determinant of the matrix by multiplying all
%diagonal values and the multiplying that by (-1)^rowSwitches and that
%answer is the returned.
answer = 1;

for i = 1:n
    answer = answer * A(i,i);
end
x = answer * (-1).^rowSwitches;
end