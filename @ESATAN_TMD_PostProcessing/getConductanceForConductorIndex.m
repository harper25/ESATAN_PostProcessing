function conductance = getConductanceForConductorIndex(obj, conductorType, indexConductor, timestep)
%getConductanceForConductorIndex The function returns a conductance for a
%specified node index.
%   The output is a complete flow of conductance in time. If a timestep is
%   specified, the output is a single conductance for this timestep.

switch conductorType
    case 'GL'
        if (nargin == 4) && (~isempty(timestep))
            conductance = obj.conductorDataGL(indexConductor, timestep)';
        else
            conductance = obj.conductorDataGL(indexConductor, :)';
        end
    case 'GR'
        if (nargin == 4) && (~isempty(timestep))
            conductance = obj.conductorDataGR(indexConductor, timestep)';
        else
            conductance = obj.conductorDataGR(indexConductor, :)';
        end
    otherwise
        error(['Invalid conductor type: "', conductorType,'". Please, type in: "GL" or "GR" as a first argument.']);
end

end

