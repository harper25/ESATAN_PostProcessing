function drawHeatFlowBalanceForOneSetOfNodes(obj, nodes, nodesRowNumber, saveFlag)
%drawHeatFlowBalanceForOneSetOfNodes The function draws heat flows for node 
%set specified by nodesRowNumber. On the graph there are heat flows for
%every possible pair of nodes, in which nodes{nodesRawNumber,:} are
%present.
%   The function at first checks if all nodes are assigned to node sets and
%   if there is no nodes that belong to more than 1 set. In case of failing
%   at least one of these conditions, the user is notified about
%   inconsistencies and asked for decision to continue.

notAssignedNodes = obj.getNotAssignedNodes(nodes);
repeatedNodes = obj.getRepeatedNodes(nodes);

if ~(isempty(notAssignedNodes) && isempty(repeatedNodes))
    answer = input('The results may be invalid due to incomplete definition of nodes. Proceed? (y/n): ', 's');
    if ~(strcmpi(answer, 'y'))
        return;
    end
end

times = obj.times/3600;

figure('units','normalized','outerposition',[0.2 0.5 0.6 0.45], 'visible','off');
hold on; grid;
xlabel('Time [h]');
ylabel('Heat Flow [W]');
title(['Heat Flow Balance for ', strrep(nodes{nodesRowNumber,1},'_',' ')])

summaryHeatFlow = zeros(size(obj.times));

for i = 1:length(nodes)
    if (i ~= nodesRowNumber)
        groupHeatFlow = obj.getHeatFlowForGroupsOfNodes('GL', nodes{nodesRowNumber,2}, nodes{i,2}) + ...
                        obj.getHeatFlowForGroupsOfNodes('GR', nodes{nodesRowNumber,2}, nodes{i,2});
        summaryHeatFlow = summaryHeatFlow + groupHeatFlow;
        plot(times, groupHeatFlow, 'DisplayName', ['to ', strrep(nodes{i,1},'_',' ')], 'linewidth', 2);
    end
end

legend show;
legend('location', 'best')
set(gcf,'Visible','on');
xlim([0 times(end)])

if (nargin == 4) && (saveFlag == 1)
    if (~exist('plots','dir'))
        mkdir plots
    end
    newFolderName = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
    newFolderPath = [pwd,'\plots\', newFolderName];
    mkdir(newFolderPath);    
    
    set(gcf, 'PaperUnits', 'centimeters');
	set(gcf, 'PaperPosition', [0 0 20 10]);
	saveas(gcf,[newFolderPath,'\HEAT_FLOW_BALANCE_FOR_', strrep(nodes{nodesRowNumber,1},' ','_')],'png');
else
    warning('Graphs were not saved. Use saveFlag = 1 to save.')
end

figure('units','normalized','outerposition',[0.2 0.5 0.6 0.45]);
hold on; grid;
xlabel('Time [h]');
ylabel('Heat Flow [W]');
title(['Summary Heat Flow for ', strrep(nodes{nodesRowNumber,1},'_',' ')])
plot(times, summaryHeatFlow, 'r--', 'linewidth', 2);
xlim([0 times(end)])

if (nargin == 4) && (saveFlag == 1)
    set(gcf, 'PaperUnits', 'centimeters');
	set(gcf, 'PaperPosition', [0 0 20 10]);
	saveas(gcf,[newFolderPath,'\SUMMARY_HEAT_FLOW_FOR_', strrep(nodes{nodesRowNumber,1},' ','_')],'png');

end

