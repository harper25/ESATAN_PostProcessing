function heatFlow = calculateHeatFlow(obj, conductorType, temperature1, temperature2, conductance)
%calculateHeatFlow The function calculates heat flow for a specified type
%of conductor.
%   To calculate heat flow in GR two constants defined in class file are
%   used: absoluteTemperature and StefanBolzmann.

switch conductorType
    case 'GL'
        heatFlow = conductance .* (temperature1 - temperature2);
    case 'GR'
        heatFlow = conductance .* obj.StefanBoltzmann .* ((temperature1 + obj.absoluteTemperature).^4 - (temperature2 + obj.absoluteTemperature).^4);
    otherwise
        error(['Invalid conductor type: "', conductorType,'". Please, type in: "GL" or "GR" as a first argument.']);
end

end

