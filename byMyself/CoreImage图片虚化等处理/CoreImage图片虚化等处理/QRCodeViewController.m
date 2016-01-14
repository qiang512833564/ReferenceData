//
//  QRCodeViewController.m
//  CoreImage图片虚化等处理
//
//  Created by lizhongqiang on 15/9/8.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];//二维码的时候，这里设背景颜色，有时候，是需要的（生成后，如果显示不了，可以设置下试试）
    // Do any additional setup after loading the view.
    [self dealWithStringToQRCode:@"https://github.com/KenmuHuang"];//前面如果不加“//”则仅仅是显示链接，而不打开链接------
}
- (void)dealWithStringToQRCode:(NSString *)string
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];//---设置纠错等级越高；即识别越容易，值可设置为L(Low) |  M(Medium) | Q | H(High)
    
    CIImage *outputImage = [filter outputImage];
#if 0
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
#endif
    UIImage *image = [QRCodeViewController resizeQRCodeImage:outputImage withSize:250];//这里的size是imageView的宽度
    UIImage * newImage = [QRCodeViewController specialColorImage:image withRed:52.0 green:157.0 blue:250.0];
    UIImage *icon = [QRCodeViewController createRoundedRectImage:[self createGrayImage] withSize:CGSizeMake(70, 70) withRadius:20];
    newImage = [QRCodeViewController addIconToQRCodeImage:newImage withIcon:icon withIconSize:icon.size];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:newImage];
    imageView.frame = CGRectMake(80, 90, 250, 250);
    [self.view addSubview:imageView];
    imageView.layer.shadowOffset = CGSizeMake(0, 2);
    imageView.layer.shadowRadius = 2;
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    imageView.layer.shadowOpacity = 0.5;
}

