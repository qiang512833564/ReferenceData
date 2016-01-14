//
//  AGLKTextureLoader.m
//  OpenGLES_Ch3_2
//

#import "AGLKTextureLoader.h"

/////////////////////////////////////////////////////////////////
// This data type is used specify power of 2 values.  OpenGL ES 
// best supports texture images that have power of 2 dimensions.
typedef enum
{
   AGLK1 = 1,
   AGLK2 = 2,
   AGLK4 = 4,
   AGLK8 = 8,
   AGLK16 = 16,
   AGLK32 = 32,
   AGLK64 = 64,
   AGLK128 = 128,
   AGLK256 = 256,
   AGLK512 = 512,
   AGLK1024 = 1024,
} 
AGLKPowerOf2;


/////////////////////////////////////////////////////////////////
// Forward declaration of function
static AGLKPowerOf2 AGLKCalculatePowerOf2ForDimension(
   GLuint dimension);

/////////////////////////////////////////////////////////////////
// Forward declaration of function
static NSData *AGLKDataWithResizedCGImageBytes(
   CGImageRef cgImage,
   size_t *widthPtr,
   size_t *heightPtr);
                              
/////////////////////////////////////////////////////////////////
// Instances of AGLKTextureInfo are immutable once initialized
@interface AGLKTextureInfo (AGLKTextureLoader)

- (id)initWithName:(GLuint)aName
   target:(GLenum)aTarget
   width:(size_t)aWidth
   height:(size_t)aHeight;
   
@end


@implementation AGLKTextureInfo (AGLKTextureLoader)

/////////////////////////////////////////////////////////////////
// This method is the designated initializer.
- (id)initWithName:(GLuint)aName
   target:(GLenum)aTarget
   width:(size_t)aWidth
   height:(size_t)aHeight
{
    if (nil != (self = [super init])) 
    {
        name = aName;
        target = aTarget;
        width = aWidth;
        height = aHeight;
    }
    
    return self;
}

@end


@implementation AGLKTextureInfo

@synthesize name;
@synthesize target;
@synthesize width;
@synthesize height;

@end


@implementation AGLKTextureLoader

/////////////////////////////////////////////////////////////////
// This method generates a new OpenGL ES texture buffer and 
// initializes the buffer contents using pixel data from the 
// specified Core Graphics image, cgImage. This method returns an
// immutable AGLKTextureInfo instance initialized with 
// information about the newly generated texture buffer.
//    The generated texture buffer has power of 2 dimensions. The
// provided image data is scaled (re-sampled) by Core Graphics as
// necessary to fit within the generated texture buffer.
+ (AGLKTextureInfo *)textureWithCGImage:(CGImageRef)cgImage                           options:(NSDictionary *)options
   error:(NSError **)outError; 
{
   // Get the bytes to be used when copying data into new texture
   // buffer
   size_t width;
   size_t height;
   NSData *imageData = AGLKDataWithResizedCGImageBytes(
      cgImage,
      &width,
      &height);
   
   // Generation, bind, and copy data into a new texture buffer
   GLuint      textureBufferID;
   /*
    glGenTextures()和glBindTexture()函数与用于顶点缓存的命名方式相似的函数的工作方式相同。
    */
   glGenTextures(1, &textureBufferID);                  // Step 1
   glBindTexture(GL_TEXTURE_2D, textureBufferID);       // Step 2
   //复制图片像素的颜色数据到绑定的纹理缓存中。
   glTexImage2D(                                        // Step 3
      GL_TEXTURE_2D, //参数1：用于2D纹理的GL_TEXTURE_2D
      0,             //参数2：用于指定MIP贴图的初始细节级别，如果没有使用MIP贴图，该参数必须是0
      GL_RGBA,       //参数3：internalFormat用于指定在纹理缓存内每个纹理需要保存的信息的数量（对于iOS设备来说，纹理信息要么是GL_RGB,要么是GL_RGBA--其中：RGB为每个纹素保存红、绿、蓝三种颜色元素，RGBA保存一个额外的用于指定每个纹素透明度的透明度元素）
      width,         //参数4：指定图像的宽度
      height,        //参数5：指定图像的高度（高度和宽度需要是2的幂）
      0,             //参数6：border参数一直是用来确定围绕纹理的纹素的一个边界的大小，但是在OpenGL ES中它总是被设置为0。
      GL_RGBA,       //参数7：format用于指定初始化缓存所使用的图像数据中的每个像素索要保存的信息，这个参数应该总是与internalFormat参数相同。其他的OpenGL版本可能在format和internalFormat参数不一致时自动执行图像数据格式的转换。
      GL_UNSIGNED_BYTE, //参数8：用于指定缓存中的纹素数据所使用的位编码类型。GL_UNSIGNED_BYTE会提供最佳色彩质量，但是它每个纹素中每个颜色元素的保存需要一个字节的存储空间。结果是每次取样一个RGB类型的纹素，GPU都必须最少读取3字节（24位），每个RGBA类型的纹素需要读取4字节（32位）。
                       //GL_UNSIGNED_SHORT_4_4_4_4格式平均为每个纹素的颜色元素使用4位
      [imageData bytes]);//参数9：是一个要被复制到绑定的纹理缓存中的图片的像素颜色数据的指针。
   
   // Set parameters that control texture sampling for the bound
   // texture
    //取样
  glTexParameteri(GL_TEXTURE_2D, 
     GL_TEXTURE_MIN_FILTER, 
     GL_LINEAR); 
   
   // Allocate and initialize the AGLKTextureInfo instance to be
   // returned
   AGLKTextureInfo *result = [[AGLKTextureInfo alloc] 
      initWithName:textureBufferID
      target:GL_TEXTURE_2D
      width:width
      height:height];
   
   return result;
}
                                 
