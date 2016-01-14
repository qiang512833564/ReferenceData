//
//  main.m
//  kqueue
//
//  Created by lizhongqiang on 15/9/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/event.h>
#include <sys/types.h>
#include <sys/time.h>
#include <arpa/inet.h>
#include <string.h>
#include <unistd.h>
#define BACKLOG 5 //完成三次握手但没有accept的队列的长度
#define CONCURRENT_MAX 8 //应用层同时可以处理的连接
#define SERVER_PORT 11332
#define BUFFER_SIZE 1024
#define QUIT_CMD ".quit"
int client_fds[CONCURRENT_MAX];
struct kevent events[10];//CONCURRENT_MAX + 2

int main (int argc, const char * argv[])
{
    NSMutableData *imageData = [NSMutableData data];
    char input_msg[BUFFER_SIZE];
    char recv_msg[BUFFER_SIZE];
    //本地地址
    struct sockaddr_in server_addr;
    server_addr.sin_len = sizeof(struct sockaddr_in);
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(SERVER_PORT);
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    bzero(&(server_addr.sin_zero),8);
    //创建socket
    int server_sock_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (server_sock_fd == -1) {
        perror("socket error");
        return 1;
    }
    //解决bind错误(端口已存在的问题)---需要在绑定监听之前调用
    unsigned int value = 0x1;
    /*
     setsockopt()函数，用于任意类型、任意状态套接口的设置选项值。
     sockfd：标识一个套接口的描述字。
     level：选项定义的层次；支持SOL_SOCKET、IPPROTO_TCP、IPPROTO_IP和IPPROTO_IPV6。
     optname：需设置的选项。
     optval：指针，指向存放选项待设置的新值的缓冲区。
     optlen：optval缓冲区长度。
     */
    setsockopt(server_sock_fd,SOL_SOCKET,SO_REUSEADDR,(void *)&value,sizeof(value));
    //绑定socket
    //绑定socket
    int bind_result = bind(server_sock_fd, (struct sockaddr *)&server_addr, sizeof(server_addr));
    if (bind_result == -1) {
        perror("bind error");
        return 1;
    }
    //listen
    if (listen(server_sock_fd, BACKLOG) == -1) {
        perror("listen error");
        return 1;
    }
   
    /*
    struct kevent {
    uintptr_t ident;        事件 ID,实际应用中，一般设置为文件描述符。
    short     filter;       事件过滤器,可以将 kqueue filter 看作事件。
                            内核检测 ident 上注册的 filter 的状态，状态发生了变化，就通知应用程序
    u_short   flags;        行为标识
    u_int     fflags;       过滤器标识值
    intptr_t  data;         过滤器数据
    void      *udata;       应用透传数据
    };
    在一个 kqueue 中，{ident, filter} 确定一个唯一的事件。
    filter:----->
     EVFILT_READ
     TCP 监听 socket，如果在完成的连接队列 ( 已收三次握手最后一个 ACK) 中有数据，此事件将被通知。收到该通知的应用一般调用 accept()，且可通过 data 获得完成队列的节点个数。 流或数据报 socket，当协议栈的 socket 层接收缓冲区有数据时，该事件会被通知，并且 data 被设置成可读数据的字节数。
     
     EVFILT_WRIT
     当 socket 层的写入缓冲区可写入时，该事件将被通知；data 指示目前缓冲区有多少字节空闲空间。
    
     flags:------>
     EV_ADD
     指示加入事件到 kqueue。
     
     EV_DELETE
     指示将传入的事件从 kqueue 中移除。
     EV_ENABLE
     过滤器事件可用，注册一个事件时，默认是可用的。
     EV_DISABLE
     过滤器事件不可用，当内部描述可读或可写时，将不通知应用程序。第 5 小节有这个 flag 的用法介绍。
     EV_ERROR
     一个输出参数，当 changelist 中对应的描述符处理出错时，将输出这个 flag。应用程序要判断这个 flag，否则可能出现 kevent 不断地提示某个描述符出错，却没将这个描述符从 kq 中清除。处理 EV_ERROR 类似下面的代码： if (events[i].flags & EV_ERROR) close(events[i].ident); fflags 过滤器相关的一个输入输出类型标识，有时候和 data 结合使用。
     */

    struct kevent event_change;//kqueue 支持多种类型的文件描述符，包括 socket、信号、定时器、AIO、VNODE、PIPE
    
    struct timespec timeout = {10,0};
    //kqueue---->其实也是一个文件，创建返回后的值，是文件描述符，跟socket类似
    //kqueue 默认是水平触发模式，当某个描述符的事件满足某种条件时，如果应用程序不处理对应的事件，kqueue 将会不断地通知应用程序此描述符满足某种状态了。以 EVFILT_WRITE 举例，
    int kq = kqueue();
    if (kq == -1) {
        perror("创建kqueue出错!\n");
        exit(1);
    }
    
    // EV_SET(&kev, ident, filter, flags, fflags, data, udata);-->struct kevent 的初始化的辅助操作。
    EV_SET(&event_change, STDIN_FILENO, EVFILT_READ, EV_ADD, 0, 0, NULL);
    //可以理解为：把事件添加到队列里
    kevent(kq, &event_change, 1, NULL, 0, NULL);
    /*
     int kevent(int kq, const struct kevent *changelist, int nchanges,struct kevent *eventlist, int nevents,const struct timespec *timeout);
     kevent 提供向内核注册 / 反注册事件和返回就绪事件或错误事件：
     参数：
     kq:kqueue的文件描述符
     changelist: 要注册 / 反注册的事件数组
     nchanges: changelist 的元素个数
     eventlist: 事件数组,另外改数组里存着的是已经注册的事件，另外也表示最大容量；
     nevents: eventlist 的元素个数
     timeout: 等待事件到来时的超时时间，0，立刻返回；NULL，一直等待；有一个具体值，等待 timespec 时间值
     返回值：可用事件的个数
     */
#pragma mark --- 注册事件
    EV_SET(&event_change, server_sock_fd, EVFILT_READ, EV_ADD, 0, 0, NULL);
    kevent(kq, &event_change, 1, NULL, 0, NULL);
    while (1) {
#pragma mark ----创建监听
        int ret = kevent(kq, NULL, 0, events, 10, &timeout);//返回值：可用事件的个数
//这一行就是 kevent 事件等待方法，将 changelist 和 nchangelist 分别置成 NULL 和 0，并且传一个足够大的eventlist空间给内核。当有事件过来时，kevent 返回，这时调用 HandleEvent 处理可用事件。
        //1.这里起的作用是阻塞线程，知道事件发生，或者超多阻碍设定的时间
        //2.
        
        if (ret < 0) {
            printf("kevent 出错!\n");
            continue;
        }else if(ret == 0){
            printf("kenvent 超时!\n");
            continue;
        }else{
            //ret > 0 返回事件放在events中
            for (int i = 0; i < ret; i++) {
                struct kevent current_event = events[i];
                //kevent中的ident就是文件描述符
                //输入事件
                if (current_event.ident == STDIN_FILENO) {
                    //标准输入
                    bzero(input_msg, BUFFER_SIZE);
                    fgets(input_msg, BUFFER_SIZE, stdin);
                    //输入 ".quit" 则退出服务器
                    if (strcmp(input_msg, QUIT_CMD) == 0) {
                        exit(0);
                    }
                    for (int i=0; i<CONCURRENT_MAX; i++) {
                        if (client_fds[i]!=0) {
                            send(client_fds[i], input_msg, BUFFER_SIZE, 0);
                        }
                    }
                }else if(current_event.ident == server_sock_fd){
                    //连接事件
                    //有新的连接请求
                    struct sockaddr_in client_address;
                    socklen_t address_len;
                    int client_socket_fd = accept(server_sock_fd, (struct sockaddr *)&client_address, &address_len);
                    if (client_socket_fd > 0) {
                        int index = -1;
                        for (int i = 0; i < CONCURRENT_MAX; i++) {
                            if (client_fds[i] == 0) {
                                index = i;
                                client_fds[i] = client_socket_fd;
                                break;
                            }
                        }
                        if (index >= 0) {
#pragma mark -----------------注册事件-----------------
                            EV_SET(&event_change, client_socket_fd, EVFILT_READ, EV_ADD, 0, 0, NULL);
                            kevent(kq, &event_change, 1, NULL, 0, NULL);
                            printf("新客户端(fd = %d)加入成功 %s:%d \n",client_socket_fd,inet_ntoa(client_address.sin_addr),ntohs(client_address.sin_port));
                        }else{
                            bzero(input_msg, BUFFER_SIZE);
                            strcpy(input_msg, "服务器加入的客户端数达到最大值,无法加入!\n");
                            send(client_socket_fd, input_msg, BUFFER_SIZE, 0);
                            printf("客户端连接数达到最大值，新客户端加入失败 %s:%d \n",inet_ntoa(client_address.sin_addr),ntohs(client_address.sin_port));
                        }
                    }
                }else{
                    //处理某个客户端过来的消息
                    bzero(recv_msg, BUFFER_SIZE);
                    long byte_num = recv((int)current_event.ident,recv_msg,BUFFER_SIZE,0);
                    if (byte_num > 0) {
                        if (byte_num > BUFFER_SIZE) {
                            byte_num = BUFFER_SIZE;
                        }
                        recv_msg[byte_num] = '\0';
                        [imageData appendBytes:recv_msg length:1024];
                        printf("客户端(fd = %d):%s\n",(int)current_event.ident,recv_msg);
                    }else if(byte_num < 0){
                        printf("从客户端(fd = %d)接受消息出错.\n",(int)current_event.ident);
                    }else{
                        EV_SET(&event_change, current_event.ident, EVFILT_READ, EV_DELETE, 0, 0, NULL);
                        kevent(kq, &event_change, 1, NULL, 0, NULL);
                        close((int)current_event.ident);
                        for (int i = 0; i < CONCURRENT_MAX; i++) {
                            if (client_fds[i] == (int)current_event.ident) {
                                client_fds[i] = 0;
                                break;
                            }
                        }
                        [imageData writeToFile:@"/Users/lizhongqiang/Desktop/img.jpg" atomically:YES];
                        printf("客户端(fd = %d)退出了\n",(int)current_event.ident);
                    }
                }
            }
        }
    }
    return 0;
}
/*
 在某种情形下，应用程序须要禁止 kqueue 不断地通知某个描述符的“可写”状态。将已注册的 {ident, filter} 的 flags 设置成 EV_DISABLE 就达到这个目的。实现方法类似清单 4。
 清单 4. 实现方法
 struct kevent changes[1];
 EV_SET(&changes[0], fd, EVFILT_WRITE, EV_DISABLE, 0, 0, NULL);
 kevent(kq, changes, 1, NULL, 0, NULL);
 */
