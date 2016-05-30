
clc;
clear;
addpath('/home/remy/Codes/MatlabWorkfile/LGE_sample_reduction/libsvm-3.21/matlab/')
load 'data.mat'
 n = length(whos('-file','data.mat'));
    fid=fopen('SVMresults_SUSY2.txt','a+');
         %fprintf(fid,'newsession:\n');
    
 for i=1:2:n
     k = i+1;
     paircount = 1;
     eval(['ProceedData_ini = data',num2str(i),';']) 
     eval(['ProceedData_red = data',num2str(k),';'])
     [Trset,Teset] = NCrossPart(ProceedData_ini,i*10);
         Trainingset_ini = Trset{1};
     Trainingset_red = ProceedData_red;
     Testingset = Teset{1};
     clear ('ProceedData_ini','ProceedData_red','Trset','Teset')
     eval(['clear data',num2str(i)]) 
     eval(['clear data',num2str(i)])
     feature_num = size(Testingset,2)-1;
%     [Tr_t_ini, Te_t_ini, Tr_Acc_ini, Te_Acc_ini] = elm(Trainingset_ini, Testingset,1,2*feature_num,'sig')
%     [Tr_t_red, Te_t_red, Tr_Acc_red, Te_Acc_red] = elm(Trainingset_red, Testingset,1,2*feature_num,'sig')
     
      LabelTrain_ini = Trainingset_ini(:,end);
      FeatureTrain_ini = Trainingset_ini(:,1:size(Trainingset_ini,2)-1);
%      
      LabelTrain_red = Trainingset_red(:,end);
      FeatureTrain_red = Trainingset_red(:,1:size(Trainingset_red,2)-1);
%      
      LabelTesting = Testingset(:,end);
      FeatureTesting = Testingset(:,1:size(Testingset,2)-1);
%   %%    
       disp('start training')
      t1=cputime

      SVMstructure_ini = svmtrain(LabelTrain_ini,FeatureTrain_ini);
      Tr_t_ini = cputime-t1
      disp('start testing')
      if i==1
      [C,  Te_Acc_vec_ini1, dec_values_ini] = svmpredict(LabelTesting, FeatureTesting, SVMstructure_ini)
      else
      [C,  Te_Acc_vec_ini2, dec_values_ini] = svmpredict(LabelTesting, FeatureTesting, SVMstructure_ini)    
      Te_Acc_ini = sum(LabelTesting~= C)/length(C)
     end
  %%
     disp('start training')
     t2=cputime;
     
     SVMstructure_red = svmtrain(LabelTrain_ini,FeatureTrain_ini);
     Tr_t_red = cputime-t2 
     disp('start testing')
     if i==1
     [C,  Te_Acc_vec_red1, dec_values_red] = svmpredict(LabelTesting, FeatureTesting, SVMstructure_red)
     else
     [C,  Te_Acc_vec_red2, dec_values_red] = svmpredict(LabelTesting, FeatureTesting, SVMstructure_red)
     end
     C = svmclassify(SVMstructure_red,FeatureTesting,'showplot',true);
     Te_Acc_red = sum(LabelTesting~= C)/length(C)
  
%      fprintf(fid,'Results for this pair:\n');
%      fprintf(fid,'for the initial set \n');
%      fprintf(fid,'tr_time is %f, te_time is %f, tr_acc is %f, te_acc is %f\n',Tr_t_ini, Te_t_ini, Tr_Acc_ini, Te_Acc_ini);
%      fprintf(fid,'for the reduced set \n');
%      fprintf(fid,'tr_time is %f, te_time is %f, tr_acc is %f, te_acc is %f\n',Tr_t_red, Te_t_red, Tr_Acc_red, Te_Acc_red);
     
     fid=fopen('SVMresults.txt','a+');
     fprintf(fid,'Results for this pair:\n');
     fprintf(fid,'for the initial set \n');
     fprintf(fid,'tr_time is %f, te_acc is %f\n',Tr_t_ini,  Te_Acc_ini);
     fprintf(fid,'for the reduced set \n');
     fprintf(fid,'tr_time is %f, te_acc is %f\n',Tr_t_red, Te_Acc_red);
     %fclose(fid);

 end
 fclose(fid);