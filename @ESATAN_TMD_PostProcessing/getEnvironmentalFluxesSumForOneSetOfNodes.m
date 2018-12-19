function [QS, QA, QE] = getEnvironmentalFluxesSumForOneSetOfNodes(obj, nodeset)
%getEnvironmentalFluxesSumForOneSetOfNodes The function returns a sum of
%particular environmental fluxes for specified set of nodes.
%   QS - solar flux
%   QA - albedo flux
%   QE - earth/planet flux

QS = zeros(length(obj.times),1);
QA = zeros(length(obj.times),1);
QE = zeros(length(obj.times),1);

indexNodes = obj.getNodeIndex(nodeset);

for indexNode = indexNodes
	QS = QS + squeeze(obj.thermalNodesRealData(7,indexNode,:)); % QS solar
	QA = QA + squeeze(obj.thermalNodesRealData(3,indexNode,:)); % QA albedo
	QE = QE + squeeze(obj.thermalNodesRealData(4,indexNode,:)); % QE earth/planet
end

end

