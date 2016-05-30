function [Reduced_Dataset] = GEL_Reduction(Raw_data,Q,Q_degree)
%GEL_DATA_REDUCTION Summary of this function goes here
%   Detailed explanation goes here
[sample_num,feature_num] = size(Raw_data);
feature_num = feature_num-1;
label = Raw_data(:,feature_num+1);
features = Raw_data(:,1:feature_num);
Formatdata = [label,features];
up_bound = max(features,[],1);
low_bound = min(features,[],1);
%%
GEL_index = zeros(size(features));
for i = 1:feature_num
    Q_distance = (up_bound(i)-low_bound(i))/Q;
    %Q_interval = linspace(up_bound(i),low_bound(i),Q);
    for j = 1:sample_num
        GEL_Matrix(j,i) = ceil((features(j,i)-low_bound(i))/Q_distance);
    end
end

disp('finish gride');

[UniqueC,IA,IC] = unique(GEL_Matrix,'rows');

Total_num_Q_zone = length(IA);

for i = 1:Total_num_Q_zone

    Q_zone_index{i} = find(IC == i);
    Q_zone_sample{i} = Raw_data(Q_zone_index{i},:);
    Points{i} = QPoint(Q_zone_sample{i}, Q_degree);
    disp(i)
end

Reduced_Dataset = cell2mat(Points');
end

