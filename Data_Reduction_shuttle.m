clc;
clear;
load('./data/shuttle_data.mat');
data = shuttle;
clear shuttle;
features = data(:,1:9);
label = data(:,10);
pcamarker = 1;
dimension = 5;
if pcamarker == 1
    coeff = pca(features);
    mapping = coeff(:,1:dimension);
    features_trans = features*mapping;
else
    features_trans = features;
end
    
data = [features_trans,label];
reduce_set = GEL_Reduction(data,10,0.5); 