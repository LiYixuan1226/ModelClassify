import os
from random import shuffle
import numpy as np

path = os.path.abspath(os.curdir)
file_list = os.listdir(path)
data_file = []
max_dist = 0
min_dist = 1000
distance_data = []
distribution = []

#读取所有txt
for file in file_list:
    if file.endswith("txt"):
        data_file.append(file)


def distance(file_name):
    global max_dist
    global min_dist
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
    if max(dist) > max_dist:
        max_dist = max(dist)
    if min(dist)< min_dist:
        min_dist = min(dist)
    print(len(dist), max(dist), min(dist))
    return dist


for file in data_file:
    distance_data.append(distance(file))

print(len(distance_data))
print(max_dist)
print(min_dist)


def distribute():
    group_dist = (max_dist-min_dist)/1024
    for dist in distance_data:
        dist_num = np.zeros((1024,), dtype=np.int)
        for d in dist:
            num_d = 0
            i = min_dist
            min = min_dist
            max = min_dist + group_dist
            while min_dist <= i <= max_dist:
                if max > d >= min:
                    dist_num[num_d] = dist_num[num_d]+1
                    break
                elif d == max_dist:
                    dist_num[1023] = dist_num[1023]+1
                    break
                else:
                    num_d = num_d+1
                    i = i+group_dist
                    min = min+group_dist
                    max = max+group_dist
        distribution.append(dist_num)


distribute()
np.savetxt('data.csv', distribution, delimiter=',')

