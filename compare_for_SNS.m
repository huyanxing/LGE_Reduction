clc;
clear;
load ('reduce_set_full_SUSY.mat')  %load the reduced data sets%
load 'data_raw_SUSY.mat';% load the initial data set%
%%
data_raw = SUSY;
reduce_datacell = reduce_set_full_SUSY;
num_feature = min(size(data_raw));
ProceedData_ini = data_raw;
%clear SkinNonSkin;
%data = SUSYData;
%clear SUSYData;
features = data_raw(:,1:num_feature-1);
label = data_raw(:,num_feature);
%ProceedData_red_cell= reduce_set_full_features_SIGG([2,4,6,8]);
%%
 fid=fopen('NNresults_SUSY.txt','a+');
     % k = i+1;
    % paircount = 1;
     %eval(['ProceedData_ini = data',num2str(i),';']) 
     %eval(['ProceedData_red = data',num2str(k),';'])
[Trset,Teset] = NCrossPart(ProceedData_ini,10);
Trainingset_ini = Trset{1};
Testingset = Teset{1};
%feature_num = size(Testingset,2)-1;
     %[Tr_t_ini, Te_t_ini, Tr_Acc_ini, Te_Acc_ini] = elm(Trainingset_ini, Testingset,1,2*feature_num,'sig')
      %fprintf(fid,'for the initial set \n');
     %fprintf(fid,'tr_time is %f, te_time is %f, tr_acc is %f, te_acc is %f\n',Tr_t_ini, Te_t_ini, Tr_Acc_ini, Te_Acc_ini);
 n=length(reduce_Datacell);
 for i=1:n     
     Trainingset_red = reduce_Datacell{i};
     num_sample_in_red = max(size(Trainingset_red));
     Trainingset_rand = RandomSelectSubset(ProceedData_ini,num_sample_in_red);

     %clear ('ProceedData_ini','ProceedData_red','Trset','Teset')
     %eval(['clear data',num2str(i)]) 
     %eval(['clear data',num2str(i)])

     [Tr_t_red{i}, Te_t_red{i}, Tr_Acc_red{i}, Te_Acc_red{i}] = elm(Trainingset_red, Testingset,1,2*num_feature,'sig');
     [Tr_t_rand{i}, Te_t_rand{i}, Tr_Acc_rand{i}, Te_Acc_rand{i}] = elm(Trainingset_rand, Testingset,1,2*num_feature,'sig');

     %fprintf(fid,'Results for this pair:\n');

     fprintf(fid,'for the reduced set with %d samples\n', length( Trainingset_red));
     fprintf(fid,'LEG reduction\n');
     fprintf(fid,'tr_time is %f, te_time is %f, tr_acc is %f, te_acc is %f\n',Tr_t_red{i}, Te_t_red{i}, Tr_Acc_red{i}, Te_Acc_red{i});
     fprintf(fid,'Rand reduction\n');
     fprintf(fid,'tr_time is %f, te_time is %f, tr_acc is %f, te_acc is %f\n',Tr_t_rand{i}, Te_t_rand{i}, Tr_Acc_rand{i}, Te_Acc_rand{i});
     fprintf(fid,'********************************************************************************************\n');
     fprintf(fid,'\n');
 end
      fclose(fid);