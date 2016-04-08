//
//  UIImage+ForceDecode.m
//  SDWebImageCache
//
//  Created by lizhongqiang on 16/4/5.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "UIImage+ForceDecode.h"

@implementation UIImage (ForceDecode)
#pragma mark --- 对image，进行解码操作从本地加载图片资源（或者从网络请求图片资源，再进行加载），在对图片资源加载完成后，会对需要显示的图片进行解码（一般解码操作，会放在一个后台线程中）
//注意：
/*   影响性能的方面：
 
     1.图片文件的加载速度同时受到 CPU 及 IO（输入/输出）延迟的影响
         IO 指的是例如闪存或者网络接口的硬件访问。
         IO 比内存访问更慢，所以如果涉及到IO，就是一个大问题(从磁盘加载图像或文件时间消耗昂贵，大约是从内存读取时间的10-1000倍)
       FastImageCache之所以能够加快Image的显示，主要是由于：
       1>   缓存了解码之后的rawData到文件中。为之后的加载节省了decode的时间
       2>   将文件中的rawdata直接映射到虚拟内存空间，利用缺页中断加载rawdata页面到RAM中。节省了创建buffer并填充buffer的时间
       3>   从rawdata创建UIImage时注意了字节对齐。节省了animation时为了字节对齐而执行copy_image操作的时间
     
     2.当加载图片的时候，iOS 通常会延迟解压图片的时间，知道加载到内存之后。这就会在准备绘制图片的时候影响性能，因为需要在绘制之前进行解压（通常是消耗时间的问题所在）
         解决延迟解压图片的方法：
         1.最简单的方法就是使用 UIImage 的 +imageNamed: 方法避免延迟加载，在加载图片之后立刻进行解压
         2.立刻加载图片的方法就是把它设置成图层内容，或者是 UIImageView 的 image 属性。不幸的是，这又需要在主线程执行，所以不会对性能有所提升
         3.第三种方式就是绕过 UIKit ，使用 ImageIO 框架
         4.使用UIKit加载图片，但是需要立刻将它绘制到 CGContext 中去，图片必须要在绘制之前解压，所以就要立即强制解压。这样做的好处在于绘制图片可以在后台线程中执行，而不会阻塞UI
         5.CATiledLayer 可以用来异步加载和显示大型图片，而不阻塞用户输入。（CATiledLayer 有一个有趣的特性：在多个线程中为每个小块同时调用 -drawLayer:inContext:方法。这就避免了阻塞用户交互而且能够利用多核心芯片来更快地绘制）
 
     创建UIImage实例将会在内存区生成一个图片的压缩版。但是压缩后的图像太小且无法渲染，如果我们从磁盘加载图像，图像甚至都没有加载到内存。这时候就需要对UIImage立面存储的压缩版图像进行解压，但是加压图片的过程是很消耗资源的！
 */
+(UIImage *)decodedImageWithImage:(UIImage *)image{
    CGImageRef imageRef = image.CGImage;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    CGRect imageRect = (CGRect){.origin = CGPointZero, .size = imageSize};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    int infoMask = (bitmapInfo & kCGBitmapAlphaInfoMask);
    BOOL anyNonAlpha = (infoMask == kCGImageAlphaNone ||
                        infoMask == kCGImageAlphaNoneSkipFirst ||
                        infoMask == kCGImageAlphaNoneSkipLast);
    
    if (infoMask == kCGImageAlphaNone && CGColorSpaceGetNumberOfComponents(colorSpace)) {
        bitmapInfo &= ~kCGBitmapAlphaInfoMask;
        
        bitmapInfo |= kCGImageAlphaNoneSkipFirst;
    }else if (!anyNonAlpha && CGColorSpaceGetNumberOfComponents(colorSpace)) {
        bitmapInfo &= ~kCGBitmapAlphaInfoMask;
        bitmapInfo |= kCGImageAlphaPremultipliedFirst;
    }
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 imageSize.width,
                                                 imageSize.height,
                                                 CGImageGetBitsPerComponent(imageRef),
                                                 0,
                                                 colorSpace,
                                                 bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    
    if (!context) {
        return image;
    }
    
    CGContextDrawImage(context, imageRect, imageRef);
    CGImageRef decompressedImageRef = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    
    UIImage *decompressedImage = [UIImage imageWithCGImage:decompressedImageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(decompressedImageRef);
    return decompressedImage;
}

@end
