真机调试的步骤:
1.注册成为苹果开发者(99$)
2.登陆苹果开发者主页
https://developer.apple.com/membercenter/index.action
3.点击
Certificates, Identifiers & Profiles

4.点击Certificates
>点击左上角的加号

>选择iOS App Development >点击下一步
>直接点击下一步
>Upload CSR file.
> 找到电脑上得钥匙串访问, 然后点击:

> 输入证书信息(随便输入), 最重要是选中存储到磁盘



>进过以上步骤之后就会的到一个CertificateSigningRequest.certSigningRequest文件
>将该文件上传到开发者中心, 点击下一步会得到我们的cer证书

5.注册bundle ID, 告诉苹果哪一个APP需要调试
>点击Identifiers >点击加号
> 有两个选项可以填写bundle ID,
Explicit App ID: 填写一个精确的ID, 如果需要做远程推送/游戏中心/内购等功能, 必须填写准确的bundle ID,

/ Wildcard App ID: 填写一个模糊的ID, 如果不需要做远程推送/游戏中心/内购等功能, 直接填写模糊的bundle ID即可, 这样可以提升我们的开发效率

>一直下一步就OK


6.点击Devices, 告诉苹果那一台设备可以进行真机调试
>点击加号添加设备
>点击window, 获取设备的UDID


>填写设备的描述和设备的UDID注册设备
>注意: 普通的开发者账号, 一个账号只能注册100台设备, 苹果并没有提供删除设备ID的功能,仅仅只能禁止某台设备调试, 被禁止的设备会在下一次付费时被清空(第二年)

7.生成描述文件, 告诉系统哪一台电脑的哪一个应用程序可以在哪一台设备上运行
>点击Provisioning Profiles, 点击加号
>一直下一步, 告诉系统哪一台电脑/哪一个APP/哪一个设备可以调试
>得到HM2Test.mobileprovision文件

8.安装配置好得cer证书和HM2Test.mobileprovision文件到电脑和手机
>注意检查证书的状态, 必须是绿色才可以调试
>注意, 真机的系统版本必须比Xcode中的部署版大






应用程序打包  == ipa == 安装在手机上(注意并不是所有的ipa都可以随意安装)
>如果想让用户可以安装ipa必须在打包程序的时候说清楚 哪一个应用程序可以安装到哪一台设备上

>要想打包,必须成为苹果开发者



>如果想要APP能够接收远程推送, 那么App的Bundle ID必须是完整的

