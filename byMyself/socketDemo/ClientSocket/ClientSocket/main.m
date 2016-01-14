//
//  main.m
//  ClientSocket
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

int main (int argc, const char * argv[])
{
    struct sockaddr_in server_addr;
    server_addr.sin_len = sizeof(struct sockaddr_in);
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(11332);//
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    bzero(&(server_addr.sin_zero),8);
    
    int client_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (client_socket == -1) {
        perror("socket error");
        return 1;
    }
    char recv_msg[1024];
    char reply_msg[1024];
    
    if (connect(client_socket, (struct sockaddr *)&server_addr, sizeof(struct sockaddr_in))==0)     {
        //connect 成功之后，其实系统将你创建的socket绑定到一个系统分配的端口上，且其为全相关，包含服务器端的信息，可以用来和服务器端进行通信。
    /*
        srcfd = open(filename, O_RDONLY, 0);
        if ((srcp = mmap(0, filesize, PROT_READ, MAP_PRIVATE, srcfd, 0)) == MAP_FAILED) {
            err_quit("file map error");
        }
        close(srcfd);
        if (send(connfd, srcp, filesize, 0) != filesize) {
            munmap(srcp, filesize);
            err_quit("write error");
        }
        munmap(srcp, filesize);
     */

        NSMutableData *imageData = [NSMutableData data];
        
        FILE *stream;
        stream = fopen("/Users/lizhongqiang/Desktop/byMyself/socketDemo/ClientSocket/ClientSocket/头像.jpg", "r");
        if(stream == NULL)
        {
            fprintf(stderr, "file open fail!\n");
        }
        int bytesSent=0;
        char sendbuf[1024];
        size_t num;
        //NSLog(@"%lu,char:%d,int:%lu，size-t:%lu",sizeof(NSUInteger),sizeof(char),sizeof(int),sizeof(size_t));
        while (1) {
           //fseek(stream, 32, SEEK_CUR);
           num = fread(sendbuf, 1, 1024, stream);//返回值：实际读取的元素个数
           bytesSent+=4;
            send(client_socket, sendbuf, 1024, 0);
            //NSLog(@"%zu---%d",num,SEEK_END);
            printf("%s\n",sendbuf);
            [imageData appendBytes:sendbuf length:1024];
            if(num == 0)
            {
                
                [imageData writeToFile:@"/Users/lizhongqiang/Desktop/copyImage.jpg" atomically:YES];
                
                break;
            }
            //if(num >= SEEK_END)
            {
                
                //exit(0);
            }
        }
//        char buf[4094*2];
//        fread(buf, 1, 4096*2, stream);
////        buf = "数据";
//        //NSData *data = [NSData dataWithBytes:buf length:4096*4];
//        //NSLog(@"%@",data);
//        printf("%s\n",buf);
//        send(client_socket, buf, 4092*2, 0);
#if 0
        while (1) {
            bzero(recv_msg, 1024);
            bzero(reply_msg, 1024);
            
            long byte_num = recv(client_socket,recv_msg,1024,0);
            recv_msg[byte_num] = '\0';
            printf("server said:%s\n",recv_msg);
            
            printf("reply:");
            scanf("%s",reply_msg);
            if (send(client_socket, reply_msg, 1024, 0) == -1) {
                perror("send error");
            }
        }
#endif
    }
    
    // insert code here...
    printf("Hello, World!\n");
    return 0;
}
