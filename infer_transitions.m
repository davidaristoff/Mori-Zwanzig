function T_MZ = infer_transitions(K,T,tmem,tmax,tfinal,L)

disp('inferring transition matrices from memory kernel...')

%set initial transition matrices to be those computed from data
T_MZ = zeros(L,L,tfinal); T_MZ(:,:,1:tmax) = T(:,:,1:tmax);

%start transition matrix inference
for t = tmax+1:tfinal
    if tmem > t-1
        T_MZ(:,:,t) = K(:,:,t);
    end
    for s=1:min(t-1,tmem)
        T_MZ(:,:,t) = T_MZ(:,:,t) + K(:,:,s)*T_MZ(:,:,t-s);
    end
end
T_MZ = max(T_MZ,0); T_MZ = T_MZ./sum(T_MZ,2);