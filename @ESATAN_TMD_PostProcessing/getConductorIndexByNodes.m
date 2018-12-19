function indexConductor = getConductorIndexByNodes(obj, conductorType, node1, node2)
%getConductorIndexByNodes The function returns the index (column 
%number) of a specified conductor 'GL' or 'GR' in conductorsGL or
%conductorsGR. The input consists of two node numbers.
%   The function uses getConductorIndexByNodeIndexes()

if (nargin == 3)
    error('Invalid conductor type. Please, type in: "GL" or "GR" as a first argument.');
end

indexNode1 = obj.getNodeIndex(node1);
indexNode2 = obj.getNodeIndex(node2);

indexConductor = obj.getConductorIndexByNodeIndexes(conductorType, indexNode1, indexNode2);

end

