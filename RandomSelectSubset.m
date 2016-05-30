function [ Data_subset ] = RandomSelectSubset( Data,N )
%RANDOMSELECTSUBSET Summary of this function goes here
%   Detailed explanation goes here

[Sample_num,Feature_num] = size(Data);

marks = randperm(Sample_num,N);
Data_subset = Data(marks,:);

end

