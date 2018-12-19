function showEsatanConstants(obj)
%showEsatanConstants The function displays constants saved in *.tmd file by
%ESATAN.
%   The constants are: absolute temperature and Stefan Bolzmann constant.
%   These values are not used in post-processing. Instead, default ThermNV
%   constants are used, which slightly differ from Esatan ones.

dataset = '/AnalysisSet1/';
st = h5readatt(obj.path, dataset, 'StefanBoltzmann');
at = h5readatt(obj.path, dataset, 'TAbs');
disp('Esatan constants: ')
fprintf('Stefan Boltzmann:       %.40f\n', st)
fprintf('Absolute Temperature: %.40f\n', at)

end

