function loadDataFromTMD(obj)
%loadData The function is used to load data from TMD file.
%   -

obj.tmdLink = h5info(obj.path);

dataset = '/AnalysisSet1/conductorsGL';
obj.conductorsGL = h5read(obj.path, dataset, [1 1], [2 Inf]);
% size(conductorsGL)

dataset = '/AnalysisSet1/conductorsGR';
obj.conductorsGR = h5read(obj.path, dataset, [1 1], [2 Inf]);
% size(conductorsGR)

dataset = '/AnalysisSet1/thermalNodes';
obj.thermalNodes = h5read(obj.path, dataset, [1 1], [1 Inf]);
% size(thermalNodes)

dataset = '/AnalysisSet1/thermalNodesRealAttributes';
obj.thermalNodesRealAttributes = h5read(obj.path, dataset);
% size(thermalNodesRealAttributes)

dataset = '/AnalysisSet1/DataGroup1/conductorDataGL';
obj.conductorDataGL = squeeze(h5read(obj.path, dataset, [1 1 1], [1 Inf Inf]));
% size(conductorDataGL)

dataset = '/AnalysisSet1/DataGroup1/conductorDataGR';
obj.conductorDataGR = squeeze(h5read(obj.path, dataset, [1 1 1], [1 Inf Inf]));
% size(conductorDataGR)

dataset = '/AnalysisSet1/DataGroup1/thermalNodesRealData';
obj.thermalNodesRealData = h5read(obj.path, dataset);
% size(thermalNodesRealData)

dataset = '/AnalysisSet1/DataGroup1/thermalNodesStringData';
datasetInfo = h5info(obj.path, dataset);
datasetSize = datasetInfo.Dataspace.Size;
obj.thermalNodesStringData = h5read(obj.path, dataset, [1 1 1], [datasetSize(1) datasetSize(2) 1]);
% size(thermalNodesStringData)

dataset = '/AnalysisSet1/DataGroup1/times';
obj.times = h5read(obj.path, dataset);
% size(times)

% h5info(obj.path, '/AnalysisSet1/thermalNodesStringAttributes')
% thermalNodesStringAttributes = h5read(obj.path, '/AnalysisSet1/thermalNodesStringAttributes');


end

