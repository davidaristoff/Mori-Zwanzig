function K = get_kernels(T,tmem,tmax,L,lam)

disp('computing memory kernel from linear solve...')

%construct correlation matrices
A = zeros(L,L,tmem,tmem); B = zeros(L,L,tmem);
for s=1:tmem
    for t=1:tmem
        for r=max(s,t)+1:tmax
            A(:,:,s,t) = A(:,:,s,t) + T(:,:,r-s)*T(:,:,r-t)';
        end
        %handle cases where r is equal to s or t
        if s > t
            A(:,:,s,t) = A(:,:,s,t) + T(:,:,s-t)';
        elseif s < t
                A(:,:,s,t) = A(:,:,s,t) + T(:,:,t-s);
        else
            A(:,:,s,t) = A(:,:,s,t) + eye(L);
        end
    end
    for r=s+1:tmax
        B(:,:,s) = B(:,:,s) + T(:,:,r-s)*T(:,:,r)';
    end
    %handle case where r = s
    B(:,:,s) = B(:,:,s) + T(:,:,s)';
end

%construct linear system
A_ = zeros(L*tmem,L*tmem); B_ = zeros(L*tmem,L);
for s=1:tmem
    for t=1:tmem
        A_(L*(s-1)+1:L*s,L*(t-1)+1:L*t) = A(:,:,s,t);
    end
    B_(L*(s-1)+1:L*s,:) = B(:,:,s); 
end

%solve linear system
K_ = (A_+lam*eye(L*tmem))\B_; K = reshape(K_',L,L,tmem);