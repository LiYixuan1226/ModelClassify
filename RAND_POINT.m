function rand_p=RAND_POINT(model_path,num)

%��obj�ĵ����Ƭ��Ϣ���������
%rand_p�����������ļ���
%numΪ���õĲ���������

[point,fface]=model_objread(model_path);

area=max(fface(:,4));%���������
fface_length=length(fface(:,1));%������������
rand_p=zeros(num,3);%�洢�����
for i=1:num
    a=area*rand;
    x=1;
    y=fface_length;
    while y-x>1%���ַ�Ѱ�Ҵ���a����Сֵ
        z=round((x+y)/2);
        if fface(z,4)>a
            y=z;
        else x=z;
        end
    end
    if a<fface(1,4)%��ֹ�����ڵ�һ������������
        result=1;
    else result=y;
    end
    diff=fface(result,4)-a;%�����ֵ
    if result>1
        proportion=sqrt(diff/(fface(result,4)-fface(result-1,4)));
    else  proportion=sqrt(diff/fface(result,4));
    end
    point_a=point(fface(result,1),:);%������������
    point_b=point(fface(result,2),:);
    point_c=point(fface(result,3),:);
    point_l=point_b*proportion+point_a*(1-proportion);%�����ȱ�������
    point_m=point_c*proportion+point_a*(1-proportion);
    ran=rand;
    rand_p(i,:)=point_l*ran+point_m*(1-ran);%�ӵȱ����ǵױ�������������
end