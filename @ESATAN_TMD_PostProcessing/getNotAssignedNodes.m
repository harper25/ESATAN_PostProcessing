function [nodesNotAssigned] = getNotAssignedNodes(obj, nodes)
%getNotAssignedNodes The function returns nodes that are not assigned in
%'nodes' cell.
%   If all nodes are assigned to sets in 'nodes', empty array is returned.

nodesNotAssigned = obj.getAttribute('thermalNodes');
for i = 1:size(nodes,1)
    nodesNotAssigned = setdiff(nodesNotAssigned,nodes{i,2});
end

if (~isempty(nodesNotAssigned))
    nodesString = obj.numbersToOneLine(nodesNotAssigned);
    warning(['There are still some free nodes! Assign them to proper sets: ', nodesString]) 
end

end

