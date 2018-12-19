function conductorIndexes = getConductorIndexesForSetsOfNodeIndexes(obj, conductorType, indexNodes1, indexNodes2)
%getConductorIndexesForSetsOfNodeIndexes 
%This function receives two sets of nodes together with conductor type.
%It returns all indexes of conductors that connect any node from the first
%set with any node from the second set.
%Assumption: Every node belongs only to one set.
%   1) Find node indexes for all nodes
%   2) Find occurences of node indexes in proper 'GL' or 'GR' conductor
%   array
%   3) Find conductor indexes (columns in conductor array) in which there
%   is only one node index from the first set and only one node index from
%   the second set

if (nargin == 3)
    error('Invalid conductor type. Please, type in: "GL" or "GR" as a first argument.');
end

switch conductorType
    case 'GL'
        idx1 = ismember(obj.conductorsGL, indexNodes1);
        idx2 = ismember(obj.conductorsGL, indexNodes2);
    case 'GR'
        idx1 = ismember(obj.conductorsGR, indexNodes1);
        idx2 = ismember(obj.conductorsGR, indexNodes2);
    otherwise
        error(['Invalid conductor type: "', conductorType,'". Please, type in: "GL" or "GR" as a first argument.']);
end

% xor(idx1(1,:), idx1(2,:))
% find(xor(idx1(1,:), idx1(2,:)))
% 
% xor(idx2(1,:), idx2(2,:))
% find(xor(idx2(1,:), idx2(2,:)))
% 
% and(xor(idx1(1,:), idx1(2,:)), xor(idx2(1,:), idx2(2,:)))

conductorIndexes = find(and(xor(idx1(1,:), idx1(2,:)), xor(idx2(1,:), idx2(2,:))));


end

