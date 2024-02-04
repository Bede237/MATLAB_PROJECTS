%This code does Matrix operations on two matrices
while 1
    clc
    clear
    disp('------------Matrix Operations---------------');

    p = 1;
    
    a = input('Enter first Matrix,in the form [A,B;C,D], where A and B are elements of row 1\n');
    b = input('Enter Second Matrix,in the form [A,B;C,D],where A and B are elements of row 1\n');
    
    %this loop allows you to do multiple operations on the matices
    
    while p
        disp('------------Choice of Operation--------------\n');
        n = input('1- Matrix Addition\n2- Matrix Subtractio\n3- Matrix Multiplication\n4- Matrix Division\n5- inverse\n6- Quit\n');
        if n == 1
            c = a + b;
            disp(c);
        elseif n == 2
            c = a - b;
            disp(c);
        elseif n == 3
            c = a * b;
            disp(c);
        elseif n == 4
            c = a / b;
            disp(c);
        elseif n == 5
            c = inv(a);
            d = inv(b);
            disp(c);
            disp(d);
        else
            p = 0;
        end
    end
end