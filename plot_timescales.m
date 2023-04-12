function plot_timescales(T,T_MZ,T_MSM,L,tmem,tMSM,tfinal,FPTs)

disp('plotting implied timescales...')

%set figure properties
set(groot,'defaultTextInterpreter','latex');
figure('DefaultAxesFontSize',16);

%compute implied timescales
eigs_ref = pageeig(T,'vector'); eigs_ref = sort(squeeze(eigs_ref));
eigs_MSM = pageeig(T_MSM,'vector'); eigs_MSM = sort(squeeze(eigs_MSM));
eigs_MZ = pageeig(T_MZ,'vector'); eigs_MZ = sort(squeeze(eigs_MZ));

%plot implied timescales
ts = 1:1:tfinal; hold on;
plot(ts,-ts./log(eigs_MZ(L-1,:)),'-b','linewidth',2);
plot(ts,-ts./log(eigs_ref(L-1,:)),'-.r','linewidth',2);
ind = eigs_MSM(L-1,:) ~= 0; ts_ = ts(ind)+tMSM-1;
plot(ts_,-ts_./log(eigs_MSM(L-1,ind)),'.g','markersize',20);
ylabel('$t/log(\lambda_2(t))$'); ylim([0 mean(FPTs)]); 
set(gca,'yscale','log');
line([min(ts) max(ts)],0.5*[mean(FPTs) mean(FPTs)],...
    'color','m','linestyle',':','linewidth',2);
legend("MZ matrices, " + tmem + " kernels","reference matrices",...
    "MSM at lag " + tMSM,"half MFPT",'interpreter','latex',...
    'fontsize',16,'location','southeast'); 
xlabel('lag $t$'); title('implied timescales')