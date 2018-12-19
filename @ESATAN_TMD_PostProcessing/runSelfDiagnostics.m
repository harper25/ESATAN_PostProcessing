function runSelfDiagnostics(obj)
%runSelfDiagnostics The function checks some of the internal methods for
%validity.
%   Functions being tested: getNodeIndex(),
%   getConductorIndexByNodeIndexes(), getConductorIndexByNodes(), 
%   getTemperatureForNodeIndex(), getConductanceForConductorIndex().
disp('SelfDiagnostics started!')
tic

%% getNodeIndex

for testNodeIndex = 1:length(obj.thermalNodes)
    assert(obj.getNodeIndex(obj.thermalNodes(testNodeIndex)) == testNodeIndex)
end
disp('getNodeIndex is OK...')

%% getConductorIndexByNodeIndexes

for conductorIndex = 1:size(obj.conductorsGL,2)
    nodeIndex1 = obj.conductorsGL(1,conductorIndex);
    nodeIndex2 = obj.conductorsGL(2,conductorIndex);
    assert(obj.getConductorIndexByNodeIndexes('GL', nodeIndex1, nodeIndex2) == conductorIndex);
end

for conductorIndex = 1:size(obj.conductorsGR,2)
    nodeIndex1 = obj.conductorsGR(1,conductorIndex);
    nodeIndex2 = obj.conductorsGR(2,conductorIndex);
    assert(obj.getConductorIndexByNodeIndexes('GR', nodeIndex1, nodeIndex2) == conductorIndex);
end
disp('getConductorIndexByNodeIndexes is OK...')

%% getConductorIndexByNodes

for conductorIndex = 1:size(obj.conductorsGL,2)
    nodeIndex1 = obj.conductorsGL(1,conductorIndex);
    nodeIndex2 = obj.conductorsGL(2,conductorIndex);
    node1 = obj.thermalNodes(nodeIndex1);
    node2 = obj.thermalNodes(nodeIndex2);
    assert(obj.getConductorIndexByNodes('GL', node1, node2) == conductorIndex);
end

for conductorIndex = 1:size(obj.conductorsGR,2)
    nodeIndex1 = obj.conductorsGR(1,conductorIndex);
    nodeIndex2 = obj.conductorsGR(2,conductorIndex);
    node1 = obj.thermalNodes(nodeIndex1);
    node2 = obj.thermalNodes(nodeIndex2);
    assert(obj.getConductorIndexByNodes('GR', node1, node2) == conductorIndex);
end
disp('getConductorIndexByNodes is OK...')

%% isConductorDataConstant

if (obj.isConductorDataConstant('GL'))
    disp('ConductorDataGL is constant...')
else
    disp('ConductorDataGL is NOT constant...')
end

if (obj.isConductorDataConstant('GR'))
    disp('ConductorDataGR is constant...')
else
    disp('ConductorDataGR is NOT constant...')
end

%% getTemperatureForNodeIndex

for indexNode = 1:size(obj.thermalNodes,2)
    assert(all(squeeze(obj.thermalNodesRealData(1, indexNode, :)) == obj.getTemperatureForNodeIndex(indexNode)))
    
    for timestep = 1:size(obj.thermalNodesRealData,3)
        assert(obj.thermalNodesRealData(1, indexNode, timestep) == obj.getTemperatureForNodeIndex(indexNode, timestep))
    end
end
disp('getTemperatureForNodeIndex is OK...')

%% getConductanceForConductorIndex

for conductorIndex = 1:size(obj.conductorsGL,2)
    assert(all(obj.conductorDataGL(conductorIndex,:)' == obj.getConductanceForConductorIndex('GL',conductorIndex)))
    for timestep = 1:size(obj.conductorDataGL,2)
        assert(obj.conductorDataGL(conductorIndex,timestep) == obj.getConductanceForConductorIndex('GL',conductorIndex,timestep))
    end
end

for conductorIndex = 1:size(obj.conductorsGR,2)
    assert(all(obj.conductorDataGR(conductorIndex,:)' == obj.getConductanceForConductorIndex('GR',conductorIndex)))
    for timestep = 1:size(obj.conductorDataGR,2)
        assert(obj.conductorDataGR(conductorIndex,timestep) == obj.getConductanceForConductorIndex('GR',conductorIndex,timestep))
    end
end
disp('getConductanceForConductorIndex is OK...')
disp('SelfDiagnostics completed successfully!')
toc

end

