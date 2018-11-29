function cubicsplines(fileName)

fileID = fopen(fileName, 'r');
A = fscanf(fileID, '%f', [1, Inf]);
fclose(fileID);

numPoints = A(1);
xcord = zeros(1, numPoints);
ycord = zeros(1, numPoints);
for i=2:numel(A)
   if(mod(i,2)==0)
       xcord(i/2) = A(i)+eps(1);
   else
       ycord((i-1)/2) = A(i)+eps(1);
   end
end

answers = zeros(numPoints-1,4);
array = zeros(numPoints);

%calculate h's

hval = zeros(1,numPoints-1);
bvector = zeros(numPoints,1);


for i = 1:numel(hval)
    if i == numel(xcord)
        break;
    end
    hval(i) = xcord(i+1) - xcord(i); 
end    


for i = 2:numPoints-1
    %index out of bounds error here
    temp1 = ((3/hval(i-1))*(ycord(i+1)-ycord(i)));
    temp2 = ((3/hval(i-1))*(ycord(i)-ycord(i-1)));
    bvector(i,1) = (temp1 - temp2);
end

%first, you have to calculate what c is

%TODO: come back and fix this because it will give you errors
%IMPORTANT TO COME BACK AND DEAL WITH THIS
for i = 1:numPoints-1
    if(i == 1)
        array(i, i) = 1;
    elseif (i == numPoints-1)
        array(i,i) = 2*(hval(i)+hval(numPoints-1));
        array(i,i-1) = hval(i);
        array(i,i+1) = hval(i);
        array(numPoints, numPoints) = 1;
    else    
        array(i,i) = (2*(hval(i) + hval(i+1)));
        array(i,i-1) = hval(i);
        array(i,i+1) = hval(i+1);
    end
    
end

cval = linsolve(array, bvector);
bval = zeros(numPoints, 1);

for i = 1:numPoints-1
    temp = ((ycord(i+1) - ycord(i))/hval(i)) - ((2*cval(i,1) + cval(i+1,1))/3)*hval(i);
    if (temp == 0)
        bvector(i,1) = 0;
    else
        bval(i,1) = temp;
    end
    
end

dval = zeros(numPoints, 1);

for i = 1:numPoints-1
    dval(i,1) = (1/3*hval(i))*(cval(i+1)-cval(i));
end

for i =1:numPoints-1
    fprintf("%f %f %f %f\n", ycord(i), bval(i,1), cval(i,1), dval(i,1));
end

for k=1:numPoints-1
   fun=@(x) ycord(k)+(bval(k)*(x-xcord(k)))+(cval(k)*(x-xcord(k)).^2)+(dval(k)*(x-xcord(k)).^3);
   fplot(fun,[xcord(k),xcord(k+1)]);
   hold on
end

end