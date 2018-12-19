function logical = isConductorDataConstant(obj, conductorType)
%ifConductorDataConstant The function checks if all rows in specified 
%'GL' or 'GR' conductorData are constant, which means that conductances
%do not vary in time.
%   Output is a logical true or false (1/0).

if (nargin == 1)
    error('Invalid conductor type. Please, type in: "GL" or "GR" as a first argument.');
end

logical = true;

switch conductorType
    case 'GL'
        for i = 1:size(obj.conductorDataGL,2)
            if (~obj.conductorDataGL(:,i) == obj.conductorDataGL(:,1))
                logical = false;
                break
            end
        end     
    case 'GR'
        for i = 1:size(obj.conductorDataGR,2)
            if (~obj.conductorDataGR(:,i) == obj.conductorDataGR(:,1))
                logical = false;
                break
            end
        end
    otherwise
        error(['Invalid conductor type: "', conductorType,'". Please, type in: "GL" or "GR" as a first argument.']);
end

end

