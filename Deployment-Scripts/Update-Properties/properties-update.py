from jproperties import Properties
import os
import fileinput
import sys
#Make sure to Install the jproperties using = pip install jproperties
configs = Properties()

prop_path= str(sys.argv[1])
rootdir= str(sys.argv[2])

#prop_path=r"/home/runner/work/dataengineering-devops/dataengineering-devops/DataFactory/npr-app-config.properties"
#rootdir = r'/home/runner/work/dataengineering-devops/dataengineering-devops/DataFactory/'

def update_configValue(rootfilepath,key,value):

    with fileinput.FileInput(rootfilepath, inplace=True) as file:
        for line in file:
            if "job_nm" in line:
                print(line.replace(key, value.lower()), end='')
            else:
                print(line.replace(key, value), end='')
    
    newpathName=rootfilepath.replace(key,value)
    print("New Path Name",newpathName)
    if newpathName != rootfilepath:
        os.rename(rootfilepath,newpathName)  
        
def update_Parameter(rootpath,key,value):

    for subdir, dirs, files in os.walk(rootpath):
        for file in files:
            print(os.path.join(subdir, file))
            update_configValue(os.path.join(subdir, file),key,value)

with open(prop_path, 'rb') as config_file:
    configs.load(config_file)
 
items_view = configs.items()
list_keys = []
 
for item in items_view:
    list_keys.append(item[0])
    print("the Key is",item[0])
    print("The Key Value is",item[1].data)
    update_Parameter(rootdir,item[0],item[1].data)
