% TMD file post-processing
% Demo file showing how to use Matlab Postprocessing Tool for Esatan
% Analyses. For help with the functions, their inputs, outputs and usage,
% please, type in: help <function_name> or go to the source file to see 
% the description.
%
% Contact: olesjakubb@gmail.com
% Date: 28.08.2018
% Enjoy and feel free to add new features!

% The file is intended to be a quick guide, thus it provides the user with
% syntax and usage of the particular methods. It is recommended to leave
% the file unchanged to serve its purpose as an instruction. Instead, please
% create a new file and copy proper syntax for each new analysis case.

%% Configuration

clear all;
clear classes;
commandwindow;
% path to the *.tmd file (or simply filename, if it is located in the same
% folder)
path = 'GSG_SAT_POLAR.TMD';
% Initialization of an object 'tmd' of the class type
% 'ESATAN_TMD_PostProcessing'. During initialization, data from the thermal 
% analysis is loaded.
tmd = ESATAN_TMD_PostProcessing(path);

% The user should define nodes that are used in ESATAN analysis and assign 
% them to proper sets. The tool does not use labels from ESATAN. 
% 'nodes' is a cell structure of node sets, defined separately in each row. 
% The first column is a label for the node set, while the second defines 
% nodes that belong to this set. For array creation, please, refer to any
% Matlab tutorial. The third column usually remains empty unless you would
% like to mark particular nodes on a temperature graph while drawing
% temperature of nodes for a certain group.

nodes = {
    'PX_PANEL',             [2100:2149, 3100:3149],         [];
    'PY_PANEL',             [2002, 3002],                   [3000];
    'PZ_PANEL',             [2000, 3000, 2001],             [];
    'MY_PANEL',             [2003, 3003],                   [2003];
    'MZ_PANEL',             [2001, 3001],                   [];
    'SOLAR_PANEL',          [5000:5005, 6000:6005],         [6002, 6005];
    'RADIATOR',             [2500:2549, 3500:3549],         [];
};


% Nodes and node groups have to be defined in Matlab. It allows for
% more flexibility in analysis in case of investigating particular nodes
% or node groups. It also enforces double-checking the node structure 
% of a thermal model.

%% get some info about internal TMD file structure

tmd.displayInfo()

%% get constants used to calculate heat flow

tmd.showEsatanConstants()

%% get list of attributes

tmd.getAttribute()

%% get some attributes

thermalNodes = tmd.getAttribute('thermalNodes');
thermalNodesRealAttributes = tmd.getAttribute('thermalNodesRealAttributes')
% thermalNodesRealAttributes reffer to thermalNodesRealData
size(tmd.getAttribute('thermalNodesRealData'))
size(thermalNodesRealAttributes)
size(thermalNodes)
size(tmd.getAttribute('times'))


%% check if there are any nodes in TMD file that are not assigned to proper 
%  sets in 'nodes'

tmd.getNotAssignedNodes(nodes)

%% check if there are any nodes that belong to more than one group in 'nodes'

tmd.getRepeatedNodes(nodes)

%% check if conductivity is constant in time for every conductor

tmd.isConductorDataConstant('GL')
tmd.isConductorDataConstant('GR')

%% draw node temperatures

tmd.drawTemperatureForNodes(nodes);
tmd.drawTemperatureForNodes({'test_node', 2100, 2100})
% draw and save!
% tmd.drawTemperatureForNodes(nodes, 1);


%% GR Heat Flow for single nodes

node1 = 2110;
node2 = 6005;

singleHeatFlow = tmd.getHeatFlowForNodes('GR', node1, node2);

timestep = 0;
%%
timestep = timestep+1;
fprintf('Timestep: %i, Time: %.2f, Heat flow: %.10fW\n', timestep, times(timestep), singleHeatFlow(timestep))


%% GR Heat Flow for groups of nodes

nodes1 = nodes{7,2};
nodes2 = 99999;

groupHeatFlow = tmd.getHeatFlowForGroupsOfNodes('GR', nodes1, nodes2);

timestep = 0;
%%
timestep = timestep+1;
fprintf('Timestep: %i, Heat flow: %.9fW\n', timestep, groupHeatFlow(timestep))

%% calculate group heat flow for specific time instant

nodes1 = nodes{1,2};
nodes2 = nodes{6,2};

groupHeatFlow = tmd.getHeatFlowForGroupsOfNodes('GR', nodes1, nodes2);

timestep = 0;
%%
timestep = timestep+1;
groupHeatFlow2 = tmd.getHeatFlowForGroupsOfNodes('GR', nodes1, nodes2, timestep);
fprintf('Timestep: %i, Heat flow: %.10fW\n', timestep, groupHeatFlow(timestep))
fprintf('Timestep: %i, Heat flow: %.10fW\n', timestep, groupHeatFlow2)


%% draw some heat flows

tmd.drawGroupHeatFlow('GL+GR', nodes(6,:), nodes(7,:))
tmd.drawGroupHeatFlow('GR', nodes(6,:), nodes(7,:))
tmd.drawGroupHeatFlow('all', nodes(6,:), nodes(7,:))
tmd.drawGroupHeatFlow('GR', {'node5000', 5000}, {'env', 99999})
% draw and save!
% tmd.drawGroupHeatFlow('GR', {'node5000', 5000}, {'env', 99999}, 1)

%% get environmental, heater and unit fluxes for node groups

[QS, QA, QE] = tmd.getEnvironmentalFluxesSumForOneSetOfNodes(nodes{6,2});
[QI, QR] = tmd.getUnitHeaterFluxesSumForOneSetOfNodes(nodes{6,2});
timestep = 0;

%%
timestep = timestep + 1;
fprintf('Timestep: %i, Sun flux: %.10fW\n', timestep, QS(timestep))

%% draw environmental fluxes for node groups

tmd.drawEnvironmentalFluxesSum(nodes);
tmd.drawEnvironmentalFluxesSum(nodes(7,:),1);
% draw and save!
% tmd.drawEnvironmentalFluxesSum(nodes(7,:), 1);

%% draw unit and heater fluxes for node groups

tmd.drawUnitHeaterFluxesSum(nodes);
% draw and save!
tmd.drawUnitHeaterFluxesSum(nodes, 1);

%% get data on temperature ranges

[temperatureRanges, details] = tmd.getTemperatureRanges(nodes)


%% generate raport on temperature ranges in Excel

limit = 10;
tmd.generateTemperatureRangesReport(nodes, limit)
% generate and save!
% tmd.generateTemperatureRangesReport(nodes, limit, 1)

%% draw heat flow chart for a set of nodes 
% (if nothing happens, check the command window for warnings and further actions)

tmd.drawHeatFlowBalanceForOneSetOfNodes(nodes, 6)
% generate and save!
% tmd.drawHeatFlowBalanceForOneSetOfNodes(nodes, 6, 1)

%% check how things were tested

tmd.runSelfDiagnostics()


%%



