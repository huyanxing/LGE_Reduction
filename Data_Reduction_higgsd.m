clc;
clear;
load('./data/SUSYData.mat');
data = SUSYData;
clear SUSYData;
features = data(:,2:19);
label = data(:,1);
pcamarker = 0;
dimension = 9;
if pcamarker == 1
    coeff = pca(features);
    mapping = coeff(:,1:dimension);
    features_trans = features*mapping;
else
    features_trans = features;
end
    
data = [features_trans,label];
k=1
for i=2:2:8
reduce_set_full_features{i} = GEL_Reduction(data,i,0.5);
k=k+1;
end