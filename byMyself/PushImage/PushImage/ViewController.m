//
//  ViewController.m
//  PushImage
//
//  Created by lizhongqiang on 15/10/19.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#define kTimeOut 5.0f  
/** 分隔字符串 */
static NSString *boundaryStr = @"--";
/** 本次上传标示字符串 */
static NSString *randomIDStr;
/** 上传(php)脚本中，接收文件字段 */
static NSString *uploadID;

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
- (IBAction)pickImage:(id)sender {
    UIImagePickerController *imagePic = [[UIImagePickerController alloc]init];
    /*
      UIImagePickerController : UINavigationController不能push，只能通过视图控制器间的方法
     */
    imagePic.delegate = self;
    imagePic.sourceType = UIImagePickerControllerCameraCaptureModePhoto;
    imagePic.allowsEditing = YES;
    [self presentViewController:imagePic animated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = info[@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)commitImage:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];////申明请求的数据是什么类型--AFJSONResponseSerializer在这里会出错
    [manager GET:@"http://localhost/myphp/downloadfile/downloadfile.php" parameters:@{@"username":@"1"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        
        NSLog(@"%@ ------", result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
//    [self uploadFile:[[NSBundle mainBundle] pathForResource:@"file" ofType:@"jpg"] fileName:@"file.jpg" completion:^(NSString *string) {
//        NSLog(@"%@",string);
//    }];
    
}
#pragma mark - 成员方法.  用NSURLSession来完成上传
- (void)uploadFile:(NSString *)path fileName:(NSString *)fileName completion:(void (^)(NSString *string))completion
{
    // 1. url 提示：真正负责文件上传的是php文件，而不是html文件
    NSURL *url = [NSURL URLWithString:@"http://localhost/pushImage.php"];//http://localhost/new/post/upload.php
    
    // 2. request
    NSURLRequest *request = [self requestForUploadURL:url uploadFileName:fileName localFilePath:path];
    
    // 3. session（回话）
    // 全局网络回话，为了方便程序员使用网络服务
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4. 数据任务-> 任务都是由回话发起的
    /** URLSession的任务，默认都是在其他线程工作的，默认都是异步的 */
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
        
        NSLog(@"%@ ------%@", result,error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(@"下载完成");
            }
        });
    }] resume];
    
    //    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    //
    //        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //
    //        NSLog(@"%@ %@", result, [NSThread currentThread]);
    //
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            if (completion) {
    //                completion(@"下载完成");
    //            }
    //        });
    //    }];
    //
    //    // 5. 启动任务
    //    [task resume];
}

#pragma mark - 私有方法 ： 拼字符串
/** 拼接顶部字符串 */
- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", uploadID, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    
    NSLog(@"顶部字符串：%@", strM);
    return [strM copy];
}

/** 拼接底部字符串 */
- (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    
    NSLog(@"底部字符串：%@", strM);
    return [strM copy];
}

/** 指定全路径文件的mimeType */
- (NSString *)mimeTypeWithFilePath:(NSString *)filePath
{
    // 1. 判断文件是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return nil;
    }
    
    // 2. 使用HTTP HEAD方法获取上传文件信息
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 3. 调用同步方法获取文件的MimeType
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    return response.MIMEType;
}
/** 上传文件网络请求 */
- (NSURLRequest *)requestForUploadURL:(NSURL *)url uploadFileName:(NSString *)fileName localFilePath:(NSString *)filePath
{
    // 0. 获取上传文件的mimeType
    NSString *mimeType = [self mimeTypeWithFilePath:filePath];
    if (!mimeType) return nil;
    
    // 1. 拼接要上传的数据体
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:[[self topStringWithMimeType:mimeType uploadFile:fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    // 拼接上传文件本身的二进制数据
    //[dataM appendData:[NSData dataWithContentsOfFile:filePath]];
    [dataM appendData:UIImagePNGRepresentation(self.imageView.image)];//这里是上传的二进制数据
    [dataM appendData:[[self bottomString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 2. 设置请求
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:kTimeOut];
    // 1> 设定HTTP请求方式
    requestM.HTTPMethod = @"POST";
    // 2> 设置数据体
    requestM.HTTPBody = dataM;
    // 3> 指定Content-Type
    NSString *typeStr = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [requestM setValue:typeStr forHTTPHeaderField:@"Content-Type"];
    // 4> 指定数据长度
    NSString *lengthStr = [NSString stringWithFormat:@"%@", @([dataM length])];
    [requestM setValue:lengthStr forHTTPHeaderField:@"Content-Length"];
    
    return [requestM copy];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /** 本次上传标示字符串 */
    randomIDStr = @"photo";//itcastupload
    /** 上传(php)脚本中，接收文件字段 */
    // 可以咨询公司的网站开发程序员
    // 或者用FireBug自己跟踪调试
    //这个需要与php中的相对于$_FILES['photo']['tmp_name'])
    uploadID = @"photo";//uploadFile
    
    self.imageView.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 TIPS：session使用注意
 *网络会话, 方便程序员使用网络服务.
 *如:可以获得当前上传文件的进度.
 *NSURLSession的任务, 默认都是异步的.(在其他线程中工作)
 *Task是由会话发起的.
 *注意网络请求都要进行出错处理.
 *session默认是挂起的, 需要resume一下才能启动.
 */

@end
