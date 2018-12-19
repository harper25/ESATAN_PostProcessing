classdef ESATAN_TMD_PostProcessing < handle
    %ESATAN_TMD_Class - used for post-processing of ESATAN TMD files.
    %   Contact: Jakub Oleœ, koles104@gmail.com
    %   27.08.2018
    
    properties (Access = private)
        tmdLink
        times
        conductorsGL
        conductorsGR
        thermalNodes
        thermalNodesRealAttributes
        conductorDataGL
        conductorDataGR
        thermalNodesRealData
        thermalNodesStringData
    end
    properties (SetAccess = private, GetAccess = public)
        path
    end
    properties (Constant)
        StefanBoltzmann = 5.6686002E-8;
        absoluteTemperature = 273.15;
        
    end
    methods
        % class constructor
        function obj = ESATAN_TMD_PostProcessing(path)
            disp('TMD object initialized with path: ')
            obj.path = path;
            disp(obj.path)
            loadDataFromTMD(obj);
        end

        displayInfo(obj) %
        attribute = getAttribute(obj, attributeNameString) %
        
        heatFlow = getHeatFlowForNodes(obj, conductorType, node1, node2) %
        
        drawTemperatureForNodes(obj, nodes, saveFlag) %
        
        groupHeatFlow = getHeatFlowForGroupsOfNodes(obj, conductorType, nodeset1, nodeset2, timestep) %
        drawGroupHeatFlow(obj, conductorType, nodes1, nodes2, saveFlag)
        
        [QS, QA, QE] = getEnvironmentalFluxesSumForOneSetOfNodes(obj, nodeset)
        drawEnvironmentalFluxesSum(obj, nodes, saveFlag)
        
        [QI, QR] = getUnitHeaterFluxesSumForOneSetOfNodes(obj, nodeset)
        drawUnitHeaterFluxesSum(obj, nodes, saveFlag)
        
        logical = isConductorDataConstant(obj, conductorType) %
        
        runSelfDiagnostics(obj) %
        showEsatanConstants(obj) %
        
        [temperatureRanges, details] = getTemperatureRanges(obj, nodeset) %
        generateTemperatureRangesReport(obj, nodes, limit, saveFlag) %
        
        [nodesNotAssigned] = getNotAssignedNodes(obj, nodes) %
        [nodesRepeated] = getRepeatedNodes(obj, nodes) %
        
        drawHeatFlowBalanceForOneSetOfNodes(obj, nodes, nodesRowNumber, saveFlag) %

    end
    methods (Access = private)
        loadDataFromTMD(obj) %
        line = numbersToOneLine(obj, array) %
        
        indexNode = getNodeIndex(obj, node) %
        indexConductor = getConductorIndexByNodeIndexes(obj, conductorType, indexNode1, indexNode2) %
        indexConductor = getConductorIndexByNodes(obj, conductorType, node1, node2) %
        
        temperature = getTemperatureForNodeIndex(obj, indexNode, timestep) %
        conductance = getConductanceForConductorIndex(obj, conductorType, indexConductor, timestep) %
        
        conductorIndexes = getConductorIndexesForSetsOfNodeIndexes(obj, conductorType, indexNodes1, indexNodes2) %
        heatFlow = calculateHeatFlow(obj, conductorType, temperature1, temperature2, conductance) %
    end
    
end