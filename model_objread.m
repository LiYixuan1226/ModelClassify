%读取数字模型的点面信息
function [point,fface]=model_objread(model_path)

% 从obj文件中读取点和面片的信息
% 本公式针对来自******modelnet*********数据库的obj文件进行处理


fid=fopen(model_path,'r');%打开数字模型文件
Data_point=textscan(fid,'%s%n%n%n','HeaderLines',0);%读入数字模型点坐标数据
length_point=cellfun('length',Data_point(3));%获取点坐标数据数量
%Data_point{1}(length_point+1,:)=[];%清空无用数据

%% 将元胞转换数据格式
Att=char(Data_point{1});
col1=double(Data_point{2});
col2=double(Data_point{3});
col3=double(Data_point{4});

%% 判断点的数量   最终的数量是i-1
i= 1;
while Att(i)==Att(1)
    i =i+1;
end
point=zeros(i-1,3);%生成存储点云数据的矩阵空间
point(:,1)=col1(1:i-1);%第一列为x轴坐标
point(:,2)=col2(1:i-1);%第二列为y轴坐标
point(:,3)=col3(1:i-1);%第三列为z轴坐标


%% 完成点位信息读取
% -------------------------------------------------------------------------------------------------------------------------------------------
% Data_face=textscan(fid,'%s%n%n%n','HeaderLines',1);%读入数字模型线面信息数据
% length_face=cellfun('length',Data_face(3));%获取线面数据数量
% Data_face{1,2}(length_face+1,:)=[];%清空无用数据
% sstr=char(Data_face{1,1}(:,1));%获取线面信息字母标识

fface=zeros(length_point-i+1,3);
fface(:,1)=col1(i:length_point);%存储三角面片第一个点
fface(:,2)=col2(i:length_point);%存储三角面片第二个点
fface(:,3)=col3(i:length_point);%存储三角面片第三个点
% for i=1:length_face%用于移除非三角面片数据
%     if sstr(i)=='l'%数据格式为面信息'f'，随后为线信息'l'，此处搜索第一个线标识
%     fface(i:end,:)=[];%清空第一个线数据及其后的数据
%     break;%跳出循环
%     end
% end
length_face=length_point-i+1;
%disp(2)
if length_face>50000
    for i=1:length_face
        a=sqrt((point(fface(i,1),1)-point(fface(i,2),1))^2+(point(fface(i,1),2)-point(fface(i,2),2))^2+(point(fface(i,1),3)-point(fface(i,2),3))^2);
        b=sqrt((point(fface(i,1),1)-point(fface(i,3),1))^2+(point(fface(i,1),2)-point(fface(i,3),2))^2+(point(fface(i,1),3)-point(fface(i,3),3))^2);
        c=sqrt((point(fface(i,2),1)-point(fface(i,3),1))^2+(point(fface(i,2),2)-point(fface(i,3),2))^2+(point(fface(i,2),3)-point(fface(i,3),3))^2);
        fface(i,4)=a+b+c;
        %fface(i,4)=(a+b+c)*(a+b-c)*(a+c-b)*(b+c-a)/4;
    end
else
    for i=1:length_face
        a=sqrt((point(fface(i,1),1)-point(fface(i,2),1))^2+(point(fface(i,1),2)-point(fface(i,2),2))^2+(point(fface(i,1),3)-point(fface(i,2),3))^2);
        b=sqrt((point(fface(i,1),1)-point(fface(i,3),1))^2+(point(fface(i,1),2)-point(fface(i,3),2))^2+(point(fface(i,1),3)-point(fface(i,3),3))^2);
        c=sqrt((point(fface(i,2),1)-point(fface(i,3),1))^2+(point(fface(i,2),2)-point(fface(i,3),2))^2+(point(fface(i,2),3)-point(fface(i,3),3))^2);
        fface(i,4)=sqrt((a+b+c)*(a+b-c)*(a+c-b)*(b+c-a))/4;
    end
end
%disp(3)
for i=2:length_face
    fface(i,4)=fface(i,4)+fface(i-1,4);
end

fclose(fid);