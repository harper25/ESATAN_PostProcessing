function [attribute] = getAttribute(obj, attributeNameString)
%getAttribute The function returns a given attribute.
%   To see a complete list of available attributes, please call the
%   function without any parameters: getAttribute().

attributeList = ['List of attributes to get:\n', ...
    '- times\n', '- conductorsGL\n', '- conductorsGR\n', '- thermalNodes\n', ...
    '- thermalNodesRealAttributes\n', '- conductorDataGL\n', ...
    '- conductorDataGR\n', '- thermalNodesRealData\n', ...
    '- thermalNodesStringData\n'];

if (nargin == 1)
    fprintf(attributeList)
    attribute = [];
else
    switch attributeNameString
        case 'conductorsGL'
            attribute = obj.conductorsGL;
        case 'conductorsGR'
            attribute = obj.conductorsGR;
        case 'thermalNodes'
            attribute = obj.thermalNodes;
        case 'thermalNodesRealAttributes'
            attribute = obj.thermalNodesRealAttributes;
        case 'conductorDataGL'
            attribute = obj.conductorDataGL;
        case 'conductorDataGR'
            attribute = obj.conductorDataGR;
        case 'thermalNodesRealData'
            attribute = obj.thermalNodesRealData;
        case 'thermalNodesStringData'
            attribute = obj.thermalNodesStringData;
        case 'times'
            attribute = obj.times;
        otherwise
            obj.getAttribute();
            error(['Invalid attribute name: "', attributeNameString,'"']);
    end
end

end

