close all

clc

path='E:/python/models/';
list=dir(fullfile(path,'*.obj'));
fileNum=size(list,1);


for k=1:fileNum
   filepath=[path,list(k).name];
   disp(filepath);
   
   datapath=strrep(filepath,'obj','txt');
   disp(datapath);
   
   model_path=filepath;
   num=10000;
   rand_p=RAND_POINT(model_path,num);

   fid = fopen(datapath,'a');
   fid = fopen(datapath,'w');
   [m,n]=size(rand_p);                      
     for i=1:1:m
       for j=1:1:n
          if j==n
            fprintf(fid,'%d\n',rand_p(i,j));
         else
           fprintf(fid,'%d ',rand_p(i,j));
          end
       end
     end 
   fclose(fid);
end

