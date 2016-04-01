agit:
Rule of thumb: 1GB per repository, 100MB per file单个仓库最大1GB，单个文件上限100MB

-svn(Subversion) 用于版本控制

•新员工-维护旧项目-使用svn checkout 命令把公司svn服务器的代码下载本地
•完成一天的代码编写工作，下班之前到要提交一次代码到svn服务器 -
  "提交有个前提" - 一定你的代码运行起来没有错，不会“崩溃”
  "提交之前" 最好更新svn代码,再提交 ？ "防止代码冲突" out of date

•去到公司，公司人员一般都会给你一个svn的帐号
•公司刚才成立,有可能没有svn服务器

git总的流程---------》
1：先git add(remove)到暂缓区
2: 再commit到本地git库（因为gitClone是吧整个git库全部clone到本地来的）
3:然后在push到Git服务器上

git add + 文件
如果想撤销---则可以通过git rm --cached +文件名

git-----Xcode 新建文件夹之后----不需要add .添加到缓存区-----直接commit就行
-git

svn 集中式的版本控制
 *所有的版本信息v1 v2 v3 -> svn服务器

gig 分布式的版本控制
 •它的所有版本信息可以保存到本地或者是远程服务器
svn 分布式版本控制对于集中式的版本控制有什么好处
  •比svn 数据备份安全
  •svn branches分布 创建比较麻烦
  •git 分枝创建非常简单
//===============
git 命令行
•创建一个仓库git init (在一个文件夹下---该文件夹就会被作为库)
•初始化项目-随便添加几个文件
•提交项目到版本控制
 git commit - m '标识'

 •配置'全局'git的邮箱地址和用户名 ,邮箱和用户名随便写
  git config --global user.email "itcast@itcast.cn"
  git config --global user.name "gzitcast"

"git的工作原理"
git 有一个stage 暂缓区
    有一个master 相当于svn trunk(主杆)

提交的时候，要把新文件添加到暂缓区，然后再添加到master
•git 版本号"633a67f45ebc22d7a47c946564e71aef595c4d69" MD5编码后字符串

•修改文件提交
 "修改文件的提交也要把文件添加到暂缓区
 "添加文件也要把文件添加到暂缓区
 放在暂缓区的命令 git add



•版本回退
 git reset --hard HEAD^ 回到当前的版本------版本号通过git log查看
前两个HEAD^^
具体HEAD~1前几个

git reset test.c  （状态变回modified）回退具体的文件

•删除
 git rm 文件名


•配置用户名和邮箱
 >全局和局部
 >全局 ： 默认一个git仓库没有配置用户名和邮箱就使用全局
 >局部: 仅针对本项目才有效
  .git/config 配置局部的用户名和邮箱
 //不可以用户名和邮箱一起配置
   git config "user.name" zhangsan
   git config "user.email" zhangsan@itcast.cn

"z注意对远程仓库操作时：都需要在前面加remote"
•查看远程仓库地址
 git remote -v

把本地仓库与远程相关联
命令：git push -u+地址

git remote查看相关远程库
把本地仓库移除远程仓库
git remote rm RemotePushNotification（远程仓库名称）

//移除远程仓库链接
git remote rm origin
git remote add origin git@github.com:Liutos/foobar.git

•日志格式
git log
===>
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
/*
lizhongqiangdeMacBook-Pro:ReferenceData2 lizhongqiang$ git log --pretty=oneline
7d2d0dfbba925bbf837ae55028c9071f7b68fb17 项目修改
046f6730a11a722335293a7826d64e4f191af95b 删除
3b945ca17d9aea5a831a5814d7cd702fb16bae56 提交
*/
•配置别名(alias.后面的就是别名  双引号"里面是需要更改的命令")
 svn commit =》 svn ci
 git 命令是没有缩小的别名
 git cfg alias.ct "commit -m"
 git cfg --global alias.ct "commit -m"

•分枝
 svn branches
 git branch

 weibo1.0 普通功能
 weibo2.0 抢红包
 'git branch 查看所有分枝
 'git branch v1 查看指定分枝/创建分支

 切换weiboW1.0分支 git checkout v1
 绿色的代表 '正在开发分支'

 把v1.0版本集成到当前发布版本2.0
 git merge v1

 删除分枝
 git branch -d v1


•git也图形化工具
 xcode 集成git


-git sever
 github,国外
 oschina 国内


•"oschina 国内"
 》注册帐号
 》在网址上初始化一个仓库
 》把远程仓库里的东西下载到本地
   git clone https://git.oschina.net/mayaole/WeChat.git
 》添加项目代码，提交版本本地
   git commit -m "初始化微信的项目代码"
 》上传到服务器
   git push+(库名称或者url)
