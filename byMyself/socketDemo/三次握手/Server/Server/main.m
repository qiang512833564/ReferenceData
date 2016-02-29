//
//  main.m
//  Server
//
//  Created by lizhongqiang on 15/9/28.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>
#include <unistd.h>
#define BACKLOG 5 //完成三次握手但没有accept的队列的长度
#define CONCURRENT_MAX 8 //应用层同时可以处理的连接
#define SERVER_PORT 11332
#define BUFFER_SIZE 1024
#define QUIT_CMD ".quit"
int client_fds[CONCURRENT_MAX];
/*
 结束传输
 结束传输后可按需要使用close和shutdown函数关闭socket
 close(int sockfd);      释放sockfd指向的存储空间，该socket不再允许任何操作
 shutdown(int sockfd, int how)；
 how＝0——不允许继续接收，但可以写入数据发送；
 how＝1——不允许继续发送，但可以接收读出数据；
 how＝2——不允许读写，和close一样的作用
 */
int main (int argc, const char * argv[])
{
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
    int bind_result = bind(server_sock_fd, (struct sockaddr *)&server_addr, sizeof(server_addr));
    if (bind_result == -1) {
        perror("bind error");
        return 1;
    }
    //listen--第二个参数backlog:相应socket可以排队的最大连接个数
    if (listen(server_sock_fd, BACKLOG) == -1) {
        perror("listen error");
        return 1;
    }
    //fd_set的数据结构，实际上是一long类型的数组，每一个数组元素都能与一打开的文件句柄建立联系
    //
    fd_set server_fd_set;
    int max_fd = -1;
    struct timeval tv;
    tv.tv_sec = 20;
    tv.tv_usec = 0;
    while (1) {
        FD_ZERO(&server_fd_set);/*将set清零使集合中不含任何fd*/
        //标准输入
        FD_SET(STDIN_FILENO, &server_fd_set);/*将fd加入set集合*/
        if (max_fd < STDIN_FILENO) {
            max_fd = STDIN_FILENO;
        }
        //服务器端socket
        FD_SET(server_sock_fd, &server_fd_set);
        if (max_fd < server_sock_fd) {
            max_fd = server_sock_fd;
        }
        //客户端连接---在有客户端socket连接的情况下，才进入判断条件的执行语句
        for (int i = 0; i < CONCURRENT_MAX; i++) {
            if (client_fds[i]!=0) {
                FD_SET(client_fds[i], &server_fd_set);
                
                if (max_fd < client_fds[i]) {
                    max_fd = client_fds[i];
                }
            }
        }
        int ret = select(max_fd+1, &server_fd_set, NULL, NULL, &tv);
        if (ret < 0) {
            perror("select 出错\n");
            continue;
        }else if(ret == 0){
            printf("select 超时\n");
            continue;
        }else{
            //ret为未状态发生变化的文件描述符的个数
            if (FD_ISSET(STDIN_FILENO, &server_fd_set)) {
                //标准输入
                bzero(input_msg, BUFFER_SIZE);

                fgets(input_msg, BUFFER_SIZE, stdin);//可以用作键盘输入：fgets（key，n，stdin）且还必须：key[strlen(key)-1]='\0'
                
                /*
                 char *fgets(char *buf, int bufsize, FILE *stream);
                 参数
                 
                 *buf: 字符型指针，指向用来存储所得数据的地址。
                 bufsize: 整型数据，指明存储数据的大小。
                 *stream: 文件结构体指针，将要读取的文件流。
                 */
                
                //输入 ".quit" 则退出服务器
                if (strcmp(input_msg, QUIT_CMD) == 0) {
                    exit(0);
                }
                for (int i=0; i<CONCURRENT_MAX; i++) {
                    if (client_fds[i]!=0) {
                        send(client_fds[i], input_msg, BUFFER_SIZE, 0);
                    }
                }
            }
            if (FD_ISSET(server_sock_fd, &server_fd_set)) {
                //有新的连接请求
                struct sockaddr_in client_address;//accept()方法，可以获取客户端的地址
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
                    if (index >= 0) {//inet_ntoa()将一个IP转换成一个互联网标准点分格式的字符串,获取ip地址---ntohs()本函数将一个16位数由网络字节顺序转换为主机字节顺序,获取端口号
                        printf("新客户端(%d)加入成功 %s:%d \n",index,inet_ntoa(client_address.sin_addr),ntohs(client_address.sin_port));
                    }else{
                        bzero(input_msg, BUFFER_SIZE);
                        strcpy(input_msg, "服务器加入的客户端数达到最大值,无法加入!\n");
                        send(client_socket_fd, input_msg, BUFFER_SIZE, 0);
                        printf("客户端连接数达到最大值，新客户端加入失败 %s:%d \n",inet_ntoa(client_address.sin_addr),ntohs(client_address.sin_port));
                    }
                }
            }
            for (int i = 0; i <CONCURRENT_MAX; i++) {
                if (client_fds[i]!=0) {
                    if (FD_ISSET(client_fds[i], &server_fd_set)) {
                        //处理某个客户端过来的消息
                        bzero(recv_msg, BUFFER_SIZE);
                        long byte_num = recv(client_fds[i],recv_msg,BUFFER_SIZE,0);
                        if (byte_num > 0) {
                            if (byte_num > BUFFER_SIZE) {
                                byte_num = BUFFER_SIZE;
                            }
                            recv_msg[byte_num] = '\0';
                            printf("客户端(%d):%s\n",i,recv_msg);
                        }else if(byte_num < 0){
                            printf("从客户端(%d)接受消息出错.\n",i);
                        }else{
                            FD_CLR(client_fds[i], &server_fd_set);//FD_CLR(fd, &set); 将fd从set集合中清除
                            client_fds[i] = 0;
                            printf("客户端(%d)退出了\n",i);
                        }
                    }
                }
            }
        }
    }
    return 0;
}

