function line = numbersToOneLine(~, array)
%numbersToOneLine Converts array to string that can be written in Excel
%file.
%   Separates numbers with ','.

line = sprintf('%.0f', array(1));

if (length(array) > 1)

    for i = 2:length(array)
        line = [line, ', ', sprintf('%.0f', array(i))];
    end
end

end

