//
//  UIImage+My_Image.m
//  头像背景模糊化处理
//
//  Created by lizhongqiang on 16/1/20.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "UIImage+My_Image.h"
#import <Accelerate/Accelerate.h>
@implementation UIImage (My_Image)
#pragma mark ---- 方法一 效率高点-----------
//参数一，表示高斯函数中心焦点取均值的半径（卷基函数）。
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor

{
    
    //image must be nonzero size
    
    if (floorf(self.size.width) * floorf(self.size.height) <= 0.0f) return self;
    
    //boxsize must be an odd integer
    
    uint32_t boxSize = (uint32_t)(radius * self.scale);//表示高斯函数中心焦点的半径（卷基函数）。---在这里要想有模糊效应，必须得是奇数
    
    if (boxSize % 2 == 0) boxSize ++;
    
    //create image buffers
    
    CGImageRef imageRef = self.CGImage;
    //buffer1输入缓存
    //buffer2输出缓存
    //获取缓存的字节大小
    vImage_Buffer buffer1, buffer2;
    
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    
    size_t bytes = buffer1.rowBytes * buffer1.height;
    
    buffer1.data = malloc(bytes);
    
    buffer2.data = malloc(bytes);
    
    //创建临时缓存
    //create temp buffer
    //kvImageGetTempBufferSize函数将返回所需的临时缓冲区的字节数。如果这个值是负的,表示出现一个错误
    //第三个参数：是临时缓存，可传入也可不传入，不传入的时候，系统会自动生成一个临时缓存，但是使用完的时候自动释放
    //第四个、五个参数分别是x、y方向上偏移的像素
    //第六、七个参数必须为奇数
    //第八个参数为背景颜色
    //第九个参数：必须设置一个下列标志指定vImage如何处理像素的位置超出了源图像边缘的数据kvImageCopyInPlace,kvImageTruncateKernel,kvImageBackgroundColorFill或kvImageEdgeExtend。设置kvImageDoNotTile国旗如果您计划来执行自己的瓷砖或使用多线程
    void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
                                                                 
                                                                 NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));//malloc这个方法，在这里是为了获取足够多存储临时缓存的内存
    
    //copy image data
    
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);//输入缓存，第一次存储图像数据
    
    CFRelease(dataSource);
    
    for (NSUInteger i = 0; i < iterations; i++)
        
    {
        
        //perform blur
        //可变ARGB8888源图像中感兴趣的区域通过隐式M x N内核有一盒过滤的效果
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        //swap buffers交换数据-----为了反复叠加图像数据
        
        void *temp = buffer1.data;
        
        buffer1.data = buffer2.data;
        
        buffer2.data = temp;
        
    }
    
    //free buffers
    
    free(buffer2.data);
    
    free(tempBuffer);
    
    //create image context from buffer
    
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             
                                             CGImageGetBitmapInfo(imageRef));
    
    //apply tint
    
    if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f)
        
    {
        
        CGContextSetFillColorWithColor(ctx, [tintColor colorWithAlphaComponent:0.25].CGColor);
        
        CGContextSetBlendMode(ctx, kCGBlendModePlusLighter);
        
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
        
    }
    
    //create image from context
    
    imageRef = CGBitmapContextCreateImage(ctx);
    
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    
    CGImageRelease(imageRef);
    
    CGContextRelease(ctx);
    
    free(buffer1.data);
    
    return image;
    
}
#pragma mark ---- 方法二
- (UIImage *)blur{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *imageToBlur = [[CIImage alloc]initWithImage:self];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey,imageToBlur ,nil];
    
    CIImage *outputCIImage  = [filter outputImage];
    
    UIImage *img = [UIImage imageWithCGImage:[context createCGImage:outputCIImage fromRect:outputCIImage.extent]];
    
    return img;
    
}
#pragma mark ----- 方法三
//iOS8苹果自带的毛玻璃效果

#pragma mark ----- 方法四
//GPUImage---http://www.cocoachina.com/industry/20140210/7793.html实时毛玻璃效果主要依赖的是 GPU 性能，但更重要的还是软件的优化。
@end
