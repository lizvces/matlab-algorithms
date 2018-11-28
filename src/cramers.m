
function cramers(fileName)

fileID = fopen(fileName, 'r');
temp = fscanf(fileID, '%f', [1, Inf]);
n = temp(1);
A = zeros(n,n);
index = 2;
for i = 1:n
   for j = 1:n
      A(i,j) = temp(index); 
      index = index+1;
   end
end
b = zeros(n,1);
b(1,1) = 1;
index2 = 1;
for i = index+1:size(temp,2)
    b(index2,1) = temp(i);
    index2 = index2+1;
end


detA = gaussian(A);
fprintf("determinant A: " + detA + "\n");
A_ = A;
answer = zeros(n,1);
for i = 1:n
   if(i ~=1)
    A_(:,i-1) = A(:,i-1);
   end
    A_(:,i) = b;
    gA = gaussian(A_);
    answer(i) = gA/detA;
    fprintf("determinant A" + i + ": " + gA + "\n");
end

for i = 1:size(answer)
    fprintf("x" + i + ": " + answer(i) +"\n");
end

end

function x = gaussian(A)
A = A-eps(1);
n = size(A,1);
rowSwitches = 0;
for i = 1:n-1
    for j = i+1:n
        for k = 1:n
            val1 = A(i,i);
            val2 = A(j,i);
            if  abs(val1) < abs(val2)
             A([i j],:)=A([j i],:);
             rowSwitches = rowSwitches+1;
            end
        end
    end
   A(i+1:n,:) = A(i+1:n,:) - ((A(i+1:n,i)/A(i,i))*A(i,:));
   
end 
answer = 1;

for i = 1:n
    answer = answer * A(i,i);
end
x = answer * (-1).^rowSwitches;
end