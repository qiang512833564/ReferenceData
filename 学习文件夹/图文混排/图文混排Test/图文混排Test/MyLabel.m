//
//  MyLabel.m
//  图文混排Test
//
//  Created by lizhongqiang on 16/1/13.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "MyLabel.h"
#import <CoreText/CoreText.h>

static NSString* const kEllipsesCharacter = @"\u2026";

@interface MyLabel()
{
    NSMutableArray              *_attachments;
    NSMutableArray              *_linkLocations;
    CTFrameRef                  _textFrame;
    CGFloat                     _fontAscent;
    CGFloat                     _fontDescent;
    CGFloat                     _fontHeight;
}
@end
@implementation MyLabel
- (void)drawRect:(CGRect)rect{
#if 1
    NSString *src = @"其实流程是这样生成要绘制的发发发发对象其实流程是这样生成要绘制的发发发发对象其实流程是这样生成要绘制的发发发发对象其实流程是这样生成要绘制的发发发发对象其实流程是这样生成要绘制的发发发发对象其实流程是这样生成要绘制的发发发发对象";
    NSMutableAttributedString *mabString = [[NSMutableAttributedString alloc]initWithString:src attributes:@{NSFontAttributeName:[UIFont fontWithName:@"CourierNewPS-BoldMT" size:15]}];//\u2026
    CTLineRef token = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)mabString);
    
    //long slen = [mabString length];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mabString);
    
    CGMutablePathRef Path = CGPathCreateMutable();
    
    //坐标点在左下角
    CGPathAddRect(Path, NULL ,self.bounds);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    
    //得到frame中的行数组
    CFArrayRef rows = CTFrameGetLines(frame);
    
    int rowcount = (int)CFArrayGetCount(rows);
    
    NSLog(@"rowcount = %i",rowcount);
    
//    CTLineRef line = CFArrayGetValueAtIndex(rows, 0);
 
    if (rows) {
        const CFIndex numberOfLines = CFArrayGetCount(rows);
        const CGFloat fontLineHeight = [UIFont systemFontOfSize:20].lineHeight;
        CGFloat textOffset = 0;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        CGContextTranslateCTM(ctx, rect.origin.x, rect.origin.y+[UIFont systemFontOfSize:20].ascender);
        CGContextSetTextMatrix(ctx, CGAffineTransformMakeScale(1,-1));//设置当前文本矩阵，对将要绘制的文本执行指定的变换----这里的作用是旋转矩阵
        
        for (CFIndex lineNumber=0; lineNumber<numberOfLines; lineNumber++) {
            CTLineRef line = CFArrayGetValueAtIndex(rows, lineNumber);
            //从一行中得到CTRun数组
            CFArrayRef runs = CTLineGetGlyphRuns(line);
            int runcount = (int)CFArrayGetCount(runs);
            NSLog(@"runcount = %i",runcount);
            /*
             double CTLineGetTypographicBounds( CTLineRef line, CGFloat* ascent, CGFloat* descent, CGFloat* leading );
             获取一行中上行高(ascent)，下行高(descent)，行距(leading),整行高为(ascent+|descent|+leading) 返回值为整行字符串长度占有的像素宽度。
             正常情况下，计算行高只需要ascent+descent+leading即可。在这个略有不同的情况下，leading的值会出现偏差，导致算出 来的结果是错误的。如果不管行距，ascent+descent计算出来的Glyph的高度还是正确的。
             */
            CGFloat asc,des,lead;
            double lineHeight = CTLineGetTypographicBounds(line, &asc, &des, &lead);
            NSLog(@"ascent = %f,descent = %f,leading = %f,lineheight = %f",asc,des,lead,lineHeight);
            
#if 0
            CTLineTruncationType ltt = kCTLineTruncationStart;
            CTLineRef newline = CTLineCreateTruncatedLine(line, self.bounds.size.width-200, ltt, token);
#endif
            float flush;
            switch (0) {
                case NSTextAlignmentCenter: flush = 0.5;    break; //1
                case NSTextAlignmentRight:  flush = 1;      break; //2
                case NSTextAlignmentLeft:  //0
                default:                    flush = 0;      break;
            }
            /*
             获取相对于Flush（水平）的偏移量
             double CTLineGetPenOffsetForFlush(
             CTLineRef line,
             CGFloat flushFactor,（水平因子，设置居中，左右对齐，取值（0~1））
             double flushWidth )
             即[flushwidth - line(字符占的像素)]*flushFactor/100;这是我个人推的公式，发现精确度上还存在偏差。
             当flushFactor取值为0,0.5,1时分别显示的效果为左对齐，居中对齐，右对齐。
             */
            CGFloat penOffset = CTLineGetPenOffsetForFlush(line, flush, rect.size.width);
            NSLog(@"penOffset = %f",penOffset);
            CGContextSetTextPosition(ctx, penOffset, textOffset);//设置要绘制文本的位置---在偏移量x,y上打印
            
            CTLineDraw(line, ctx);//draw 行文字//CTLineDraw(newline, ctx);//
            textOffset += fontLineHeight;
        }
        
        CGContextRestoreGState(ctx);
        
    }
#endif
    
}
@end
