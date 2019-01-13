# ESATAN_PostProcessing

The aim of this project is to provide a tool for fast post-processing of files from ESATAN analyses (\*.TMD). 
By defining user node groups and running customized script, the user is able to produce graphs and reports in a fast way with only one click after each ESATAN analysis.

## Getting Started

### Introduction
The project is written in Matlab and tested on Windows.
Full functionality - including creating reports in tables - is reached with Microsoft Excel installed locally.

### Demo
To see a demo, please run: `tmd_demo_gsgsat.m` (`GSG_SAT_POLAR.TMD` is read by default).

Thorough instructions and explanations are included in:
- demo file: `tmd_demo_gsgsat.m`,
- inside specific function files.

### Tests
The results of the tool were compared with ThermNV for several real analyses. It is advised, though, to correlate the results for the first 1-2 projects with ThermNV oneself, in order to catch bugs (if they exist).
When using the tool and comparing with ThermNV, please, make sure that both tools use the same constants. The default constants for Matlab tool are: 

|Constant | Value|
|---------|------|
|Absolute temperature| 273.15 C|
|Stefan-Bolzman| 5.6686002E-8|

## Examples

- Temperature graph:
![](/images/TEMPERATURE_SOLAR_PANEL.png)

- Heat flow graph:
![](/images/HEAT_FLOW_BALANCE_FOR_SOLAR_PANEL.png)

- Fluxes graph:
![](/images/ENVIRNMENTAL_FLUX_RADIATOR.png)

- Min/max temperature report (generated to an Excel file):
![](/images/report.JPG)

## Authors

* [harper25](https://github.com/harper25)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgements

I would like to thank everyone who gave me the opportunity to learn Thermal Analysis, as well as those, who encouraged me and helped me with understanding of ESATAN and \*.TMD files.
