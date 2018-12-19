function heatFlow = getHeatFlowForNodes(obj, conductorType, node1, node2)
%getHeatFlowForNodes The function returns a complete heat flow between
%given two nodes.
%   Conductor type has to be specified: 'GL' or 'GR'.

if (nargin == 3)
    error('Invalid conductor type. Please, type in: "GL" or "GR" as a first argument.');
end

indexNode1 = obj.getNodeIndex(node1);
indexNode2 = obj.getNodeIndex(node2);
temperature1 = obj.getTemperatureForNodeIndex(indexNode1);
temperature2 = obj.getTemperatureForNodeIndex(indexNode2);

indexConductor = obj.getConductorIndexByNodeIndexes(conductorType, indexNode1, indexNode2);
if (isempty(indexConductor))
    error('There is no conductor of such type between given nodes!')
end

conductance = obj.getConductanceForConductorIndex(conductorType, indexConductor);
heatFlow = obj.calculateHeatFlow(conductorType, temperature1, temperature2, conductance);

end