#if 0
/*
 fopen(const char * path,const char * mode);
 文件顺利打开后，指向该流的文件指针就会被返回。如果文件打开失败则返回NULL，并把错误代码存在errno中
 mode有下列几种形态字符串:
 r 以只读方式打开文件，该文件必须存在。
 r+ 以可读写方式打开文件，该文件必须存在。
 rb+ 读写打开一个二进制文件，允许读写数据，文件必须存在。
 w 打开只写文件，若文件存在则文件长度清为0，即该文件内容会消失。若文件不存在则建立该文件。
 w+ 打开可读写文件，若文件存在则文件长度清为零，即该文件内容会消失。若文件不存在则建立该文件。
 等等......
 */
//fwrite(string, strlen(string), 1, stream);
FILE *stream ;

char buf[100];
if((stream=fopen("/Users/lizhongqiang/Desktop/byMyself/socketDemo/三次握手/Server/Server/file.txt","r"))==NULL)
{
    fprintf(stderr,"file open Fail!\n");
    return 0;
}
fread(buf,1,100,stream);
printf("%s\n",buf);
/*writesomedatatothefile*/
//fwrite(msg,strlen(msg)+1,1,stream);
/*sizeof（char）=1seektothebeginningofthefile*/
//fseek(stream,0,SEEK_SET);
/*
 int fseek(FILE *stream, long offset, int fromwhere);函数设置文件指针stream的位置。
 如果执行成功，stream将指向以fromwhere为基准，偏移offset（指针偏移量）个字节的位置，函数返回0。如果执行失败(比如offset超过文件自身大小)，则不改变stream指向的位置，函数返回一个非0值。
 */
/*readthedataanddisplayit*/
printf("%s\n",buf);
fclose(stream);
/*
 size_t fread ( void *buffer, size_t size, size_t count, FILE *stream) ;
 buffer
 用于接收数据的内存地址
 size
 要读的每个数据项的字节数，单位是字节
 count
 要读count个数据项，每个数据项size个字节.
 stream
 输入流
 */
fgets(input_msg, BUFFER_SIZE, stream);
#endif