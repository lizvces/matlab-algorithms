function nevilles(varargin)
n = varargin{1};
n=n+1;
n2 = n*2-1;
cord = zeros(1,n2);
A = zeros(n);

for i = 2:nargin-1
    cord(i-1) = varargin{i};
end

x0 = varargin{nargin};

xcord = zeros(1,n);

for i = 1:numel(xcord)
    xcord(i) = cord(i*2-1);
end

ycord = zeros(1,n);

for i=1:numel(ycord)
    ycord(i) = cord(i*2);
end

for i = 1:n
   A(i,i) = ycord(i); 
end

for d=2:n
    for i=1:n-d+1
        j=i+d-1;
        A(i,j) = (((x0-xcord(i))*A(i+1,j))-((x0-xcord(j))*A(i,j-1)))/(xcord(j)-xcord(i)); 
    end
end

fprintf("P(x_0) = " + A(1,n) + "\n");