//
//  main.m
//  Runtimer伪代码
//
//  Created by lizhongqiang on 16/3/27.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunMode.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
#if 0
        //程序一直运行状态
        while (AppIsRunning) {
            //睡眠状态，等待唤醒事件
            id whoWakesMe = SleepForWakingUp();
            //得到唤醒事件
            id event = GetEvent(whoWakesMe);
            //开始处理事件
            HandleEvent(event);

        }
#endif
        RunMode *mode = [[RunMode alloc]init];
        
    }
    return 0;
}
