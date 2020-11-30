import os
import re
import random

# 获取当前目录位置
BASE_DIR = os.path.abspath(os.curdir)
path = os.path.join(BASE_DIR) + "\models"  # 模型放在models文件夹里
path_data=os.path.join(BASE_DIR) + "\models\data"
path_distance=os.path.join(BASE_DIR) + "\models\data\distance"
File_List = os.listdir(path)
data_file_list = []
print(path)


def rename(file_path):
    i = 0
    #  遍历所有文件
    for files in File_List:
        print(files)
        if files.endswith("obj"):
            old_name = os.path.join(path, files)
            new_name = os.path.join(path, files.replace("obj", "txt"))
            os.rename(old_name, new_name)
            i += 1


rename(path)


def read_coordinate(file_name):
    fi = open(file_name, "r")
    data_file_name = file_name.replace(".txt", "Data.txt")
    fdata = open(data_file_name, "w")
    for line in fi:
        if 'v' in line and 'vt' not in line and 'vn' not in line:
            line = line.strip('v ')
            fdata.write(line)
    fdata.close()


def calculate_euclidean_distance(file_name):
    x, y, z = [], [], []
    fi = open(file_name, "r")
    for line in fi:
        tmp = re.split("\s+", line.rstrip())
        for a in tmp:
            print(a)
        x.append(tmp[0])
        y.append(tmp[1])
        z.append(tmp[2])

    N = len(x)
    test_data_time = int(0)
    test_time = int(100)  # 测试次数
    file_distance_name = file_name.replace("Data.txt", "Distance.txt")
    file = open(file_distance_name, "w")  # 创建的文件名称
    while test_data_time < test_time:
        A, B = random.sample(range(0, N - 1), 2)
        distance = (((float(x[A])) - (float(x[B]))) ** 2 + ((float(y[A])) - (float(y[B]))) ** 2 + (
                (float(z[A])) - (float(z[B]))) ** 2) ** (0.5)
        file.write(str(distance) + "\n")
        test_data_time = test_data_time + 1


for files in File_List:
    read_coordinate(path + "\\" + files)

