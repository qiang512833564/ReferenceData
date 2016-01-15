//
//  ViewController.m
//  HelloGL
//
//  Created by lizhongqiang on 15/10/26.
//  Copyright (c) 2015年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize context,effect;

GLfloat squareVertexData[48] = //这是一个正方形顶点的数组，实际上它是由二个三角形接合而成的。
{
    0.5f,   0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
    -0.5f,   0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
    0.5f,  -0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
    0.5f,  -0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
    -0.5f,   0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
    -0.5f,  -0.5f,  -0.9f,  0.0f,   0.0f,   1.0f,   1.0f,   1.0f,
};
/*
 每行顶点数据的排列含义是：
 顶点X、顶点Y，顶点Z、法线X、法线Y、法线Z、纹理S、纹理T。
 在后面解析此数组时，将参考此规则。
 顶点位置用于确定在什么地方显示，法线用于光照模型计算，纹理则用在贴图中。
 一般约定为“顶点以逆时针次序出现在屏幕上的面”为“正面”。
 世界坐标是OpenGL中用来描述场景的坐标，Z+轴垂直屏幕向外，X+从左到右，Y+轴从下到上，是右手笛卡尔坐标系统。我们用这个坐标系来描述物体及光源的位置。
 */

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //使用“ES2”创建一个“EAGLEContext”实例
    self.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    //将“View”的context设置为这个“EAGLContext”实例的引用。并且设置颜色格式和深度格式。
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    //将此“EAGLContext”实例设置为OpenGL的“当前激活”的“context”。
    //这样，以后所有“GL”的指令均作用在这个“context”上。
    //随后，发送第一个“GL”指令：激活“深度检测”。
    [EAGLContext setCurrentContext:context];
    glEnable(GL_DEPTH_TEST);
    
    //创建一个GLK内置的“着色效果”,并给它提供一个光源，光的颜色为绿色。
    self.effect = [[GLKBaseEffect alloc]init];
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(1.0, 1.0, 1.0, 1.0);
    // Do any additional setup after loading the view, typically from a nib.
    
    //2.顶点数组保存进缓存区
    //申明一个缓冲区的标识（GLuint类型）让OpenGL自动分配一个缓冲区并且返回这个标识的值。
    //绑定这个缓冲区到当前“Context”。
    //最后，讲我们前面预先定义的顶点数据“squareVertexData”复制进这个缓冲区中。
    
    //注：参数“GL_STATIC_DRAW”,它表示此缓冲区内容只能被修改一次，但可以无限次读取。
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData), squareVertexData, GL_STATIC_DRAW);
    
    //3.将缓冲区的数据复制进能用顶点属性中
    //首先，激活顶点属性（默认它是关闭的）
    //顶点属性集中包含五个属性：位置、法线、颜色、纹理0、纹理1（它们的索引值是0到4）
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    //激活后，接下来使用“glVertexAttribPointer”方法填充数据
    /*参数含义分别为：
    顶点属性索引（这里是位置）、3个分量的矢量、类型是浮点（GL_FLOAT）、填充时不需要单位化（GL_FALSE）、在数据数组中每行的跨度是32个字节（4*8=32。从预定义的数组中可看出，每行有8个GL_FLOAT浮点值，而GL_FLOAT占4个字节，因此每一行的跨度是4*8）。
    最后一个参数是一个偏移量的指针，用来确定“第一个数据”将从内存数据块的什么地方开始。*/
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 4*8, (char*)NULL+0);
    
    //4、继续复制其他数据
    /*
     在前面定义了项点数据数组中，还包含了法线和纹理坐标，所以参照上面的方法，将剩余的数据分别复制进能用顶点属性
     */
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 4*8, (char*)NULL + 12 );
    /*
     原则上，必须先“激活”某个索引，才能将数据复制进这个索引表示的内存中。
     因为纹理坐标只有两个（S和T），所以上面参数是“2”。
     */
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 4*8, (char *)NULL+24);
    
    /*
     GLKit加载纹理，默认都是把坐标设置在“左上角”。然而，OpenGL的纹理贴图坐标却是在左下角，这样刚好颠倒。
     在加载纹理之前，添加一个“options”：
     */
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Tulips" ofType:@"jpg"];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],GLKTextureLoaderOriginBottomLeft ,nil];
    NSError *error;
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:&error];
    self.effect.texture2d0.enabled = GL_TRUE;
    self.effect.texture2d0.name = textureInfo.name;
    NSLog(@"%@",error);
   
}
/*
 五、执行渲染循环
 
 万事具备，现在可以让OpenGL显示一些东西了。

 在GLKit框架中，尽管OpenGL的行为，是由“GLKViewController”和“GLKView”联合控制的，但实际上“GLKView”类中完全不需要写任何自己的代码，因为，“GLKView”类中每帧触发的两个方法“update”和“glkView”，都转交给“GLKViewController”代理执行了。
 */
/*
 这两个方法每帧都执行一次（循环执行），一般执行频率与屏幕刷新率相同（但也可以更改）。
 
 第一次循环时，先调用“glkView”再调用“update”。
 
 一般，将场景数据变化放在“update”中，而渲染代码则放在“glkView”中。
 */
- (void)update
{
    //六、正确显示正方形外观
    /*
     默认，“Effect”的投影矩阵是一个单位矩阵，它不做任何变换，将场景（-1，-1，-1）到（1，1，1）的立文体范围的物体，投射到屏幕的X：-1，1，Y：-1，1。因此，当屏幕本身是非正方形时，正方形的物体将被拉伸，从而显示为矩形。
     
     实际上，默认的“Effect”模型视图矩阵也是一个单位矩阵。
     
     透视投影中的观察点位于原点（0，0，0），并沿着Z轴的负方向进行观察，就像是从屏幕内部看进去。
     
     */
#if 1
    CGSize size = self.view.bounds.size;
    //首先计算出屏幕的纵横比（aspect），然后缩放单位矩阵的Y轴，强制将Y轴的单位刻度与X轴保持一致。
    float aspect = fabsf(size.width/size.height);
    //GLKMatrix4 projectionMatrix = GLKMatrix4Identity;
    //projectionMatrix = GLKMatrix4Scale(projectionMatrix, 1.0f, aspect, 1.0f);
    
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0), aspect, 0.1f, 10.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4Translate(GLKMatrix4Identity, 0.0, 0.0, -1.0f);
    self.effect.transform.modelviewMatrix = modelViewMatrix;
    
   
#endif
}
/*
 前两行为渲染前的“清除”操作，清除颜色缓冲区和深度缓冲区中的内容，并且填充淡蓝色背景（默认背景是黑色）。
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    
    [self.effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
}
/*
 prepareToDraw”方法，是让“效果Effect”针对当前“Context”的状态进行一些配置，它始终把“GL_TEXTURE_PROGRAM”状态定位到“Effect”对象的着色器上。此外，如果Effect使用了纹理，它也会修改“GL_TEXTURE_BINDING_2D”。
 
 接下来，用“glDrawArrays”指令，让OpenGL“画出”两个三角形（拼合为一个正方形）。OpenGL会自动从通用顶点属性中取出这些数据、组装、再用“Effect”内置的着色器渲染。
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