@end


/////////////////////////////////////////////////////////////////
// This function returns an NSData object that contains bytes
// loaded from the specified Core Graphics image, cgImage. This
// function also returns (by reference) the power of 2 width and 
// height to be used when initializing an OpenGL ES texture buffer
// with the bytes in the returned NSData instance. The widthPtr 
// and heightPtr arguments must be valid pointers.
static NSData *AGLKDataWithResizedCGImageBytes(
   CGImageRef cgImage,
   size_t *widthPtr,
   size_t *heightPtr)
{
   NSCParameterAssert(NULL != cgImage);
   NSCParameterAssert(NULL != widthPtr);
   NSCParameterAssert(NULL != heightPtr);
   
   size_t originalWidth = CGImageGetWidth(cgImage);
   size_t originalHeight = CGImageGetWidth(cgImage);
   
   NSCAssert(0 < originalWidth, @"Invalid image width");
   NSCAssert(0 < originalHeight, @"Invalid image width");
   
   // Calculate the width and height of the new texture buffer
   // The new texture buffer will have power of 2 dimensions.
   size_t width = AGLKCalculatePowerOf2ForDimension(
      originalWidth);
   size_t height = AGLKCalculatePowerOf2ForDimension(
      originalHeight);
      
   // Allocate sufficient storage for RGBA pixel color data with 
   // the power of 2 sizes specified
   NSMutableData    *imageData = [NSMutableData dataWithLength:
      height * width * 4];  // 4 bytes per RGBA pixel

   NSCAssert(nil != imageData, 
      @"Unable to allocate image storage");
   
   // Create a Core Graphics context that draws into the 
   // allocated bytes
   CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
   CGContextRef cgContext = CGBitmapContextCreate( 
      [imageData mutableBytes], width, height, 8, 
      4 * width, colorSpace, 
      kCGImageAlphaPremultipliedLast);
   CGColorSpaceRelease(colorSpace);
   
   // Flip the Core Graphics Y-axis for future drawing
   CGContextTranslateCTM (cgContext, 0, height);
   CGContextScaleCTM (cgContext, 1.0, -1.0);
   
   // Draw the loaded image into the Core Graphics context 
   // resizing as necessary
   CGContextDrawImage(cgContext, CGRectMake(0, 0, width, height),
      cgImage);
   
   CGContextRelease(cgContext);
   
   *widthPtr = width;
   *heightPtr = height;
   
   return imageData;
}


/////////////////////////////////////////////////////////////////
// 因为Core Graphics吧cgImage拖入一个适当大小的Core Graphics上下文中，这个过程的一个副作用使吧图像的尺寸调整为了2的幂
// 图像再被绘制的时候还会被翻转了
// This function calculates and returns the nearest power of 2 这个函数计算并返回最近的2的幂
// that is greater than or equal to the dimension argument and 这是大于或等于尺寸参数和
// less than or equal to 1024.小于或等于1024。
static AGLKPowerOf2 AGLKCalculatePowerOf2ForDimension(
   GLuint dimension)
{
   AGLKPowerOf2  result = AGLK1;
   
   if(dimension > (GLuint)AGLK512)
   {
      result = AGLK1024;
   }
   else if(dimension > (GLuint)AGLK256)
   {
      result = AGLK512;
   }
   else if(dimension > (GLuint)AGLK128)
   {
      result = AGLK256;
   }
   else if(dimension > (GLuint)AGLK64)
   {
      result = AGLK128;
   }
   else if(dimension > (GLuint)AGLK32)
   {
      result = AGLK64;
   }
   else if(dimension > (GLuint)AGLK16)
   {
      result = AGLK32;
   }
   else if(dimension > (GLuint)AGLK8)
   {
      result = AGLK16;
   }
   else if(dimension > (GLuint)AGLK4)
   {
      result = AGLK8;
   }
   else if(dimension > (GLuint)AGLK2)
   {
      result = AGLK4;
   }
   else if(dimension > (GLuint)AGLK1)
   {
      result = AGLK2;
   }
   
   return result;
}
