function plot_data(X,data,V,CV,l)

disp('plotting data points and potential energy...')

%plot data and potential energy
figure('DefaultAxesFontSize',14); hold on; 
fcontour(V,[-15 15 -10 10],'LevelList',-10:.2:10); colorbar;
scatter(X(1:l:end,1),X(1:l:end,2),5,data(1:l:end,CV),'filled'); 
axis([-15 15 -10 10])