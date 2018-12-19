function drawTemperatureForNodes(obj, nodes, saveFlag)
%drawTemperaturesForNodes The function creates temperature plots for given
%sets of nodes from a cell.
%   To save plots to files, pass a saveFlag = 1.

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
    figure('units','normalized','outerposition',[0.2 0.5 0.6 0.45], 'visible','off');
    hold on; grid;
    xlabel('Time [h]');
    ylabel('Temperature [{\circ}C]');
    title({['Temperatures of ', strrep(nodes{i,1},'_',' ')], ['Nodes: ', num2str(nodes{i,2}(1)), ' to ', num2str(num2str(nodes{i,2}(end)))]});
    
    for node = nodes{i,2}
        indexNode = obj.getNodeIndex(node);
        if (~isempty(indexNode))
            if find(ismember(nodes{i,3}, node), 1)
                plot(times, obj.getTemperatureForNodeIndex(indexNode), '--','linewidth', 2, 'DisplayName', num2str(node));
                legend show;
                legend('location', 'best');
            else
                plot(times, obj.getTemperatureForNodeIndex(indexNode), 'HandleVisibility', 'off');
            end
        end
    end
    
    xlim([0 times(end)])
    set(gcf,'Visible','on');
    
    if (nargin == 3) && (saveFlag == 1)
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf, 'PaperPosition', [0 0 20 10]);
        saveas(gcf,[newFolderPath,'\TEMPERATURE_', strrep(nodes{i,1},' ','_')],'png');
    end
end

end

