//
//  ViewController.m
//  图片压缩
//
//  Created by lizhongqiang on 15/12/29.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import <stdio.h>
#import <ZipArchive.h>
@interface ViewController ()
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIImageView *imageView2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self sizeForJPGpicture];
    [self compressionRatio];//压缩
    
    self.imageView.image = [self imageWithImage:[UIImage imageNamed:@"pic.jpg"] scaledToSize:self.imageView.frame.size];
}
- (UIImageView *)imageView{
    if(_imageView == nil){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 60, 150, 200)];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}
- (UIImageView *)imageView2{
    if(_imageView2 == nil){
        _imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(250, 60, 150, 200)];
        [self.view addSubview:_imageView2];
    }
    return _imageView2;
}
- (void)sizeForJPGpicture{
    UIImage *image = [UIImage imageNamed:@"picture.jpg"];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"picture" ofType:@"jpg"];
    NSData *fData = [NSData dataWithContentsOfFile:path];//UIImageJPEGRepresentation(image, 0.5);//Representation描写
    Byte *testByte = (Byte *)[fData bytes];
    long length =0;
    for (long i=0; i<[fData length]; i++) {
        length +=testByte[i];
    }
    NSLog(@"testByte=%ld\n",length);
    //2015-12-30 10:27:33.963 图片压缩[5384:71787] testByte=5683756
    NSLog(@"%d",(int)fData.bytes);
    //2015-12-29 20:22:04.401 图片压缩[44149:596794] 4660469760
    //2015-12-29 20:22:18.672 图片压缩[44174:597329] 4769701888
    self.imageView.image = [UIImage imageWithData:fData];
    self.imageView2.image = image;
   
    FILE *fp = NULL;
    long fileLength = 0;
    //FILE * fopen(const char * path,const char * mode);
    
    const char *charPath = [path UTF8String];
    fp = fopen(charPath, "r");
    if(fp == NULL){
        NSLog(@"can't open file");
        return;
    }
    fseek(fp, 0, SEEK_END);//int fseek(FILE *stream, long offset, int fromwhere);函数设置文件指针stream的位置。第二个参数是相对于第三个参数偏移的位置
    fileLength = ftell(fp);//函数 ftell 用于得到文件位置指针当前位置相对于文件首的偏移字节数
    NSLog(@"文件大小为%ld",fileLength);
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *attr = [manager attributesOfItemAtPath:path error:nil];
    NSLog(@"%@\n%ld",attr,[attr[@"NSFileSize"] longValue]);
    
    
    CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
    void *data = (void *)CFDataGetBytePtr(CGDataProviderCopyData(provider));
    Byte *myByte = (Byte *)data;
    NSLog(@"--%d---",myByte[100]);
    int count = 0;
   
}
- (void)compressionRatio{
    ZipArchive *zip = [[ZipArchive alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = ([paths count]>0)?[paths objectAtIndex:0]:nil;
    NSString *l_zipfile = [documentpath stringByAppendingString:@"/test.zip"];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"pic" ofType:@"jpg"];
    
    BOOL ret = [zip CreateZipFile2:l_zipfile];
    
    ret = [zip addFileToZip:path newname:@"3.png"];
    
    if (![zip CloseZipFile2]) {
        l_zipfile = @"";
    }
    NSLog(@"%@",documentpath);
}
#pragma mark --图片尺寸进行压缩--
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size{
    CGPoint center = CGPointMake(image.size.width/2.f, image.size.height/2.f);
    CGRect frame = CGRectMake(center.x-size.width/2.f, center.y-size.height/2.f, size.width, size.height);
    
    
    CGImageRef ref = CGImageCreateWithImageInRect(image.CGImage, frame);
    
    
    return [UIImage imageWithCGImage:ref];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
