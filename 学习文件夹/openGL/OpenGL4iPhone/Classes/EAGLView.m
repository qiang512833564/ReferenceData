//
//  EAGLView.m
//  OpenGL_ES_Test
//
//  Created by Zenny Chen on 09-6-29.
//  Copyright GreenGames Studio 2009. All rights reserved.
//



#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "EAGLView.h"

#define USE_DEPTH_BUFFER 0

// A class extension to declare private methods
@interface EAGLView ()

@property (nonatomic, retain) EAGLContext *context;

- (BOOL) createFramebuffer;
- (void) destroyFramebuffer;

@end


@implementation EAGLView

@synthesize context;


// You must implement this method
// Override the layerClass method of the UIView class so that objects of your view class create and
// initialize a CAEAGLLayer object rather than a CALayer object.
+ (Class)layerClass {
    return [CAEAGLLayer class];
}

//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder {
    
    if ((self = [super initWithCoder:coder])) {
        // Get the layer associated with the view by calling the layer method of UIView.
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        // Set the layer properties.
        
        // For optimal performance, it is recommended that you mark the layer as opaque by setting the opaque property provided by the CALayer class. 
        eaglLayer.opaque = YES;
        // Optionally configure the surface properties of the rendering surface by assigning a new dictionary of
        // values to the drawableProperties property of the CAEAGLLayer object.
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
        
        context = nil;  // [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        if(context == nil)
        {
            // Before your application can execute any OpenGL ES commands, it must first create and initialize an EAGL context and make it the current context.
            context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
            if (!context || ![EAGLContext setCurrentContext:context]) {
                [self release];
                return nil;
            }
        }
    }
    
    return self;
}


- (void)drawView {
    
    // Replace the implementation of this method to do your own custom drawing
    
    static struct
    {
        GLubyte colours[4];
        GLfloat vertices[3];
        
    }vertexInfoList[] = {
        { {255, 0, 0, 255}, {-0.5f, 0.5f, 0.0f} },
        { {0, 255, 0, 255}, {-0.5f, -0.5f, 0.0f} },
        { {0, 0, 255, 255}, {0.5f, 0.5f, 0.0f} },
        { {255, 0, 255, 255}, {0.5f, -0.5f, 0.0f} }
    };
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    glVertexPointer(3, GL_FLOAT, 16, vertexInfoList[0].vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 16, vertexInfoList[0].colours);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    // Assuming you allocated a color renderbuffer to point at a Core Animation layer, you present its contents by making it the current renderbuffer 
    // and calling the presentRenderbuffer: method on your rendering context.
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}


- (void)layoutSubviews {
    [EAGLContext setCurrentContext:context];
    [self destroyFramebuffer];
    [self createFramebuffer];
    [self drawView];
}


- (BOOL)createFramebuffer {
    
    // An OpenGL ES 2.0 application would omit the OES suffix.
    
    // Create the framebuffer and bind it so that future OpenGL ES framebuffer commands are directed to it.
    glGenFramebuffersOES(1, &viewFramebuffer);
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    
    // Create a color renderbuffer, allocate storage for it, and attach it to the framebuffer.
    glGenRenderbuffersOES(1, &viewRenderbuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    // Create the color renderbuffer and call the rendering context to allocate the storage on our Core Animation layer. 
    // The width, height, and format of the renderbuffer storage are derived from the bounds and properties of the CAEAGLLayer object 
    // at the moment the renderbufferStorage:fromDrawable: method is called.
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
    
    // Retrieve the height and width of the color renderbuffer.
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    if (USE_DEPTH_BUFFER) {
        // Perform similar steps to create and attach a depth renderbuffer.
        glGenRenderbuffersOES(1, &depthRenderbuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    }
    
    // Test the framebuffer for completeness.
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    // Initialize the OpenGL ES context state
    [EAGLContext setCurrentContext:context];
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    
    glViewport(0, 0, backingWidth, backingHeight);
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    GLfloat delta;
    if(backingWidth < backingHeight)
    {
        delta = (GLfloat)backingHeight / (GLfloat)backingWidth;
        glOrthof(-1.0f, 1.0f, -delta, delta, -1.0f, 1.0f);
    }
    else
    {
        delta = (GLfloat)backingWidth / (GLfloat)backingHeight;
        glOrthof(-delta, delta, -1.0f, 1.0f, -1.0f, 1.0f);
    }
    
    glMatrixMode(GL_MODELVIEW);
    
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    
    return YES;
}

- (void)destroyFramebuffer {
    
    glDeleteFramebuffersOES(1, &viewFramebuffer);
    viewFramebuffer = 0;
    glDeleteRenderbuffersOES(1, &viewRenderbuffer);
    viewRenderbuffer = 0;
    
    if(depthRenderbuffer) {
        glDeleteRenderbuffersOES(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
}

- (void)dealloc {
    
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    [context release];  
    [super dealloc];
}

@end
