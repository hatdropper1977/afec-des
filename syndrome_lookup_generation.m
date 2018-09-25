P = [1 1 1; 1 1 0; 1 0 1; 0 1 1];
G = [P eye(4)];
H = [eye(3) P'];
 
out = dec2bin(0:127);
e   = [];
S   = [];
for r = 1:128
    for c = 1:7
        e(r,c) = str2num(out(r,c));
    end
end
for r = 1:128
    S(r) = mod(e(r,:)*H',2)*[4 2 1]';
end