如果第一次提交遇到
/*
 Perhaps you should specify a branch such as 'master'.
 Everything up-to-date
 */
则表明git无法找到你当前对应的分支（Git 找不到你要提交的版本了.）
调用命令：git push origin master

 》更新
   git pull

 》多人开发，别人怎么提交你代码
  •后台添加一个项目组
  •往项目组里添加项目
  •先在后台添加一个开发者,把这个开发者添加到你的"开发者组"
  •把 ”开发者组“ 添加到 ”项目组“

github使用跟oschina是样
大家自己学习


 mayaole2

以下github给出的基本使用方法：-----把本地的仓库上传到服务器上，需要: 需要先在github手动创建repo
1 mkdir gitRepo(这一步也可以直接进入Xcode新建的项目的根目录)
2 cd gitRepo
3 git init  #初始化本地仓库
4 git add xxx  #添加要push到远程仓库的文件或文件夹
5 git commit -m 'first commit'  #提交zhiqadd的文件
6 git remote add origin https://github.com/yourgithubID/gitRepo.git  #建立远程仓库
7 git push -u origin master #将本地仓库push到远程仓库


如果修改的文件需要全部提交，我一般都是
git commit -am "commit messages"
如果修改的文件只提交一部分，用
git add -p
git commit -m "commit messages"
-----------可以通过git commit -A查看


git add . 加入改文件夹中所有的文件到缓存区中(git add --all)
git add +文件名 加入具体的文件到缓存区（改文件名也可以是一个路径）

========>查看当前分支
git branch查看本地分支(或者git branch -a查看远程分支)
========>分支创建、上传push、选择、
git branch + 分支名   "创建分支"（创建分支，是把主分支上面的东西都弄到新建的分支上去）
git push -u origin + 分支名  -----"将本地版本库中的分支上传到GitHub上"---如果远程库，没有该分支，则会创建该分支
git checkout + 分支名  "切换分支"
========》当本地不存在分支时，可通过：
         git checkout origin/development //这样就可以把development这个分支的所有文件夹都下载下来了
========》删除本地分支
git branch -d + 分支名
========>删除远程分支
git push origin --delete + 分支名

终端
192:QuarZ2D---Demo lizhongqiang$ git branch
master
* v1
这里v1的颜色，和前面的*，表示当前所在分支


错误：
Git – fatal: Unable to create 'XXX/.git/index.lock’: File exists.的解决办法
在.git同级目录，执行rm -f .git/index.lock （或者rm -f git/index.lock） 删除后可提交。成功！

如果报错：
192:QuarZ2D---Demo lizhongqiang$ git add .
Assertion failed: (item->nowildcard_len <= item->len && item->prefix <= item->len), function prefix_pathspec, file pathspec.c, line 317.
Abort trap: 6-----
git push后在github上文件夹是灰色的！

可以先在本地中先复制出问题的文件夹
然后通过Git命令删除该文件夹，然后push到github上，在通过Git添加出问题的文件夹，然后在push，就能解决

删除文件夹方式
进入改文件夹目录上一阶层 git rm + 文件夹名

使用 git rm 命令即可，有两种选择,
一种是 git rm --cached "文件路径"，不删除物理文件，仅将该文件从缓存中删除；
一种是 git rm --f "文件路径"，不仅将该文件从缓存中删除，还会将物理文件删除（不会回收到垃圾桶）。

创建目录 mkdir
创建文件 touch

http://linux.ctocio.com.cn/228/9355228.shtml
linux 删除目录很简单，很多人还是习惯用 rmdir，不过一旦目录非空，就陷入深深的苦恼之中……
直接 rm 就可以了，不过要加两个参数-rf 即：
rm -rf “目录名字”
-r 就是向下递归，不管有多少级目录，一并删除
-f 就是直接强行删除，不作任何提示的意思
需要提醒的是：使用这个 rm -rf 的时候一定要格外小心，linux 没有回收站的


错误：
git status-------查看状态，显示modified:+文件路径，则表明文件已经修改，但是还没有放入暂存区域，也就是没有生成快照
吐过，现在进行commit操作，只是将修改之前的文件快照提交到了git目录，一定记住：只有暂存区域的文件（即：文件状态为"change to be committed"）才会被提交，所以上面红色modified解决办法，先把文件通过git add + 文件路径来添加文件到暂存区域，然后再提交


