function [temperatureRanges, details] = getTemperatureRanges(obj, nodeset)
%getTemperatureRanges The function returns a temperature range for defined
%nodes.
%   The maximal and minimal value of temperature is found for specified
%   sets of nodes for the entire timespan.
%   
%   For details about exact time and node at which the extremum occurred,
%   use two output form: [temperatureRanges, details].
%   Details - is a cell structure. It detects multiple extreme occurrences
%   in case several nodes at different (or the same) time have an extreme
%   temperature. 
%
%   Details are defined as follows (n - node, t - time):
%   details = {
%   [n1 (for min)] [t1 (for min)] [n1 (for max)] [t1 (for max)];
%   [n1, n2 (for min)] [t1, t2 (for min)] [n1 (for max)] [t1 (for max)];
%   ... } 
%   -  in this case the second node set has two nodes n1, n2 at
%   which minimum temperature ocurred at times t1, t2. 

temperatureRanges = Inf(size(nodeset,1),2);
temperatureRanges(:,2) = temperatureRanges(:,2) * (-1);

if (nargout == 2)
    details = cell(size(nodeset,1),4);

    for i = 1:size(nodeset,1)

        for indexNode = obj.getNodeIndex(nodeset{i,2})

            [minTemperature, indexMin] = min(obj.thermalNodesRealData(1,indexNode,:));
            [maxTemperature, indexMax] = max(obj.thermalNodesRealData(1,indexNode,:));

            if (minTemperature < temperatureRanges(i,1))
                temperatureRanges(i,1) = minTemperature;
                details{i,1} = obj.thermalNodes(indexNode);
                details{i,2} = obj.times(indexMin);
            elseif (minTemperature == temperatureRanges(i,1))       
                details{i,1} = [details{i,1} obj.thermalNodes(indexNode)];
                details{i,2} = [details{i,2} obj.times(indexMin)];
            end

            if (maxTemperature > temperatureRanges(i,2))
                temperatureRanges(i,2) = maxTemperature;
                details{i,3} = obj.thermalNodes(indexNode);
                details{i,4} = obj.times(indexMax);
            elseif (maxTemperature == temperatureRanges(i,2))
                details{i,3} = [details{i,3} obj.thermalNodes(indexNode)];
                details{i,4} = [details{i,4} obj.times(indexMax)];
            end  

        end

    end

else

    for i = 1:size(nodeset,1)

        indexNode = obj.getNodeIndex(nodeset{i,2});
        thermalMatrix = obj.thermalNodesRealData(1, indexNode, :);

        minTemperature = min(thermalMatrix(:));
        maxTemperature = max(thermalMatrix(:));

        if (minTemperature < temperatureRanges(i,1))
            temperatureRanges(i,1) = minTemperature;
        end
        if (maxTemperature > temperatureRanges(i,2))
            temperatureRanges(i,2) = maxTemperature;
        end

    end

    
    
end

