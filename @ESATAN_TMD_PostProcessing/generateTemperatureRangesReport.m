function generateTemperatureRangesReport(obj, nodes, limit, saveFlag)
%generateTemperatureRangesReport The function generates temperature ranges
%report in Excel.
%   As an input a cell structure is used.

%% Calculating temperature ranges

[temperatureRanges, details] = getTemperatureRanges(obj, nodes);

%% Creating link to Excel object and table structure

e = actxserver('Excel.Application');

eWorkbook = e.Workbooks.Add;
e.Visible = 1;

e.Worksheets.Item(1).Name = 'TEMP_REPORT';

% eSheets = e.ActiveWorkbook.Sheets;
% eSheet1 = eSheets.get('Item',1);
% eSheet1.Activate

% Merge Cells
eActivesheetRange = e.Activesheet.get('Range', 'A1:A2');
eActivesheetRange.MergeCells = 1;
eActivesheetRange.Value = 'Part name';

eActivesheetRange = e.Activesheet.get('Range', 'B1:B2');
eActivesheetRange.MergeCells = 1;
eActivesheetRange.Value = 'min/max';

eActivesheetRange = e.Activesheet.get('Range', 'C1:D1');
eActivesheetRange.MergeCells = 1;
eActivesheetRange.Value = sprintf('Temperature [%cC]', char(176));

eActivesheetRange = e.Activesheet.get('Range', 'C2');
eActivesheetRange.Value = 'Calculated';

eActivesheetRange = e.Activesheet.get('Range', 'D2');
eActivesheetRange.Value = 'Design';

eActivesheetRange = e.Activesheet.get('Range', 'E1:E2');
eActivesheetRange.MergeCells = 1;
eActivesheetRange.Value = sprintf('Limit [%cC]', char(176));

eActivesheetRange = e.Activesheet.get('Range', 'F1:F2');
eActivesheetRange.MergeCells = 1;
eActivesheetRange.Value = 'Nodes';

eActivesheetRange = e.Activesheet.get('Range', 'G1:G2');
eActivesheetRange.MergeCells = 1;
eActivesheetRange.Value = 'Time [s]';

% Cell format
eActivesheetRange = e.Activesheet.get('Range', 'A1:G2');
eActivesheetRange.HorizontalAlignment = 3;
eActivesheetRange.VerticalAlignment = 2;
eActivesheetRange.Font.Bold = 1;
eActivesheetRange.Interior.ColorIndex = 15;

%% Populating Excel file with data

rounding = 2;

for i = 1:size(nodes,1)
    
    row1 = num2str(i*2 + 1);
    row2 = num2str(i*2 + 2);
    
    eActivesheetRange = e.Activesheet.get('Range', ['A', row1, ':A', row2]);
    eActivesheetRange.MergeCells = 1;
    eActivesheetRange.Value = strrep(nodes{i,1},' ','_');
    eActivesheetRange.Font.Bold = 1;
    
    eActivesheetRange = e.Activesheet.get('Range', ['B', row1]);
    eActivesheetRange.Value = 'min';
    
    eActivesheetRange = e.Activesheet.get('Range', ['B', row2]);
    eActivesheetRange.Value = 'max';
    
    eActivesheetRange = e.Activesheet.get('Range', ['C', row1]);
    eActivesheetRange.Value = sprintf('%.2f', round(temperatureRanges(i,1)*10^rounding)/10^rounding);
    
    eActivesheetRange = e.Activesheet.get('Range', ['C', row2]);
    eActivesheetRange.Value = sprintf('%.2f', round(temperatureRanges(i,2)*10^rounding)/10^rounding);
    
    eActivesheetRange = e.Activesheet.get('Range', ['D', row1]);
    eActivesheetRange.Value = sprintf('%.2f', round(temperatureRanges(i,1)*10^rounding)/10^rounding + limit);
    
    eActivesheetRange = e.Activesheet.get('Range', ['D', row2]);
    eActivesheetRange.Value = sprintf('%.2f', round(temperatureRanges(i,2)*10^rounding)/10^rounding + limit);   
    
    eActivesheetRange = e.Activesheet.get('Range', ['E', row1, ':E', row2]);
    eActivesheetRange.MergeCells = 1;
    eActivesheetRange.Value = 'n/a';
    
    eActivesheetRange = e.Activesheet.get('Range', ['F', row1]);
    eActivesheetRange.Value = obj.numbersToOneLine(details{i,1});
    
    eActivesheetRange = e.Activesheet.get('Range', ['F', row2]);
    eActivesheetRange.Value = obj.numbersToOneLine(details{i,3});
    
    eActivesheetRange = e.Activesheet.get('Range', ['G', row1]);
    eActivesheetRange.Value = obj.numbersToOneLine(details{i,2});
    
    eActivesheetRange = e.Activesheet.get('Range', ['G', row2]);   
    eActivesheetRange.Value = obj.numbersToOneLine(details{i,4});
    
end

%% Formatting Excel table

% Center alignment
eActivesheetRange = e.Activesheet.get('Range', ['A3:G', row2]);
eActivesheetRange.HorizontalAlignment = 3;
eActivesheetRange.VerticalAlignment = 2;

% Gray color
Range1 = e.Range(['A3:B', row2]);
Range1.Interior.ColorIndex = 15;

% Create solid borders in desired locations
Range1 = e.Range(['A1:G', row2]);
set(get((Range1.borders),'item',1),'linestyle',1);
set(get((Range1.borders),'item',2),'linestyle',1);
set(get((Range1.borders),'item',3),'linestyle',1);
set(get((Range1.borders),'item',4),'linestyle',1);

% Columns autofit
e.Range('A1:G1').EntireColumn.AutoFit;

if (e.Range('C1').ColumnWidth > e.Range('D1').ColumnWidth)
    e.Range('D1').ColumnWidth = e.Range('C1').ColumnWidth;
else
    e.Range('C1').ColumnWidth = e.Range('D1').ColumnWidth;
end


%% Saving

if (nargin == 4) && (saveFlag == 1)
    if (~exist('excels','dir'))
        mkdir excels
    end
    excelOutputFileName = [pwd,'\excels\','TEMP_REPORT_', datestr(now, 'yyyy-mm-dd_HH-MM-SS'), '.xlsx'];
    SaveAs(eWorkbook,excelOutputFileName)
else
    warning('Excel report was not saved. Use: generateTemperatureRangesReport(nodes, limit, 1) to save.')
end    

%% Closing link

% Quit(e)
delete(e)


end

