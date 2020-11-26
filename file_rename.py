import os

# 获取当前目录位置
BASE_DIR = os.path.abspath(os.curdir)
path = os.path.join(BASE_DIR) + "\models"  # 模型放在models文件夹里
print(path)


def rename(file_path):
    i = 0
    File_List = os.listdir(path)
    '遍历所有文件'
    for files in File_List:
        print(files)
        if files.endswith("obj"):
            old_name = os.path.join(path, files)
            new_name = os.path.join(path, files.replace("obj", "txt"))
            os.rename(old_name, new_name)
            i += 1


rename(path)
