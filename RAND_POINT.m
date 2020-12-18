function rand_p=RAND_POINT(model_path,num)

%从obj的点和面片信息中随机采样
%rand_p是随机采样点的集合
%num为设置的采样点数量

[point,fface]=model_objread(model_path);

area=max(fface(:,4));%表面总面积
fface_length=length(fface(:,1));%三角网格数量
rand_p=zeros(num,3);%存储输出点
for i=1:num
    a=area*rand;
    x=1;
    y=fface_length;
    while y-x>1%二分法寻找大于a的最小值
        z=round((x+y)/2);
        if fface(z,4)>a
            y=z;
        else x=z;
        end
    end
    if a<fface(1,4)%防止点落在第一个三角网格内
        result=1;
    else result=y;
    end
    diff=fface(result,4)-a;%面积差值
    if result>1
        proportion=sqrt(diff/(fface(result,4)-fface(result-1,4)));
    else  proportion=sqrt(diff/fface(result,4));
    end
    point_a=point(fface(result,1),:);%网格三个顶点
    point_b=point(fface(result,2),:);
    point_c=point(fface(result,3),:);
    point_l=point_b*proportion+point_a*(1-proportion);%构建等比三角形
    point_m=point_c*proportion+point_a*(1-proportion);
    ran=rand;
    rand_p(i,:)=point_l*ran+point_m*(1-ran);%从等比三角底边中随机出输出点
end