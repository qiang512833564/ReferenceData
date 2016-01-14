# 调试 

## 调试 React Native 应用程序

想要调试你的 react 应用程序的 javascript 代码，方法如下： 

1. 在 iOS 模拟器中运行你的应用程序。
2. 按下 `command + D`，且网页应该打开 [http://localhost:8081 /debugger–ui](http://localhost:8081/debugger-ui)。(只有 Chrome 能打开)。
3. 为了得到更好的调试经验，启动 [Pause On Caught Exceptions](http://stackoverflow.com/questions/2233339/javascript-is-there-a-way-to-get-chrome-to-break-on-all-errors/17324511#17324511)。
4. 按下 `Command + Option + I` 打开 Chrome 开发工具，或通过 `View ->Developer -> Developer Tools` 打开它。
5. 现在你应该可以正常调试。

>**提示**

>为了实现在真实设备上调试：打开文件 `RCTWebSocketExecutor.m`，改变 `localhost` 为你的计算机的 IP 地址。使装置打开带有开始调试选项的开发菜单。

### 可选

为 Google Chrome 安装 [React 开发工具](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en)扩展。当开发工具是公开的，如果你选择 `React`，这将允许你浏览视图层。 

## Live Reload

为了激活 Live Reload，执行以下操作：
1. 在 iOS 模拟器中运行你的应用程序。
2. 按 `Control + Command + Z`。
3. 现在你可以看到 `Enable/Disable Live Reload`，`Reload` 和 ` Enable/Disable Debugging` 选项。

[下一页](http://facebook.github.io/react-native/docs/testing.html#content)
