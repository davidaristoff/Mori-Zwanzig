T = zeros(L,L,t); N = length(X);
for n=1:N
    I = X(n); m = min(n+t,N); dT = zeros(L,L,t);
    dT(I,:,1:m-n) = (X(n+1:m) == (1:1:L)'); T = T + dT;
end