- (UIImage *)createGrayImage
{
    CGSize size = CGSizeMake(1, 1);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, CGRectMake(0, 0, size.width, size.height));
    CGContextSetFillColorWithColor(ctx, [UIColor grayColor].CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
static void addRoundedRectToPath(CGContextRef contextRef, CGRect rect, float widthOfRadius, float heightOfRadius) {
         float fw, fh;
         if (widthOfRadius == 0 || heightOfRadius == 0)
         {
            CGContextAddRect(contextRef, rect);
            return;
         }

         CGContextSaveGState(contextRef);
         CGContextTranslateCTM(contextRef, CGRectGetMinX(rect), CGRectGetMinY(rect));
         CGContextScaleCTM(contextRef, widthOfRadius, heightOfRadius);
         fw = CGRectGetWidth(rect) / widthOfRadius;
         fh = CGRectGetHeight(rect) / heightOfRadius;
    
         CGContextMoveToPoint(contextRef, fw, fh/2);  // Start at lower right corner
         CGContextAddArcToPoint(contextRef, fw, fh, fw/2, fh, 1);  // Top right corner
         CGContextAddArcToPoint(contextRef, 0, fh, 0, fh/2, 1); // Top left corner
         CGContextAddArcToPoint(contextRef, 0, 0, fw/2, 0, 1); // Lower left corner
         CGContextAddArcToPoint(contextRef, fw, 0, fw, fh/2, 1); // Back to lower right
    
         CGContextClosePath(contextRef);
         CGContextRestoreGState(contextRef);
}
+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius {
        int w = size.width;
        int h = size.height;
    
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
        CGRect rect = CGRectMake(0, 0, w, h);

        CGContextBeginPath(contextRef);
        addRoundedRectToPath(contextRef, rect, radius, radius);
        CGContextClosePath(contextRef);
        CGContextClip(contextRef);
        CGContextDrawImage(contextRef, CGRectMake(0, 0, w, h), image.CGImage);
         CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
         UIImage *img = [UIImage imageWithCGImage:imageMasked];
    
         CGContextRelease(contextRef);
         CGColorSpaceRelease(colorSpaceRef);
         CGImageRelease(imageMasked);
         return img;
}
+ (UIImage *)resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size {
         CGRect extent = CGRectIntegral(image.extent);
         CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
         size_t width = CGRectGetWidth(extent) * scale;//CGRectGetWidth(extent)获取横向的像素点的个数
         size_t height = CGRectGetHeight(extent) * scale;
         //创建色彩空间对象
         CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    
        CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, width*4, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    /*
     一个新的位图上下文的像素格式由三个参数决定：每个组件的位数，颜色空间，alpha选项
     CGContextRef CGBitmapContextCreate (
     
     void *data,指向要渲染的绘制内存的地址。这个内存块至少是（bytesPerRow*height）个字节
     size_t width,bitmap的宽度，单位为像素
     size_t height,bitmap的高度，单位为像素
     size_t bitsPerComponent,内存中像素的每个组件的位数。例如，对32位像素格式和RGB颜色空间，应该将这个值设为8
     size_t bytesPerRow,bitmap的每一行在内存中所占的比特数---//每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit(0-255)的空间
     CGColorSpaceRef colorspace,bitmap上下文使用的颜色空间
     CGBitmapInfo bitmapInfo,指定bitmap是否包含alpha通道，像素中alpha通道的相对位置，像素组件是整形还是浮点型等信息的字符串。
     );
     */
         CIContext *context = [CIContext contextWithOptions:nil];
         CGImageRef imageRef = [context createCGImage:image fromRect:extent];
         CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
         CGContextScaleCTM(contextRef, scale, scale);
         CGContextDrawImage(contextRef, extent, imageRef);
    
         CGImageRef imageRefResized = CGBitmapContextCreateImage(contextRef);

         //Release
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
   return [UIImage imageWithCGImage:imageRefResized];
}
void ProviderReleaseData (void *info, const void *data, size_t size){
       free((void*)data);
}

+ (UIImage *)specialColorImage:(UIImage*)image withRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
         const int imageWidth = image.size.width;
         const int imageHeight = image.size.height;
         size_t bytesPerRow = imageWidth * 4;
         uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);//占得内存空间--//开辟内存（用于存储所有像素）
    
         //Create context
         //创建色彩空间对象
         CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();////创建依赖于设备的RGB通道
         CGContextRef contextRef = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
         //CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){0.01f, 0.99f, 0.01f, 1.0f});
         CGContextDrawImage(contextRef, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
         //Traverse pixe
         int pixelNum = imageWidth * imageHeight;
         uint32_t* pCurPtr = rgbImageBuf;//下面是获取每个像素的RGB，每个像素数组中存了三个值，分别对应着R、G、B
         for (int i = 0; i < pixelNum; i++, pCurPtr++){
                 if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
                         //Change color
                         uint8_t* ptr = (uint8_t*)pCurPtr;
                         ptr[3] = red; //0~255
                         ptr[2] = green;
                         ptr[1] = blue;
                     }else{
                             uint8_t* ptr = (uint8_t*)pCurPtr;
                             ptr[0] = 0;
                       }
            }
    
         //Convert to image
        CGDataProviderRef dataProviderRef = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
        CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProviderRef,NULL, true, kCGRenderingIntentDefault);
         CGDataProviderRelease(dataProviderRef);
         UIImage* img = [UIImage imageWithCGImage:imageRef];
    
         //Release
         CGImageRelease(imageRef);
         CGContextRelease(contextRef);
         CGColorSpaceRelease(colorSpaceRef);
    return img;
}
+(UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize {
         UIGraphicsBeginImageContext(image.size);
         //通过两张图片进行位置和大小的绘制，实现两张图片的合并；其实此原理做法也可以用于多张图片的合并
         CGFloat widthOfImage = image.size.width;
         CGFloat heightOfImage = image.size.height;
         CGFloat widthOfIcon = iconSize.width;
         CGFloat heightOfIcon = iconSize.height;
    
         [image drawInRect:CGRectMake(0, 0, widthOfImage, heightOfImage)];
         [icon drawInRect:CGRectMake((widthOfImage-widthOfIcon)/2, (heightOfImage-heightOfIcon)/2,widthOfIcon, heightOfIcon)];
         UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
         UIGraphicsEndImageContext();
         return img;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
