//
//  main.m
//  Client
//
//  Created by lizhongqiang on 15/9/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>
#include <unistd.h>

#define BUFFER_SIZE 1024

int main (int argc, const char * argv[])
{
    struct sockaddr_in server_addr;
    server_addr.sin_len = sizeof(struct sockaddr_in);
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(11332);
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    bzero(&(server_addr.sin_zero),8);
    
    int server_sock_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (server_sock_fd == -1) {
        perror("socket error");
        return 1;
    }
    char recv_msg[BUFFER_SIZE];
    char input_msg[BUFFER_SIZE];
    
    if (connect(server_sock_fd, (struct sockaddr *)&server_addr, sizeof(struct sockaddr_in))==0) {
        /*
         select()机制中提供一fd_set的数据结构，实际上是一long类型的数组，每一个数组元素都能与一打开的文件句柄（不管是socket句柄，还是其他文件或命名管道或设备句柄）建立联系，建立联系的工作由程序员完成，当调用select()时，由内核根据IO状态修改fd_set的内容，由此来通知执行了select()的进程哪一socket或文件发生了可读或可写事件。
        用法：
        FD_ZERO(&set); 将set清零使集合中不含任何fd
        FD_SET(fd, &set); 将fd加入set集合
        FD_CLR(fd, &set); 将fd从set集合中清除
        FD_ISSET(fd, &set); 在调用select()函数后，用FD_ISSET来检测fd在fdset集合中的状态是否变化返回整型，当检测到fd状态发生变化时返回真，否则，返回假（0）
         */
        fd_set client_fd_set;//一个socket就是一个文件，socket句柄就是一个文件描述符
        struct timeval tv;
        tv.tv_sec = 20;//秒
        tv.tv_usec = 0;//微秒
        
        
        while (1) {
            FD_ZERO(&client_fd_set);//讲set清零使集合中不含任何fd
            FD_SET(STDIN_FILENO, &client_fd_set);//将fd加入到set集合
            //STDIN_FILENO--->standard input file descriptor
            FD_SET(server_sock_fd, &client_fd_set);
            /*
             select()函数：------Select用于阻塞线程的（就是进程或是线程执行到这些函数时必须等待某个事件的发生，如果事件没有发生，进程或线程就被阻塞，函数不能立即返回）
             确定一个或多个套接口的状态，如:需要则等待。
             select这个系统调用，是一种多路复用IO方案，可以同时对多个文件描述符进行监控，从而知道哪些文件描述符可读，可写或者出错，不过select方法是阻塞的，可以设定超时时间。 select使用的步骤如下:
             五个参数分别为：
             nfds：是一个整数值，是指集合中所有文件描述符的范围，即所有文件描述符的最大值加1，不能错！在Windows中这个参数的值无所谓，可以设置不正确。
             readfds：（可选）指针，指向一组等待可读性检查的套接口。
             writefds：（可选）指针，指向一组等待可写性检查的套接口。
             exceptfds：（可选）指针，指向一组等待错误检查的套接口。
             timeout：select()最多等待时间，对阻塞操作则为NULL。
             */
            int ret = select(server_sock_fd + 1, &client_fd_set, NULL, NULL, &tv);
            if (ret < 0 ) {
                printf("select 出错!\n");
                continue;
            }else if(ret ==0){
                printf("select 超时!\n");
                continue;
            }else{
                if (FD_ISSET(STDIN_FILENO, &client_fd_set)) {//FD_ISSET(fd, &set); 在调用select()函数后，用FD_ISSET来检测fd在fdset集合中的状态是否变化返回整型，当检测到fd状态发生变化时返回真，否则，返回假（0）
                    //NSData *data = [NSData dataWithContentsOfFile:@"/Users/lizhongqiang/Desktop/byMyself/socketDemo/三次握手/Client/Client/头像.jpg"];
                    //NSLog(@"%@",data);
                    bzero(input_msg, BUFFER_SIZE);
                   // char *sendImage=data.bytes;
                    //[data getBytes:sendImage length:data.length];
                    
                    fgets(input_msg, BUFFER_SIZE, stdin);
                    
                    if (send(server_sock_fd, input_msg, BUFFER_SIZE, 0)  == -1) {
                        perror("发送消息出错!\n");
                    }
                }
                
                if (FD_ISSET(server_sock_fd, &client_fd_set)) {
                    bzero(recv_msg, BUFFER_SIZE);
                    long byte_num = recv(server_sock_fd,recv_msg,BUFFER_SIZE,0);
                    if (byte_num > 0) {
                        if (byte_num > BUFFER_SIZE) {
                            byte_num = BUFFER_SIZE;
                        }
                        recv_msg[byte_num] = '\0';
                        printf("服务器:%s\n",recv_msg);
                        
                        sleep(1);
                        FILE *stream ;
                        
                        char buf[100];
                        if((stream=fopen("/Users/lizhongqiang/Desktop/byMyself/socketDemo/sendfileDemo/Client/Client/头像.jpg","r"))==NULL)
                        {
                            fprintf(stderr,"file open Fail!\n");
                            return 0;
                        }
                        off_t len;
                        struct sf_hdtr parama;
                        struct iovec v[17+23];
                        parama.headers = v;parama.hdr_cnt=17;
                        parama.trailers = v+17;parama.trl_cnt=23;
                        printf("%d----%d",stream->_file,stream->_flags);
                        int successOrfail =sendfile(stream->_flags, server_sock_fd, 0, &len, (struct sf_hdtr *) 0, 0);//这样子每次最多发送1024个字节------------successOrfail返回值是0表示成功发送
                        //第一个参数：文件的描述符
                        //第二个参数：socket描述符（其实一个socket，也就是一个文件）
                        //第三个参数：文件开始的偏移量
                        //第四个参数：返回的是长度--->最终读取的数据节数
                        //第五个参数：(struct sf_hdtr *) 0
                        //第六个参数：保留参数--以后使用
                        NSLog(@"%d---%lld",successOrfail,len);
                    }else if(byte_num < 0){
                        printf("接受消息出错!\n");
                    }else{
                        printf("服务器端退出!\n");
                        exit(0);
                    }
                    
                }
            }
        }
        
    }
    
    return 0;
}
/*
 在传统的文件传输里面（read/write方式），在实现上其实是比较复杂的，需要经过多次上下文的切换，我们看一下如下两行代码：
 
 
 read(file, tmp_buf, len);
 write(socket, tmp_buf, len);
 
 以上两行代码是传统的read/write方式进行文件到socket的传输。
 
 当需要对一个文件进行传输的时候，其具体流程细节如下：
 
 1、调用read函数，文件数据被copy到内核缓冲区
 
 2、read函数返回，文件数据从内核缓冲区copy到用户缓冲区
 
 3、write函数调用，将文件数据从用户缓冲区copy到内核与socket相关的缓冲区。
 
 4、数据从socket缓冲区copy到相关协议引擎。
 
 以上细节是传统read/write方式进行网络文件传输的方式，我们可以看到，在这个过程当中，文件数据实际上是经过了四次copy操作：
 
 硬盘—>内核buf—>用户buf—>socket相关缓冲区—>协议引擎
 
 而sendfile系统调用则提供了一种减少以上多次copy，提升文件传输性能的方法。Sendfile系统调用是在2.1版本内核时引进的：
 
 sendfile(socket, file, len);
 
 运行流程如下：
 
 1、sendfile系统调用，文件数据被copy至内核缓冲区
 
 2、再从内核缓冲区copy至内核中socket相关的缓冲区
 
 3、最后再socket相关的缓冲区copy到协议引擎
 
 相较传统read/write方式，2.1版本内核引进的sendfile已经减少了内核缓冲区到user缓冲区，再由user缓冲区到socket相关 缓冲区的文件copy，而在内核版本2.4之后，文件描述符结果被改变，sendfile实现了更简单的方式，系统调用方式仍然一样，细节与2.1版本的 不同之处在于，当文件数据被复制到内核缓冲区时，不再将所有数据copy到socket相关的缓冲区，而是仅仅将记录数据位置和长度相关的数据保存到 socket相关的缓存，而实际数据将由DMA模块直接发送到协议引擎，再次减少了一次copy操作。
*/