function drawEnvironmentalFluxesSum(obj, nodes, saveFlag)
%drawSumEnvironmentalFluxesForNodes The function creates environmental
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
    
    [QS, QA, QE] = obj.getEnvironmentalFluxesSumForOneSetOfNodes(nodes{i,2});

    figure('units','normalized','outerposition',[0.2 0.5 0.6 0.45], 'visible','off');
    hold on; grid;
    xlabel('Time [h]');
    ylabel('Heat Flux [W]');
    title({['Environmental Fluxes of ', strrep(nodes{i,1},'_',' ')], ['Nodes: ', num2str(nodes{i,2}(1)), ' to ', num2str(num2str(nodes{i,2}(end)))]});
    plot(times, QS, times, QA, times, QE, 'linewidth', 2);
    xlim([0 times(end)])
    legend('QS - absorbed solar flux', 'QA - absorbed albedo flux', 'QE - absorbed planet flux', 'location', 'best')
    
    set(gcf,'Visible','on');
    
    if (nargin == 3) && (saveFlag == 1)
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf, 'PaperPosition', [0 0 20 10]);
        saveas(gcf,[newFolderPath,'\ENVIRNMENTAL_FLUX_', strrep(nodes{i,1},' ','_')],'png');
    end
end


end

