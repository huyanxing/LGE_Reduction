for i = 1:length(tline2)
    temp = str2num(tline2{i});
    data(i,:) = temp(length(temp)-6:end)
    clear temp
end
save('household_power_consumption.mat',data)