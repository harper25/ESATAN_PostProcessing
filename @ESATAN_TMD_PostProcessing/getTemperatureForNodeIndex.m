function temperature = getTemperatureForNodeIndex(obj, indexNode, timestep)
%getTemperatureForNodeIndex The function returns the temperature for a
%single timestep or a whole temperature flow.
%   The only necessary input is a node index. If only an index is passed to
%   the function, the output is a complete temperature flow for the node.
%   If the second (optional) argument is specified, which is a timestep,
%   the function returns a temperature for this timestep only.

if (nargin == 3) && (~isempty(timestep))
    temperature = squeeze(obj.thermalNodesRealData(1, indexNode, timestep));
else
    temperature = squeeze(obj.thermalNodesRealData(1, indexNode, :));
end

end

