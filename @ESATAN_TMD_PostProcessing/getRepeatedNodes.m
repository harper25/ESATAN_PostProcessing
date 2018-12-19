function [nodesRepeated] = getRepeatedNodes(~, nodes)
%getRepeatedNodes The function returns nodes that occur twice or more in
%'nodes' cell.
%   If every node occurrs only once in 'nodes', empty array is returned.

allNodes = [];
nodesRepeated = [];

for i = 1:size(nodes,1)
    allNodes = [allNodes nodes{i,2}];
end

uniqueNodes   = unique(allNodes);
counts = histc(allNodes, uniqueNodes);

indexMultipleOccurences = find(counts>1);

for i = indexMultipleOccurences
    nodesRepeated = [nodesRepeated uniqueNodes(i)];
    nodeSets = '';
    
    for j = 1:length(nodes)
       if (find(nodes{j,2} == uniqueNodes(i)))
           nodeSets = [nodeSets, ' ', nodes{j,1}];
       end        
    end
    warning(['Node: ', num2str(uniqueNodes(i)), ', occurrences: ', ...
        num2str(counts(i)), ' in: ', nodeSets]);
    
end


end
