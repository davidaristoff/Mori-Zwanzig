function [T,Tref,X,data,V,L,FPTs] = create_model(t,CV)

%load matlab trajectory file
load MZ_traj X data V L; disp(['data length = ...',num2str(length(data))]);

%choose which part of data to use for training and reference
train = input('test = ... '); ref = input('reference = ... '); 

%define verification and reference data
Xt = data(train,CV)'; Xr = data(ref,CV)';

%get transition matrices
disp('making model!'); T = get_matrix(Xt,L,t); Tref = get_matrix(Xr,L,t);

%get MFPTs and save Matlab workspace
FPTs = get_MFPT(X); save MZ_model.mat;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function T = get_matrix(X,L,t)

%get transition matrices up to lag t
T = zeros(L,L,t); N = length(X);
for n=1:N
    I = X(n); m = min(n+t,N); dT = zeros(L,L,t);
    dT(I,:,1:m-n) = (X(n+1:m) == (1:1:L)'); T = T + dT;
end
T = T./sum(T,2);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function FPTs = get_MFPT(X)

%define characteristic functions of states A and B
charA = @(x) heaviside(2-norm(x-[-7.29 -5.10]));
charB = @(x) heaviside(2-norm(x-[7.29 5.10]));

N = length(X); FPTs = zeros(1,N); last_state = 'n'; time = 0; m = 1;
for n=1:N
    time = time + 1;
    if charA(X(n,:)) == 1
        if last_state == 'B'
            FPTs(m) = time; time = 0; m = m + 1;
        end
        last_state = 'A';
    end
    if charB(X(n,:)) == 1
        if last_state == 'A'
            FPTs(m) = time; time = 0; m = m+1;
        end
        last_state = 'B';
    end
end
FPTs = FPTs(FPTs~=0);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%