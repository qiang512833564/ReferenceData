/* ===========================================================================
 
 Copyright (c) 2010 Edward Patel
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 =========================================================================== */

#import "Demo2Transition.h"

@implementation Demo2Transition

- (void)setupTransition
{
    // Setup matrices
    /*
     mode 指定哪一个矩阵堆栈是下一个矩阵操作的目标,可选值: GL_MODELVIEW、GL_PROJECTION、GL_TEXTURE.
     说明
     glMatrixMode设置当前矩阵模式:
     GL_MODELVIEW,对模型视景矩阵堆栈应用随后的矩阵操作.
     GL_PROJECTION,对投影矩阵应用随后的矩阵操作.
     GL_TEXTURE,对纹理矩阵堆栈应用随后的矩阵操作.
     与glLoadIdentity()一同使用
     glLoadIdentity():将当前的用户坐标系的原点移到了屏幕中心：类似于一个复位操作
     在glLoadIdentity()之后我们为场景设置了透视图。glMatrixMode(GL_MODELVIEW)设置当前矩阵为模型视图矩阵，模型视图矩阵储存了有关物体的信息。
     */
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
        case UIInterfaceOrientationPortrait://在竖屏模式，垂直向上
            break;
        case UIInterfaceOrientationPortraitUpsideDown://在竖屏模式，垂直方向上下颠倒
            glRotatef(180, 0, 0, 1);
            break;
        case UIInterfaceOrientationLandscapeLeft://设备逆时针旋转到横屏模式
            glRotatef( 90, 0, 0, 1);
            break;
        case UIInterfaceOrientationLandscapeRight://设备顺时针旋转到横屏模式
            glRotatef(-90, 0, 0, 1);//glRotatef转动方向
            break;
    }
    //设置投影视角
    //它是将当前矩阵与一个透视矩阵相乘，把当前矩阵转变成透视矩阵，
    //在使用它之前，通常会先调用glMatrixMode(GL_PROJECTION).
    glFrustumf(-0.1*1.0/0.4, 0.1*1.0/0.4,
               -0.15*1.0/0.4, 0.15*1.0/0.4, 
               1.0, 10.0);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    //glClear(GL_DEPTH_BUFFER_BIT);
    //用于启用各种功能。具体功能由参数决定。与glDisable相对应。glDisable用以关闭各项功能。
    glEnable(GL_CULL_FACE);//根据函数glCullFace要求启用隐藏图形材料的面。
    f = 0;
}

// GL context is active and screen texture bound to be used
- (BOOL)drawTransitionFrameWithTextureFrom:(GLuint)textureFromView 
                                 textureTo:(GLuint)textureToView
{
    /*
     在纹理贴图场景时，必须为每个顶点提供物体坐标和顶点坐标，经过变换之后，物体坐标决定了应该在屏幕上的那个地点渲染每个特定的顶点，纹理坐标决定了纹理图像中的那个纹理单元将分配给这个顶点
     void glTexCoord{1,2,3,4}{sifd} (Type coords);
     */
    GLfloat vertices[] = {
        -1, -1.5,
         0, -1.5,
        -1,  1.5,
         0,  1.5,
         0, -1.5,
         1, -1.5,
         0,  1.5,
         1,  1.5,
    };
    
    GLfloat texcoords[] = {
        0.0, 1,
        0.5, 1,
        0.0, 0,
        0.5, 0,
        0.5, 1,
        1.0, 1,
        0.5, 0,
        1.0, 0,
    };
    /*
     glVertexPointer------->指定数组顶点
     size：指定了每个顶点对应的坐标个数，只能是2,3,4中的一个，默认值是4
     type：指定了数组中每个顶点坐标的数据类型，可取常量:GL_BYTE, GL_SHORT,GL_FIXED,GL_FLOAT;
     stride:指定了连续顶点间的字节排列方式，如果为0，数组中的顶点就会被认为是按照紧凑方式排列的，默认值为0
     pointer:制订了数组中第一个顶点的首地址，默认值为0，对于我们的android，大家可以不用去管什么地址的，一般给一个IntBuffer就可以了。
     */
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    /*
     glEnableClientState------>启用客户端的某项功能。
     GL_COLOR_ARRAY——如果启用，颜色矩阵可以用来写入以及调用glDrawArrays方法或者glDrawElements方法时进行渲染。详见glColorPointer。
     GL_NORMAL_ARRAY——如果启用，法线矩阵可以用来写入以及调用glDrawArrays方法或者glDrawElements方法时进行渲染。详见glNormalPointer。
     GL_TEXTURE_COORD_ARRAY——如果启用，纹理坐标矩阵可以用来写入以及调用glDrawArrays方法或者glDrawElements方法时进行渲染。详见glTexCoordPointer。
     GL_VERTEX_ARRAY——如果启用，顶点矩阵可以用来写入以及调用glDrawArrays方法或者glDrawElements方法时进行渲染。详见glVertexPointer。
     GL_POINT_SIZE_ARRAY_OES(OES_point_size_arrayextension)——如果启用，点大小矩阵控制大小以渲染点和点sprites。这时由glPointSize定义的点大小将被忽略，由点大小矩阵提供的大小将被用来渲染点和点sprites。详见glPointSize。
     */
    glEnableClientState(GL_VERTEX_ARRAY);
    /*
      glTexCoordPointer--->设置顶点数组为纹理坐标缓存
     
     */
    glTexCoordPointer(2, GL_FLOAT, 0, texcoords);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);

    float v = -(-cos(f)+1.0)/2.0; // For a little ease-in-ease-out
    
    glPushMatrix();//将当前矩阵保存入堆栈顶(保存当前矩阵)。
    glTranslatef(0, 0, -4);//表示将当前图形向x轴平搜索移0，向y轴平移0，向z轴平移-4
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glPushMatrix();
    glRotatef(v*180.0, 0, 1, 0);//表示将当前图形沿方向向量(0,0,0)->(0,1,0)顺时针旋转v*180度。
    glDrawArrays(GL_TRIANGLE_STRIP, 4, 4);
    glRotatef(180.0, 0, 1, 0);
    glBindTexture(GL_TEXTURE_2D, textureToView);
    glPolygonOffset(0, -1);
    glEnable(GL_POLYGON_OFFSET_FILL);//根据函数glPolygonOffset的设置，启用面的深度偏移
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);//提供绘制功能。当采用顶点数组方式绘制图形时，使用该函数。该函数根据顶点数组中的坐标数据和指定的模式，进行绘制。
    glDisable(GL_POLYGON_OFFSET_FILL);//关闭GL_POLYGON_OFFSET_FILL功能
    glPopMatrix();
    glDrawArrays(GL_TRIANGLE_STRIP, 4, 4);
    glPopMatrix();

    f += M_PI/40.0;
    
    return f < M_PI;
}

- (void)transitionEnded
{
}

@end
