//
//  ViewController.m
//  ImageIO框架
//
//  Created by lizhongqiang on 15/12/22.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>
@interface ViewController ()
{
    NSTimer *_timer;
}
@property (nonatomic, strong)UIImageView *imageview;
@property (nonatomic, assign)CGImageRef ref;
@property (nonatomic, assign)NSInteger value;

@end

@implementation ViewController
- (UIImageView *)imageview{
    if(_imageview == nil){
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(60, 100, 200, 200)];
        _imageview.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_imageview];
    }
    return _imageview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#if 0
    //可以通过以下方式来获取支持的图片格式
    CFArrayRef mySourceTypes = CGImageSourceCopyTypeIdentifiers();
    CFShow(mySourceTypes);
    
    CFArrayRef myDestinationTypes = CGImageDestinationCopyTypeIdentifiers();
    CFShow(myDestinationTypes);
    
#endif
    NSLog(@"%@",[NSDate date]);//2015-12-22 06:40:28 +0000
#if 0
    UIImage *image1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"图片" ofType:@"jpg"]];
    self.imageview.image = image1;
#endif
#if 1
    CGImageRef ref = MyCreateCGImageFromFile([[NSBundle mainBundle]pathForResource:@"图片" ofType:@"jpg"]);//MyCreateThumbnailCGImageFromURL([NSURL URLWithString:@"http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1505/30/c1/7676607_1432946559232_mthumb.jpg"], NSIntegerMax);
    ;
#endif
#if 0
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1505/30/c1/7676607_1432946559232_mthumb.jpg"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *  response, NSData *  data, NSError *  connectionError) {
        self.imageview.image = [UIImage imageWithData:data];
        NSLog(@"%@",connectionError);
    }];
#endif
#if 0
    UIImage *image = [UIImage imageWithCGImage:ref];
    NSLog(@"%@",[NSDate date]);//2015-12-22 06:40:28 +0000
    self.imageview.image = image;
    
    //[self writeCGImage:ref toURL:[NSURL URLWithString:@"http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1505/30/c1/7676607_1432946559232_mthumb.jpg"] withType:nil andOptions:NULL];
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSLog(@"%@",docDir);
    BOOL successed = saveImagepng(ref, docDir);
    //[self saveImage:ref path:docDir type:1 dpi:NSIntegerMax];
    NSLog(@"successed--->%d",successed);
#endif
    //self.imageview.image = [UIImage imageNamed:@"图片.jpg"];
#if 1
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateImage) userInfo:nil repeats:YES];
#endif
    
}
- (void)updateImage{
    self.value += 300000;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"图片" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if(self.value>=data.length){
        [_timer invalidate];
        _timer = nil;
    }
    CGImageRef ref = MyCreateIncrementallyImgSource(path,self.value);
    UIImage *image = [UIImage imageWithCGImage:ref];//[UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    NSLog(@"%@",[NSDate date]);//2015-12-22 06:40:28 +0000
    self.imageview.image = image;
    
}
/*
 当从Image Sources中创建图片时，可以提供一个index和dictionary（利用键值对）来创建一个缩略图或者是允许缓存。
 在创建图片的时候，也需提供一个index值来索引图片，因为Image Sources中可能是多张图片，
 如果参数时0，那么只有一个图片。可以通过CGImageSourceGetCount来获得图片在ImageSources中的数量。下面是两个例子。
 */
