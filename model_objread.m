%��ȡ����ģ�͵ĵ�����Ϣ
function [point,fface]=model_objread(model_path)

% ��obj�ļ��ж�ȡ�����Ƭ����Ϣ
% ����ʽ�������******modelnet*********���ݿ��obj�ļ����д���


fid=fopen(model_path,'r');%������ģ���ļ�
Data_point=textscan(fid,'%s%n%n%n','HeaderLines',0);%��������ģ�͵���������
length_point=cellfun('length',Data_point(3));%��ȡ��������������
%Data_point{1}(length_point+1,:)=[];%�����������

%% ��Ԫ��ת�����ݸ�ʽ
Att=char(Data_point{1});
col1=double(Data_point{2});
col2=double(Data_point{3});
col3=double(Data_point{4});

%% �жϵ������   ���յ�������i-1
i= 1;
while Att(i)==Att(1)
    i =i+1;
end
point=zeros(i-1,3);%���ɴ洢�������ݵľ���ռ�
point(:,1)=col1(1:i-1);%��һ��Ϊx������
point(:,2)=col2(1:i-1);%�ڶ���Ϊy������
point(:,3)=col3(1:i-1);%������Ϊz������


%% ��ɵ�λ��Ϣ��ȡ
% -------------------------------------------------------------------------------------------------------------------------------------------
% Data_face=textscan(fid,'%s%n%n%n','HeaderLines',1);%��������ģ��������Ϣ����
% length_face=cellfun('length',Data_face(3));%��ȡ������������
% Data_face{1,2}(length_face+1,:)=[];%�����������
% sstr=char(Data_face{1,1}(:,1));%��ȡ������Ϣ��ĸ��ʶ

fface=zeros(length_point-i+1,3);
fface(:,1)=col1(i:length_point);%�洢������Ƭ��һ����
fface(:,2)=col2(i:length_point);%�洢������Ƭ�ڶ�����
fface(:,3)=col3(i:length_point);%�洢������Ƭ��������
% for i=1:length_face%�����Ƴ���������Ƭ����
%     if sstr(i)=='l'%���ݸ�ʽΪ����Ϣ'f'�����Ϊ����Ϣ'l'���˴�������һ���߱�ʶ
%     fface(i:end,:)=[];%��յ�һ�������ݼ���������
%     break;%����ѭ��
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