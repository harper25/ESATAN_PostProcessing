function groupHeatFlow = getHeatFlowForGroupsOfNodes(obj, conductorType, nodeset1, nodeset2, timestep)
%getHeatFlowForGroupsOfNodes The function returns a heat flow between two
%sets of nodes.
%   The order of the node sets is taken into account.

if (~isa(conductorType,'char'))
    error('Invalid conductor type. Please, type in: "GL" or "GR" as a first argument.');
end

indexNodes1 = obj.getNodeIndex(nodeset1);
indexNodes2 = obj.getNodeIndex(nodeset2);
indexConductors = obj.getConductorIndexesForSetsOfNodeIndexes(conductorType, indexNodes1, indexNodes2);

if (nargin == 4)
    groupHeatFlow = zeros(length(obj.times),1);
    timestep = [];
elseif (nargin == 5)
    groupHeatFlow = 0;
else
    error('Invalid arguments!');
end

for i = 1:length(indexConductors)
    
    switch conductorType
        case 'GL'
            indexNode1 = obj.conductorsGL(1,indexConductors(i));
            indexNode2 = obj.conductorsGL(2,indexConductors(i));
        case 'GR'
            indexNode1 = obj.conductorsGR(1,indexConductors(i));
            indexNode2 = obj.conductorsGR(2,indexConductors(i));
    end
    
    temperature1 = obj.getTemperatureForNodeIndex(indexNode1, timestep);
    temperature2 = obj.getTemperatureForNodeIndex(indexNode2, timestep);
    conductance = obj.getConductanceForConductorIndex(conductorType, indexConductors(i), timestep);
    
    singleHeatFlow = obj.calculateHeatFlow(conductorType, temperature1, temperature2, conductance);
    
    if (ismember(indexNode1, indexNodes1))
        groupHeatFlow = groupHeatFlow + singleHeatFlow;
    else
        groupHeatFlow = groupHeatFlow - singleHeatFlow;
    end
    
end

end

