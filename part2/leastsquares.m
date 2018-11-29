function leastsquares(fileName)
fileID = fopen(fileName);
A = fscanf(fileID, '%f', [1, Inf]);
fclose(fileID);

numPoints = A(1);
degree = A(2);
matrix = zeros(degree+1);
matrix = matrix - eps(1);

xcord = zeros(1, numPoints);
ycord = zeros(1, numPoints);

for i=3:numel(A)
   if(mod(i,2)~=0)
       xcord((i-1)/2) = A(i)+eps(1);
   else
       ycord((i/2)-1) = A(i)+eps(1);
   end
end
   
matrix(1,1) = numPoints;

for i = 1:degree+1
    matrix(1,i) = summation(xcord, 1, i);
end

for i = 2:degree+1
    for j = 1:degree+1
         matrix(i,j) = summation(xcord, i, j);
    end  
end

yval = zeros(degree+1,1);
for i = 1:degree+1
    yval(i, 1) = sumy(ycord, xcord, numPoints, i);
end
avals = linsolve(matrix, yval);

for i=1:degree+1
    fprintf('%f ', avals(i,1));
end
fprintf('\n');



p = poly2sym(avals);
display(p);

Y = polyval(avals, xcord);

plot(xcord,Y);

end

function x = summation(xcord, row, col)
    answer = sum(xcord.^(row+col-2));
    x = answer;
end

function c = sumy(ycord, xcord, numPoints, col)

answer = 0;
for i = 1:numPoints
    answer = answer + (ycord(i)*((xcord(i)).^(col-1)));
end
c = answer;
end