#pragma mark --下面是设置了缓存，并使用float-point的方式来编译--
CGImageRef MyCreateCGImageFromFile(NSString *path){
    NSURL *myurl = [NSURL URLWithString:@"http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1505/30/c1/7676607_1432946559232_mthumb.jpg"];//[[NSURL alloc]initFileURLWithPath:path];
    NSLog(@"%@",myurl);
    CGImageRef image;
    CGImageSourceRef imageSource;
    
    CFDictionaryRef imageOptions;
    CFStringRef imageKeys[2];
    CFTypeRef imageValues[2];
    
    //缓存键值对
    imageKeys[0]=kCGImageSourceShouldCache;
    imageValues[0]=(CFTypeRef)kCFBooleanTrue;
    //float-point键值对
    imageKeys[1]=kCGImageSourceShouldAllowFloat;
    imageValues[1]=(CFTypeRef)kCFBooleanTrue;
    //获取Dictionary，用来创建资源
    imageOptions = CFDictionaryCreate(NULL, (const void **)imageKeys, (const void **)imageValues, 2, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    //资源创建
    imageSource = CGImageSourceCreateWithURL((CFURLRef)myurl, imageOptions);
    CFRelease(imageOptions);
    
    if (imageSource==NULL){
        return NULL;
    }
    //图片获取，index=0
    NSLog(@"%lu",CGImageSourceGetCount(imageSource));
    image=CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    return  image;
}
//接下来是设置了缩略图
CGImageRef MyCreateThumbnailCGImageFromURL(NSURL *url,NSInteger imageSize){
    CGImageRef thumbnailImage;
    CGImageSourceRef imageSource;
    
    CFDictionaryRef imageOptions;
    CFStringRef imageKeys[3];
    CFTypeRef imageValues[3];
    
    CFNumberRef thumbnailSize;
    //先判断数据是否存在
    imageSource = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    
    if(imageSource==NULL){
        fprintf(stderr, "image source is NULL.");
        return NULL;
    }
    //创建缩略图等比缩放大小，会根据长度宽值比较大的作为imageSize进行缩放
    thumbnailSize = CFNumberCreate(NULL, kCFNumberIntType, &imageSize);
    
    imageKeys[0]=kCGImageSourceCreateThumbnailWithTransform;
    imageValues[0]=(CFTypeRef)kCFBooleanTrue;
    
    imageKeys[1]=kCGImageSourceCreateThumbnailFromImageIfAbsent;
    imageValues[1]=(CFTypeRef)kCFBooleanTrue;
    
    //缩放键值对
    imageKeys[2]=kCGImageSourceThumbnailMaxPixelSize;
    imageValues[2]=(CFTypeRef)thumbnailSize;
    
    imageOptions = CFDictionaryCreate(NULL, (const void**)imageKeys, (const void**)imageValues, 3, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    //获取缩略图
    thumbnailImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, imageOptions);
    CFRelease(imageOptions);
    CFRelease(thumbnailSize);
    CFRelease(imageSource);
    if (thumbnailImage==NULL){
        return NULL;
    }
    return thumbnailImage;
}
//渐进式图片加载----从代码可以看出，对于图片的二进制数据，网络传送，是先从头部，开始的
CGImageRef MyCreateIncrementallyImgSource(NSString *path,NSInteger value){
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    if(value>data.length){
        value = data.length;
    }else if (value == data.length){
        
    }
    data = [data subdataWithRange:NSMakeRange(0, value)];
    
    CGImageSourceRef incrementallyImgSource = CGImageSourceCreateIncremental(NULL);
    
    CGImageSourceUpdateData(incrementallyImgSource, (CFDataRef)data, NO);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(incrementallyImgSource, 0, NULL);
    CFRelease(incrementallyImgSource);
    return imageRef;
}
#pragma mark --将图片数据写入Image Destination--
#if 1
- (void)writeCGImage:(CGImageRef)image toURL:(NSURL *)url withType:(CFStringRef)imageType andOptions:(CFDictionaryRef)options{
    CGImageDestinationRef myImageDest = CGImageDestinationCreateWithURL((CFURLRef)url, CFSTR("example.jpg"), 1, nil);//imageType
    CGImageDestinationAddImage(myImageDest, image, options);//添加数据和图片
    CGImageDestinationFinalize(myImageDest);//最后调用，完成数据写入
    CFRelease(myImageDest);
    
}
#endif
BOOL saveImagepng(CGImageRef imageRef, NSString *strpath)
{
    NSString *finalPath = [NSString stringWithString:strpath];
    CFURLRef url = CFURLCreateWithFileSystemPath (
                                                  kCFAllocatorDefault,
                                                  (CFStringRef)finalPath,
                                                  kCFURLPOSIXPathStyle,
                                                  true);
    CGImageDestinationRef dest = CGImageDestinationCreateWithURL(url, CFSTR("public.png"), 1,NULL);
    assert(dest);
    CGImageDestinationAddImage(dest, imageRef, (CFDictionaryRef)@{(id)kCGImageDestinationLossyCompressionQuality : @(1.0)});
    assert(dest);
    if (dest == NULL) {
        NSLog(@"CGImageDestinationCreateWithURL failed");
    }
    //NSLog(@"%@", dest);
    assert(CGImageDestinationFinalize(dest));
    
    //这三句话用来释放对象
    CFRelease(dest);
    //CGImageRelease(imageRef);
    CFRelease(url);
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