提交的时候错误：
lizhongqiangdeMacBook-Pro:BOSS刷新模拟 lizhongqiang$ git commit -m "popView边框阴影"
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
modified:   "BOSS\345\210\267\346\226\260\346\250\241\346\213\237.xcodeproj/project.pbxproj"
modified:   "BOSS\345\210\267\346\226\260\346\250\241\346\213\237.xcworkspace/xcuserdata/lizhongqiang.xcuserdatad/UserInterfaceState.xcuserstate"
modified:   "BOSS\345\210\267\346\226\260\346\250\241\346\213\237/UIButton+PopView.m"
解决方法：
从输出信息中可以得知，我的修改 git 是感知的，但在我未执行 add 前，git 认为我本地代码的状态仍旧是 up-to-date with 'origin/master' 。同时 git 提示，我的修改尚未 staged for commit ，因为只有 add 后才能 commit ，所以 git 给出的结论为 no changes added to commit 。
lizhongqiangdeMacBook-Pro:BOSS刷新模拟 lizhongqiang$ git add .


错误：
izhongqiangdeMacBook-Pro:CocoaChinaPlus lizhongqiang$ sudo git submodule update --init --recursive
Password:
Sorry, try again.
Password:
Cloning into 'Code/CocoaChinaPlus/Application/Vender/vender-lib'...
Warning: Permanently added the RSA host key for IP address '192.30.252.128' to the list of known hosts.
Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
Clone of 'git@github.com:zixun/vender-lib.git' into submodule path 'Code/CocoaChinaPlus/Application/Vender/vender-lib' failed
解决方法：https://help.github.com/articles/generating-ssh-keys/
The problem is that you haven't initialized SSH keys with Github. This solved it for me:

cd ~/.ssh && ssh-keygen
cat id_rsa.pub
and copy the key into the SSH settings of the Github website.

Then you're good to continue.

错误：
git push后在github上文件夹是灰色的
愿意：是因为子文件夹下还有git仓库，删掉就好了
解决方法：
先清理版本库里的灰色空文件夹
git rm --cached "文件路径"（该文件是呈灰色的文件夹）
git commit -m "修改"
git push
然后再，添加到版本库中
git add .
git commit -m "添加"
git push


错误：
在git上传文件时，将一个100兆的大文件添加到了git，并执行了push操作，这时在上传完毕后，会提示这个错误：
lizhongqiangdeMacBook-Pro:ReferenceData2 lizhongqiang$ git push
Counting objects: 7295, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (7055/7055), done.
Writing objects: 100% (7295/7295), 105.25 MiB | 231.00 KiB/s, done.
Total 7295 (delta 2207), reused 0 (delta 0)
remote: error: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs.github.com.
remote: error: Trace: b59f64bb3ce355590970c287eef22e6c
remote: error: See http://git.io/iEPt8g for more information.
remote: error: File code4app/即时通讯/sdk_im_ios/sdk_im_ios_v5.0.3r/lib/Yuntx_IMLib_v5.0.3r.a is 111.47 MB; this exceeds GitHub's file size limit of 100.00 MB
To git@github.com:qiang512833564/ReferenceData2.git
! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'git@github.com:qiang512833564/ReferenceData2.git'
如果未push，可通过git commit --amend命令修复
如果已经push了：（,执行git push origin master命令之后，这时候你会如果删除了该大文件（git rm --cached +文件名），并git commit操作，在git push之后依然会上传该大文件。这样就照成了每次都提交不了的问题）
解决办法：是通过git reset HEAD~1方式撤销该版本的文件提交，之后的版本文件保留，但需重新添加一次
git add .
git  commit -m "add file"
git push origin master----如果此时再出现错误：
lizhongqiangdeMacBook-Pro:ReferenceData2 lizhongqiang$ git push
To git@github.com:qiang512833564/ReferenceData2.git
! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'git@github.com:qiang512833564/ReferenceData2.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
                                                            hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
lizhongqiangdeMacBook-Pro:ReferenceData2 lizhongqiang$ git push origin mast
则表示，你回退git reset HEAD~的版本叫远程库版本过低，所以，此时需要git pull下（另外需要注意，此时需要你先把未提交上去的大文件备份下，因为这个过程可能会丢失），然后再重新git add .--->git commit -m "add file"---->git push解决


错误：
lizhongqiangdeMacBook-Pro:ReferenceData lizhongqiang$ git commit -m "更新"
You have both byMyself and byMyself/.DS_Store
You have both byMyself and byMyself/.DS_Store
error: Error building trees
解决方法：
git reset --mixed

问题：
如果刚刚改过Git下某个文件，并且通过Git Status查看状态，也已经modify了，但是commit的时候却not anything ,此时只能通过git commit -m "" + 文件或者文件夹路径名，来提交
