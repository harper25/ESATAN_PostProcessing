function drawGroupHeatFlow(obj, conductorType, nodes1, nodes2, saveFlag)
%drawGroupHeatFlow The function draws group heat flow plots for given
%sets of nodes.
%   Example: drawGroupHeatFlow('GL', {'name', [1:5]}, {'name2', [5:9]}, 0)
%   To save plots to files, pass a saveFlag = 1.
%   To get sum of GL and GR heat flows, type in 'GL+GR' as a first argument.
%   To plot all GL, GR and summary heat flow, type in 'all' as a first
%   argument.

times = obj.times/3600;
   
switch conductorType
    case 'GL'
        groupHeatFlowGL = obj.getHeatFlowForGroupsOfNodes('GL', nodes1{2}, nodes2{2});
        groupHeatFlowGR = [];
        groupHeatFlow = [];
        
    case 'GR'
        groupHeatFlowGL = [];
        groupHeatFlowGR = obj.getHeatFlowForGroupsOfNodes('GR', nodes1{2}, nodes2{2});
        groupHeatFlow = [];
    case 'GL+GR'
        groupHeatFlowGL = [];
        groupHeatFlowGR = [];
        groupHeatFlow = obj.getHeatFlowForGroupsOfNodes('GL', nodes1{2}, nodes2{2}) + ...
                        obj.getHeatFlowForGroupsOfNodes('GR', nodes1{2}, nodes2{2});       
    case 'all'
        groupHeatFlowGL = obj.getHeatFlowForGroupsOfNodes('GL', nodes1{2}, nodes2{2});
        groupHeatFlowGR = obj.getHeatFlowForGroupsOfNodes('GR', nodes1{2}, nodes2{2});
        groupHeatFlow = groupHeatFlowGL + groupHeatFlowGR;
    otherwise
        error(['Invalid conductor type: "', conductorType,'". Please, type in: "GL", "GR", "GL+GR" or "all" as a first argument.']);
end

figure('units','normalized','outerposition',[0.2 0.5 0.6 0.45], 'visible','off');
hold on; grid;
xlabel('Time [h]');
ylabel('Heat Flow [W]');

if (length(nodes1{2}) > 1)
    nodes1str = [num2str(nodes1{2}(1)), ':', num2str(nodes1{2}(end))];
else
    nodes1str = num2str(nodes1{2}(1));
end

if (length(nodes2{2}) > 1)
    nodes2str = [num2str(nodes2{2}(1)), ':', num2str(nodes2{2}(end))];
else
    nodes2str = num2str(nodes2{2}(1));
end

if (strcmp(conductorType,'all'))
    conductorType = '';
end

title({[conductorType, ' Heat Flow from ', strrep(nodes1{1},'_',' '),... 
    ' to ', strrep(nodes2{1},'_',' ')],...
	['Nodes: ', nodes1str, ' to ', nodes2str]});
if (~isempty(groupHeatFlow))
    plot(times, groupHeatFlow, 'DisplayName', 'GL+GR', 'linewidth', 2);
end
if (~isempty(groupHeatFlowGL))
    plot(times, groupHeatFlowGL, 'DisplayName', 'GL', 'linewidth', 2);
end
if (~isempty(groupHeatFlowGR))
    plot(times, groupHeatFlowGR, 'DisplayName', 'GR', 'linewidth', 2);
end
legend show;
legend('location', 'best')
xlim([0 times(end)])
set(gcf,'Visible','on');

if (nargin == 5) && (saveFlag == 1)
    if (~exist('plots','dir'))
        mkdir plots
    end
    
    newFolderName = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
    newFolderPath = [pwd,'\plots\', newFolderName];
    mkdir(newFolderPath);    
    
    set(gcf, 'PaperUnits', 'centimeters');
	set(gcf, 'PaperPosition', [0 0 20 10]);
	saveas(gcf,[newFolderPath,'\HEAT_FLOW_', strrep(nodes1{1},' ','_'),...
        '_TO_', strrep(nodes2{1},' ','_')],'png');
else
    warning('Graphs were not saved. Use saveFlag = 1 to save.')
end

end

