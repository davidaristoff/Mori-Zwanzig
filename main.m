%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%main program -- MZ estimation of transition probabilities
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%define MZ inference parameters
tfinal = 1000;     %time horizon for inference
tmax = 100;        %time horizon for sampling
tmem = 70;         %time horizon for memory kernel
tMSM = tmax;       %time lag for MSM
lam = 1;           %ridge regularization parameter
CV = 2;            %collective variable: 1st or 2nd coordinate

%create model system
[T,Tref,X,data,V,L,FPTs] = create_model(tfinal,CV); 

%get MZ kernels
K = get_kernels(T,tmem,tmax,L,lam);

%infer transition matrices
T_MZ = infer_transitions(K,T,tmem,0,tfinal,L);

%compute MSM matrices
T_MSM = get_MSM_matrix(T,tMSM,tfinal);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot results of the MZ inference
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%close figures
close all

%plot transition matrices
plot_transitions(Tref,T_MZ,T_MSM,L,tmax,tfinal,tMSM);

%plot timescales
plot_timescales(T,T_MZ,T_MSM,L,tmem,tMSM,tfinal,FPTs);

%plot memory kernel decay
plot_kernel_decay(K);

%plot data points and potential energy
plot_data(X,data,V,CV,50);   %last argument = lag for plotting

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save Matlab workspace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save MZ_data.mat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%