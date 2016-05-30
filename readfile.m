fidin=fopen('household_power_consumption.txt');  
i=1
while ~feof(fidin)
    tline{i} = fgetl(fidin);
    display(tline{i})
    if isempty(tline)
        continue
    end       
    i=i+1;
end
fclose(fidin);