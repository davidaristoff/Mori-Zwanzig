function plot_kernel_decay(K)

disp('plotting kernel decay...')

%set figure properties
set(groot,'defaultTextInterpreter','latex');
figure('DefaultAxesFontSize',14);

%compute norms of memory kernels
norms = squeeze(pagenorm(K));

%plot norms of memory kernels
semilogy(norms,'.b','markersize',20); title('norms of memory kernels')
xlabel('$t$'); ylabel('$\|M(t)\|_2$')