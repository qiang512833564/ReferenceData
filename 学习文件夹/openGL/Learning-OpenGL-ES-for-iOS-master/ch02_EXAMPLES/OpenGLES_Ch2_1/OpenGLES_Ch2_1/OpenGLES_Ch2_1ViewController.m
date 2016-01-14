//
//  OpenGLES_Ch2_1ViewController.m
//  OpenGLES_Ch2_1
//

#import "OpenGLES_Ch2_1ViewController.h"
/*
 帧缓存：前帧缓存、后帧缓存
 前帧缓存：存储屏幕显示要素
 后帧缓存：保顿渲染结果
 */
@implementation OpenGLES_Ch2_1ViewController

@synthesize baseEffect;

/////////////////////////////////////////////////////////////////
// This data type is used to store information for each vertex
typedef struct {
   GLKVector3  positionCoords;
}
SceneVertex;

/////////////////////////////////////////////////////////////////
// Define vertex data for a triangle to use in example
static const SceneVertex vertices[] = 
{//经测试-----虽然openGL ES坐标系没有单位，但是该坐标系的原点是相当于屏幕的中心点，然后对于与OpenGL ES的坐标为左边-1，右边1，上边1，下边-1，这样比例对应
   {{-0.5f, -0.5f, 0.0}}, // lower left corner
   {{ 0.5f, -0.5f, 0.0}}, // lower right corner
   {{-0.5f,  1.0f, 0.0}}  // upper left corner
};


/////////////////////////////////////////////////////////////////
// Called when the view controller's view is loaded
// Perform initialization before the view is asked to draw
- (void)viewDidLoad
{
   [super viewDidLoad];
   
   // Verify the type of view created automatically by the
   // Interface Builder storyboard
   GLKView *view = (GLKView *)self.view;
   NSAssert([view isKindOfClass:[GLKView class]],
      @"View controller's view is not a GLKView");
   
   // Create an OpenGL ES 2.0 context and provide it to the
   // view
   view.context = [[EAGLContext alloc] 
      initWithAPI:kEAGLRenderingAPIOpenGLES2];
   
   // Make the new context current
   [EAGLContext setCurrentContext:view.context];
   
   // Create a base effect that provides standard OpenGL ES 2.0
   // Shading Language programs and set constants to be used for 
   // all subsequent rendering
   self.baseEffect = [[GLKBaseEffect alloc] init];
   self.baseEffect.useConstantColor = GL_TRUE;
   self.baseEffect.constantColor = GLKVector4Make(
      1.0f, // Red
      1.0f, // Green
      1.0f, // Blue
      1.0f);// Alpha
   
   // Set the background color stored in the current context 
   glClearColor(0.0f, 0.0f, 0.0f, 1.0f); // background color
   
   // Generate, bind, and initialize contents of a buffer to be 
   // stored in GPU memory
   glGenBuffers(1,                // STEP 1--生成（第一个参数：用于指定要生成的缓存标识符的数量，第二个参数是一个指针，指向生成的标识符的内存保存位置。）
      &vertexBufferID);
   glBindBuffer(GL_ARRAY_BUFFER,  // STEP 2--绑定（第一个参数：GL_ARRAY_BUFFE类型用于指定一个顶点属性数组，例如本例中三角形顶点的位置；第二个参数：是要绑定的缓存的标识符，缓存标识符实际上是无符号整形，0值表示没有缓存。）
      vertexBufferID); 
   glBufferData(                  // STEP 3--缓存数据，复制应用的顶点数据到当前上下文所绑定的顶点缓存中。
      GL_ARRAY_BUFFER,  // Initialize buffer contents
      sizeof(vertices), // Number of bytes to copy
      vertices,         // Address of bytes to copy
      GL_STATIC_DRAW);  // Hint: cache in GPU memory--提示了缓存在未来的运算中可能将会被怎样使用。
      /*
       GL_STATIC_DRAW提示会告诉上下文，缓存中的内容复制到CUP控制的缓存，因为很少对其进行修改（STATIC静态）
       这个信息可以帮助OpenGL ES优化内存使用。
       GL_DYNAMIC_DRAW作为提示会告诉上下文，缓存中的数据会被平凡改变，同时提示OpenGL ES以不同的方式来处理缓存的存储（DYNAMIC动态）
       */
}


