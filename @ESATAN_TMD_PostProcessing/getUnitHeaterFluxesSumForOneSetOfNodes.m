function [QI, QR] = getUnitHeaterFluxesSumForOneSetOfNodes(obj, nodeset)
%getUnitHeaterFluxesSumForOneSetOfNodes The function returns a sum of
%unit and heater fluxes for specified set of nodes.
%   QI - unit flux
%   QR - heater flux

QI = zeros(length(obj.times),1);
QR = zeros(length(obj.times),1);

indexNodes = obj.getNodeIndex(nodeset);

for indexNode = indexNodes
    QI = QI + squeeze(obj.thermalNodesRealData(5,indexNode,:));
	QR = QR + squeeze(obj.thermalNodesRealData(6,indexNode,:));
end

end


