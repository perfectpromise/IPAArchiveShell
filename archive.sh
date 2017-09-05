#!/bin/bash

#工程路径
Project_Path="/Users/Jfz/Desktop/work/XXX/src/2.0"

#工程名字(Target名字)
Target_Name="XXX"

#workspace的名字
Workspace_Name="XXX"

#配置环境，Release或者Debug,默认Release
Configuration="Release"

#加载各个版本的plist文件，这两个版本的无需修改任何内容
DEVELOPExportOptionsPlist=./DEVELOPExportOptionsPlist.plist
AppStoreExportOptionsPlist=./AppStoreExportOptionsPlist.plist

DEVELOPExportOptionsPlist=${DEVELOPExportOptionsPlist}
AppStoreExportOptionsPlist=${AppStoreExportOptionsPlist}


echo "~~~~~~~~~~~~选择打包方式(输入序号)~~~~~~~~~~~~~~~"
echo "		1 Develop"
echo "		2 AppStore"

# 读取用户输入并存到变量里
read parameter
sleep 0.5
method="$parameter"

# 判读用户是否有输入
if [ -n "$method" ]
then
if [ "$method" = "1" ]
then
#develop脚本
#构建archive
xcodebuild -workspace $Project_Path/$Workspace_Name.xcworkspace -scheme $Target_Name -configuration $Configuration -archivePath $Target_Name-develop.xcarchive clean archive build

#生成ipa
xcodebuild  -exportArchive -archivePath $Target_Name-develop.xcarchive -exportOptionsPlist ${DEVELOPExportOptionsPlist} -exportPath ./$Target_Name-develop

elif [ "$method" = "2" ]
then
#appstore脚本
#构建archive
xcodebuild -workspace $Project_Path/$Workspace_Name.xcworkspace -scheme $Target_Name -configuration $Configuration -archivePath $Target_Name-appstore.xcarchive clean archive build

#生成ipa
xcodebuild  -exportArchive -archivePath $Target_Name-appstore.xcarchive -exportOptionsPlist ${AppStoreExportOptionsPlist} -exportPath ./$Target_Name-appstore

else
echo "参数无效...."
exit 1
fi
fi

