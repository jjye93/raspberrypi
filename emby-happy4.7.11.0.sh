#!/bin/bash
read -p "本脚本适用于emby群辉4.7.11.0版本，确认是否安装？,请输入1安装,退出请输入0: " para
if [ $para == "1" ]
then
	echo "----------------继续----------------"
else
	echo "----------------退出----------------"
    exit
fi


tar -xf emby-happy.tar
cp ./Emby.Web.dll   /opt/emby-server/system/Emby.Web.dll 
cp ./MediaBrowser.Model.dll  /opt/emby-server/system/MediaBrowser.Model.dll  
cp ./connectionmanager.js /opt/emby-server/system/dashboard-ui/modules/emby-apiclient/connectionmanager.js  
cp ./embypremiere.js /opt/emby-server/system/dashboard-ui/embypremiere/embypremiere.js  
cp ./Emby.Server.Implementations.dll /opt/emby-server/system/Emby.Server.Implementations.dll  


rm -rf connectionmanager.js
rm -rf Emby.Server.Implementations.dll
rm -rf Emby.Web.dll
rm -rf embypremiere.js
rm -rf MediaBrowser.Model.dll

echo "-------------------全部完成-------------------"
echo "运行后重启套件,清除浏览器缓存,填写任意激活码."
