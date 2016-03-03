面试：
开发：试水
无经验：xmpp:试水


日期
21:svn/git
22:coredata/socket
24:xmpp 微信
25:xmpp
27:xmpp
28:xmpp

29:休息
6天时，项目实战


svn/git
svn
本地git/远程git

一、svn
1.svn:版本控制?
>防止代码丢失 n天开一个项目 回家吃谷种
>代码回退
>整合代码 多个人开发一个项目，每个做一个模块
>解决Bug冲突 版本可以查是谁改了哪个文件
>权限控制 新员工去到公司，一般都不会让你直接修改项目的代码，查看代码
•••••

2.svn在工作怎么使用
>svn分两个角色 svn服务端/svn客户端
>svn服务器 "创建一个仓库 仓库用来存放代码和接口文档
 •一般svn服务器的工作由项目经理、项目组长去做
 •公司就一个开发ios
>svn服务器的配置
 •在电脑(windows/linux/mac)安装svn服务端应用程序
 •一个项目一般对应一个仓库
 •代码放置在trunk目录
 •添加用户
 •组:把用户添加到组

总结：svn服务器 1.仓库的创建和权限的分配
  svn服务端的安装程序会由 '公司的运维人员' 工装
  •会不会在linux上安装svn服务端程序

>mac访问xp的svn服务器
http://xpIP/svn/Weibo

>客户端
 •项目经理 - 初始化项目，开发
 •开发员 -从svn服务器下载代码 开发

>项目经理初始化代码提交到svn的服务器
 •把存放代码的路径下载到本地,映射到本地路径(svn checkout 下载)
  svn服务端的命令
  usage: checkout URL[@REV]... [PATH]
  URL[@REV]:代表svn服务器的路径
  [PATH] 本地路径 ：如果不写，代表当前路径
  .svn的目录：是用来记录版本信息，不能删除
 •创建项目代码
 •把初始化的项目提交到svn服务器 "svn commit"
  '错误：Weibo is not under version control 意思是当前的Weibo文件夹不在版本控制下
 •svn st //查看文件状态 ? 代表不知道你要干 不知道你这个文件是添加的还是修改
  svn add . 把当前的目录的文件 '纳入版本控制'
 •svn commit -m "项目经理初始化项目" -m 后面的参数代理标记
  每提交一次版本到svn的服务器 svn项目的版本号会+1


>zhangsan '新起一个终端
 •把weibo的代码添加到本地
  svn checkout http://192.168.14.28/svn/Weibo/code/trunk/Weibo/ --username=zhangsan --password=123456
 •修改代码后提交服务器
  svn commit(ci) -m "实现了Person类"

  svn log 查看版本日志
  svn update 更新本地版本号

>开发新功能之前，代码要更新到服务器最新的版本
 原因：防止代码出现Bug，崩溃
 "E160024: resource out of date; try updating" -- 当前本地版本小于服务器的版本号
 "提交版本之前有个前提条件 本地版本号等于服务器版本
 把所有人开的项目功能模块更新

> 解决文件冲突 (多个人对同一个文件进行操作)
 *制造环境冲突的现象
•以zhangsan 和 lisi
 保证zhangsan 和 lisi 的当前版本号是一至
•以zhangsan修改文件提交
•lisi修改文件提交----------------

 Dog.h.mine 自己的代码修改文件
 Dog.h.r7 版本7
 Dog.h.r8 版本8
 *解决冲突 合并代码(zhangsan和lisi代码) 还是使用哪一份代码
 *告诉svn冲突已经解决

>版本回退
 lisi 为例
 回退命令:svn revert 文件名 (仅适合还没有提交到服务器)
         svn update -r 版本号 (版本已经提交)

>文件删除
 删除项目文件的时候，不能直接在文件夹删除,通过命令方式删除文件
 !号代表你操作不正确

>svn目录结构
 trunk (主杆) 当前开发程序版本
 tag 重大版本备份
 branches(分支) 备份应用程序版本 1.0 2.0

svn命令
// 下载服务器代码(文档)到本地
svn checkout remoteURL localPath

// 提交当前最新的代表到服务器
// *在公司开发当，什么时候把代表提交服务器？
// 下班 必须提交一次
// 当一个模块完成的时候，就提交一次，这个模块如果一天内完成不了，下面前必须提交
svn commit -m "标识"

//更新本地服务器的版本到最新
// 为什么更新 提前整合其它人的代码 整合一个可以运行的项目
// 上班之前更新 防止过多版本冲突
svn update

svn revert 版本回退


svn log 看history版本信息

svn status 查看文件的修改状态(添加A、修改M、删除D)

svn命令是基础

一、图形化svn客户端工具
CornerStone (圆角石头)
Versions  莲花
Xcode集成svn客户端的功能
 xcode svn 功能还不强大

svn有此项目的文件是不需要添加到服务器
无关要紧文件 xcode 用户配置

"unlock files after commit 不要勾选

http://192.168.14.28/svn/Weibo/code/trunk/

*实际的开发过程，使用图形化Svn客户端工具比较多

CornerStone使用步骤
1.映射svn服务器的url(代码的URL))到本地
2.把服务器url代码 下载到 本地的'工作目录'

练习
服务器要安装配置要练
connerstore学会使用








