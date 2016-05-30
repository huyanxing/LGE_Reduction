function [QPoints] = QPoint(Data, Q_Degree)
%QPOINT Summary of this function goes here
%   Detailed explanation goes here
[sample_num,feature_num] = size(Data);
feature_num = feature_num-1;
label = Data(:,feature_num+1);
features = Data(:,1:feature_num);

if length(unique(label))== 1
   label_QPoint = label(1);
   features_Qpoint = mean(features,1);
else
   STA = tabulate(label);
   Q_Pencentage = max(STA(:,3));
   i_cluster = 1;
   while 1  
       Most_label = STA(find(STA(:,3) == max(STA(:,3))),1);
       label_QPoint(i_cluster) = Most_label(1);
       features_Qpoint(i_cluster,:) = mean(features(find(label == label_QPoint(i_cluster) ),:),1);
       if Q_Pencentage >=  (Q_Degree*100)
           break;
       else
           features_left = features(find(label ~= label_QPoint(i_cluster)),:);
           label_left = label(find(label ~= label_QPoint(i_cluster)),:);
           STA_left = STA(find(STA(:,1) ~= label_QPoint(i_cluster)),:);
           
           features = features_left;
           label = label_left;
           STA = STA_left;
           Q_Pencentage = Q_Pencentage + max(STA(:,3));
           i_cluster = i_cluster + 1;       
       end 
   end    
end
   QPoints=[features_Qpoint,label_QPoint'];  
end

