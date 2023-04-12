function T_MSM = get_MSM_matrix(T,tMSM,tfinal)

disp('getting MSM matrix...')

%getting MSM matrix
T_MSM = zeros(4,4,tfinal); T_MSM(:,:,1) = T(:,:,tMSM);
for t=1:(tfinal-1)/tMSM
    T_MSM(:,:,t*tMSM+1) = T_MSM(:,:,(t-1)*tMSM+1)*T(:,:,tMSM);
end