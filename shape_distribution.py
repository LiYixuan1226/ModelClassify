import os
from random import shuffle

path = os.path.abspath(os.curdir)
file_list = os.listdir(path)
data_file = []

#读取所有txt
for file in file_list:
    if file.endswith("txt"):
        data_file.append(file)


def distance(file_name):
    fi = open(file, "r")
    data = []
    for line in fi:
        data.append(line)
    shuffle(data)  # 重排序
    n = 2  # 分成n组
    m = int(len(data) / n)
    data_temp = []
    for i in range(0, len(data), m):
        data_temp.append(data[i:i + m])
    data_a = data_temp[0]
    data_b = data_temp[1]
    dist = []
    for i in range(m):
        data_a_temp = [float(n) for n in data_a[i].split()]
        data_b_temp = [float(n) for n in data_b[i].split()]
        k = (data_a_temp[0]-data_b_temp[0])**2+(data_a_temp[1]-data_b_temp[1])**2+(data_a_temp[2]-data_b_temp[2])**2
        dist.append(pow(k, 0.5))
        print(pow(k, 0.5))
    print(len(dist), max(dist), min(dist))


for file in data_file:
    distance(file)
    print(file)



