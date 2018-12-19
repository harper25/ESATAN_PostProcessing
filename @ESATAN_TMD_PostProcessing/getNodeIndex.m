function indexNode = getNodeIndex(obj, node)
%getNodeIndex The function returns an index or indexes of node or nodes.
%   Node indexes are used as node references in other data structures. For
%   example: 
%   thermalNodes = [123, 124, 125, ...]
%   conductorsGL = [1, ...;
%                   3, ...]
%   1 - refers to node 123,
%   3 - refers to node 125.

indexNode = zeros(1, length(node));

for i = 1:length(node)
    % finds only first occurence of node than stops searching - every node
    % appears only once in thermalNodes
    foundIndex = find(obj.thermalNodes == node(i), 1);
    if isempty(foundIndex)
        warning(['Node not found! Node: ', num2str(node(i))])
    else
        indexNode(i) = foundIndex;
    end
end

indexNode(indexNode == 0) = [];

end

