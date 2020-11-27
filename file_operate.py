import os

# 获取当前目录位置
BASE_DIR = os.path.abspath(os.curdir)
path = os.path.join(BASE_DIR) + "\models"  # 模型放在models文件夹里
File_List = os.listdir(path)
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
            line = line.strip('v')
            fdata.write(line)
    fdata.close()


for files in File_List:
    read_coordinate(path + "\\"+files)
