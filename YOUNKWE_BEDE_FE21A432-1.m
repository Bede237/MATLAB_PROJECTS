%Calculates the parameters of transmmission line

clc;
clear;

fprintf(' ------------ Transmission line Characteristics---------------\n');

freq = input('Enter frequency\n');
l = input('Enter value of line distance\n');
z = input('Enter tranmission line impedance\n');
y = input('Enter value of admittance\n');
Pr = input('Enter11 receiving end power\n');
VR = input ('Enter receiving end voltage\n');
PF = input ('Enter power factor\n');
z = z / l;
y = y / l;

disp('-----------------Different code functions----------------')
rep = input('1- Evaluating line parameters\n2- Evaluating sending end voltage and current\n3- graph plot\n');
if rep == 1
     fprintf('--------------choose Parameter type for model-------------\n');
    n = input('1- short line\n2- nominal pi\n3- nominal T\n4- long line\n');
    
    [A, B, C, D] = charac(z, y, l, n);
    disp('A = '); disp(A);
    disp('B ='); disp(B);
    disp('C = '); disp(C);
    disp('D = '); disp(D);
elseif rep == 2
     fprintf('--------------choose type of model-------------\n');
    n = input('1- short line\n2- nominal pi\n3- nominal T\n4- long line\n');
    
    [A, B, C, D] = charac(z, y, l, n);
    [Vs, Is, PWs, spf] = load(VR, PF, Pr, A, B, C, D);
    disp('Sending End voltage: Vs = '); disp(Vs);
    disp('Sending End Current: Is ='); disp(Is);
    disp('Sending End Power: PWs = '); disp(PWs);
    disp('Sending End Power factor: PF = '); disp(spf)
else
    k = 1;
    Vs = zeros(1, 61);
    Is = zeros(1, 61);
    PWs = zeros(1, 61);
    point = zeros(1, 61);
    spf = zeros(1, 61);
    
     fprintf('--------------choose  Model Graph-------------\n');
    n = input('1- short line\n2- nominal pi\n3- nominal T\n4- long line\n');
       
    for l = 10:10:600
    
        [A,B,C,D] = charac(z, y, l, n);
        [Vs(k), Is(k), PWs(k), spf(k)] = load(VR, PF, Pr, A, B, C, D);
        point(k) = l;
        k = k + 1;
    end
     figure(1);
     plot(point, abs(Vs), 'r');
     
     figure(2);
     plot(point, abs(Is), 'b');
     
     figure(3);
     plot(point, abs(PWs)), 'g';
end


%this function is incharge of  computing line parameters

function [A, B, C, D] = charac(z, y, l, n)
   
    if n == 1
        A = 1; B = z*l; C = 0; D = 1;
    elseif n == 2
        A = (1 + ((y *l) * (z * l)/2)); B = z * l;
        C = (1 + ((y *l) * (z * l))/4) * (y * l); D = (1 + (((y * l) * (z * l))/2));
    elseif n == 3
        A = (1 + (((y * l) * (z * l))/2)); B = (Z * l) * (1 + ((y * l) * (z * l))/4);
        C = y * l; D = (1 + (((y * l) * (z * l))/2));
    else
        x = (l*z) * (l*y);
        w = sqrt(x);
        Zc = (l*z) / (l*w);
        
        A = cosh(w * l); B = Zc * sinh(w * l);
        C = (1 / Zc) * sinh(w * l); D = A;
    end
end

%this function is incharge of computing the line characteristics 
function [Vs, Is, PWs, spf] = load(VR, PF, Pr, A, B, C, D)
    
    Prr = Pr / 3;
    VRp = VR / sqrt(3);
    IRA = -1 * acos(PF);
    IR =( Prr / (VRp * PF)) * (cos(IRA) + sin(IRA) * i);
    
    Vs = (A * VRp) + (B * IR);
    Is = (C * VRp) + (D * IR);
    spf = cos(angle(Vs) - angle(Is));
    PWs = 3 * abs(Vs) * abs(Is) * spf;
end
