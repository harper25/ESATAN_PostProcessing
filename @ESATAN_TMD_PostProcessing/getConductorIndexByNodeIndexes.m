function indexConductor = getConductorIndexByNodeIndexes(obj, conductorType, indexNode1, indexNode2)
%getConductorIndexByNodeIndexes The function returns the index (column 
%number) of a specified conductor 'GL' or 'GR' in conductorsGL or
%conductorsGR.  The input consists of two node indexes.
%   Conductors are always sorted so that the first index is higher than the
%   second in one pair. Also, the pairs are sorted by the first conductor.
%   One conductor should be defined once. It is not defined, how ESATAN and
%   this programm will act when two or more conductors of the same type 
%   would be specified between the same nodes.

if (nargin == 3)
    error('Invalid conductor type. Please, type in: "GL" or "GR" as a first argument.');
end

switch conductorType
    case 'GL'
        indexConductor = find(ismember(obj.conductorsGL', sort([indexNode1, indexNode2]), 'rows'));
    case 'GR'
        indexConductor = find(ismember(obj.conductorsGR', sort([indexNode1, indexNode2]), 'rows'));
    otherwise
        error(['Invalid conductor type: "', conductorType,'". Please, type in: "GL" or "GR" as a first argument.']);
end

end