/////////////////////////////////////////////////////////////////
// GLKView delegate method: Called by the view controller's view
// whenever Cocoa Touch asks the view controller's view to
// draw itself. (In this case, render into a frame buffer that
// shares memory with a Core Animation Layer)
//每当一个GLKView实例需要被重绘时，它都会保存在视图的上下文属性中的OpenGL ES的上下文成为当前上下文。
//如果需要的话，GLKView实例会绑定与一个Core Animation层分享的帧缓存
//下面的委托方法的实现告诉baseEffect准备好当前OpenGL ES的上下文，
//以便为使用baseEffect生成的属性和Shading Language程序的绘图做好准备
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
   [self.baseEffect prepareToDraw];
   
   // Clear Frame Buffer (erase previous drawing)
   // glClear()函数来设置当前绑定的帧缓存的像素颜色渲染缓存中的每一个像素的颜色为前面使用glClearColor()函数设定的值
   // glClear()函数会有效地设置帧缓存中的每一个像素的颜色为背景颜色。
   glClear(GL_COLOR_BUFFER_BIT);
   
   // Enable use of positions from bound vertex buffer
   glEnableVertexAttribArray(      // STEP 4----启动顶点缓存渲染操作
      GLKVertexAttribPosition);    //OpenGL ES所支持的每一个渲染操作都可以单独地使用保存在当前OpenGLES上下文中的设置来开启或关闭å
      
   glVertexAttribPointer(          // STEP 5----该函数会告诉OpenGL ES顶点数据在哪里以及怎么解释为每个顶点保存的数据，
                                   // 设置指针（告诉OpenGL ES在缓存中的数据的类型和所需要访问的数据的内存偏移值）
      GLKVertexAttribPosition, //指示当前绑定的缓存包含每个顶点的位置信息。
      3,                   // 指示每个顶点位置有三个值
      GL_FLOAT,            // 告诉OpenGL ES每个部分都保存为一个浮点类型的值
      GL_FALSE,            // 告诉OpenGL ES小数点固定数据是否可以被改变。
      sizeof(SceneVertex), // 指定了每个顶点的保存需要多少个字节
      NULL);               // 参数为NULL，告诉OpenGL ES可以从当前绑定的顶点缓存的开始位置访问顶点数据。
                                   
   // Draw triangles using the first three vertices in the 
   // currently bound vertex buffer
   glDrawArrays(           // STEP 6---绘图（告诉OpenGL ES使用当前绑定并启用的缓存中的数据渲染整个场景或者某个场景的一部分）
      GL_TRIANGLES,//---告诉GPU怎么处理在绑定的顶点缓存内的顶点数据。这个例子会指示OpenGL ES去渲染三角形
      0,  // 指定缓存内的需要渲染的第一个顶点的位置
      3); // 指定需要渲染的顶点的数量。
}


/////////////////////////////////////////////////////////////////
// 视图被卸载时调用
// 卸载的视图将不再被绘制，因此任何指示在绘制时需要的OpenGL ES缓存都可以被安全地删除。
- (void)viewDidUnload
{
   [super viewDidUnload];
   
   // Make the view's context current
   GLKView *view = (GLKView *)self.view;
   [EAGLContext setCurrentContext:view.context];
    
   // Delete buffers that aren't needed when view is unloaded
   if (0 != vertexBufferID)
   {
      glDeleteBuffers (1,          // STEP 7 ------删除（告诉OpenGL ES删除以前生成的缓存并释放相关的资源）
                       &vertexBufferID);  
      vertexBufferID = 0;//设置为0，是为了避免在对应的缓存被删除以后还使用其无效的标识符。
   }
   
   // Stop using the context created in -viewDidLoad
   ((GLKView *)self.view).context = nil;
   [EAGLContext setCurrentContext:nil];
    ////设置视图的上下文属性为nil并设置当前上下文为nil,以便让Cocoa Touch收回所有上下文使用的内存和其他资源。
}

@end
