NSRunLoopSample
===============

for study NSRunLoop / CFRunLoop

NSRunLoopを勉強するために書いてみたコードです。
Observerを設定してNSLogを出しているので、#warningのコメント箇所を参考に、
コメントアウトの部分を変えると動作が変わって面白いです。
ObserverをCommonModeで設定し、UITextViewをスクロールしながら、NSLogを見ると、
UITrackingModeに占有されて、Timerが発火しない事がわかります。

