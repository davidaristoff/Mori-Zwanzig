function plot_transitions(T,T_MZ,T_MSM,L,tmax,tfinal,tMSM)

disp('plotting transition matrices...')

%set figure propoerties
set(groot,'defaultTextInterpreter','latex');
figure('DefaultAxesFontSize',14,'Position',[50 900 1400 700])

%permute matrices for plotting
T = permute(T,[3 1 2]);
T_MZ = permute(T_MZ,[3 1 2]);
T_MSM = permute(T_MSM,[3 1 2]);

%plot transition matrices
for k=1:L^2                        %loop over pairs of coarse states
    subplot(L,L,k); i = ceil(k/L); j = k-L*floor((k-1)/L); hold on
    plot(T(:,i,j),'-b','linewidth',2); 
    plot(T_MZ(:,i,j),':r','linewidth',2);
    plot(tMSM:tMSM:tfinal-1,T_MSM(1:tMSM:tfinal-tMSM,i,j),'.',...
        'color',[0 .5 0],'markersize',10);
    %xlim([tmax tfinal]); set(gca,'xscale','log')
    yl = ylim; 
    line([tmax tmax],[yl(1) yl(2)],'color','k','linestyle','-.');
    ylim([yl(1) yl(2)]); xlabel('$t$'); ylabel('$T(t)$')
    if k==1
        legend('exact','MZ','MSM');
    end
    title("$i = $" + i + ", $j = $" + j)
end
sgtitle('$T_{ij}(t)$')
