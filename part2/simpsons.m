function simpsons(fileName)

fileID = fopen(fileName);
A = textscan(fileID, '%s');
fclose(fileID);


f = inline(A{1}{1});
a = str2num(A{1}{2});
b = str2num(A{1}{3});
h = (b-a)/str2num(A{1}{4});
approx = 0;

for i = a:h:b
    if(i == a)
        approx = feval(f, i);
    elseif i == b
        approx = approx + feval(f,i);
    else
        if(mod(i,2)==0)
            approx = approx + (4*feval(f,i));
        else
            approx = approx + (2*feval(f,i));
        end
    end
end

approx = (h/3)*approx;
display(approx);
end
