function drawUnitHeaterFluxesSum(obj, nodes, saveFlag)
%drawUnitHeaterFluxesSum The function creates unit and heater
%fluxes plots for given sets of nodes.
%   Particular fluxes are calculated as a sum of node fluxes that belong 
%   to a set.

times = obj.times/3600;

if (nargin == 3) && (saveFlag == 1)
    if (~exist('plots','dir'))
        mkdir plots
    end
    
    newFolderName = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
    newFolderPath = [pwd,'\plots\', newFolderName];
    mkdir(newFolderPath);
else
    warning('Graphs were not saved. Use: drawTemperatureForNodes(nodes, 1) to save.')
end

for i = 1:size(nodes,1)
    
    [QI, QR] = obj.getUnitHeaterFluxesSumForOneSetOfNodes(nodes{i,2});

    figure('units','normalized','outerposition',[0.2 0.5 0.6 0.45], 'visible','off');
    hold on; grid;
    xlabel('Time [h]');
    ylabel('Heat Flux [W]');
    title({['Unit & Heater Fluxes of ', strrep(nodes{i,1},'_',' ')], ['Nodes: ', num2str(nodes{i,2}(1)), ' to ', num2str(num2str(nodes{i,2}(end)))]});
    plot(times, QI, times, QR, 'linewidth', 2);
    xlim([0 times(end)])
    legend('QI - unit flux', 'QR - heater flux', 'location', 'best')
    
    set(gcf,'Visible','on');
    
    if (nargin == 3) && (saveFlag == 1)
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf, 'PaperPosition', [0 0 20 10]);
        saveas(gcf,[newFolderPath,'\ENVIRNMENTAL_FLUX_', strrep(nodes{i,1},' ','_')],'png');
    end
end





end

