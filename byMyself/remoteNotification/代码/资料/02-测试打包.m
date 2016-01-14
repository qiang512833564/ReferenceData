
测试打包
1.登录apple的开发者主页:developer.apple.com

2.选择Ad Hoc生成一个ios_distribution.cer: 让电脑具备打包程序的能力

3.新建一个App ID : 方便打包哪个程序

4.利用用户设备的UDID注册设备

5.选择Ad Hoc利用ios_distribution.cer + 设备UDID + App ID --> 描述文件
(描述文件的作用:
1> 能知道在哪台电脑上, 为哪台设备打包哪个程序
2> 哪台设备需要安装打包哪个程序)

6.最终产生了3个文件
1> CertificateSigningRequest.certSigningRequest
* 包含了电脑的信息
* 发送给苹果服务器, 苹果服务器根据文件信息来生成一个电脑证书
* 生成的证书就可以让对应的电脑具备某个特殊的能力

2> ios_distribution.cer
* 打包证书
* 安装这个证书后, 电脑就具备打包程序的能力

3> nj_iphone6_news.mobileprovision
* 里面包含了3个信息:ios_distribution.cer + 设备UDID + App ID

7.安装证书和描述文件
1> ios_distribution.cer
2> nj_iphone6_news.mobileprovision

8.项目Scheme右边的设备选择iOS Device

9.点击Xcode的菜单
Product --> Archive --> Distribute --> ....Ad Hoc... --> 选择对应的描述文件

10.生成一个ipa文件,发给测试人员和客户
* ipa本质是zip
* android的安装包是APK格式,本质也是zip