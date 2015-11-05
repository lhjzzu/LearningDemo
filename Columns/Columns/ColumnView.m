//
//  ColumnView.m
//  Columns
//
//  Created by Rob Napier on 8/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ColumnView.h"
#import <CoreText/CoreText.h>

//设置静态常量
static const CFIndex kColumnCount = 3;

@interface ColumnView ()
@property (nonatomic, readwrite, assign) CFIndex mode;
@end

@implementation ColumnView
/**
 *  得到所有列的区域范围
 *
 *  @return 列的范围的数组的指针
 */
- (CGRect *)copyColumnRects {
  CGRect bounds = CGRectInset([self bounds], 20.0, 20.0);
  
  int column;
  CGRect* columnRects = (CGRect*)calloc(kColumnCount,
                                        sizeof(*columnRects));
  
  // Start by setting the first column to cover the entire view.
  columnRects[0] = bounds;
  // Divide the columns equally across the frame's width.
  CGFloat columnWidth = CGRectGetWidth(bounds) / kColumnCount;
  for (column = 0; column < kColumnCount - 1; column++) {
    CGRectDivide(columnRects[column], &columnRects[column],
                 &columnRects[column + 1], columnWidth, 
                 CGRectMinXEdge);
  }
  
  // Inset all columns by a few pixels of margin.
  for (column = 0; column < kColumnCount; column++) {
    columnRects[column] = CGRectInset(columnRects[column], 
                                      10.0, 10.0);
  }
  return columnRects;
}

/**
 *  得到路径数组
 *
 *  @return 返回数组（元素为文本路径）
 */
- (CFArrayRef)copyPaths
{
    //创建可变数组
    // 1 CFAllocatorRef（NULL）:默认的分配器 2 capacity:容量  3 &kCFTypeArrayCallBacks:回调函数地址
  CFMutableArrayRef
paths = CFArrayCreateMutable(kCFAllocatorDefault,
                               kColumnCount,
                               &kCFTypeArrayCallBacks);
  
  switch (self.mode) {
    case 0: // 3 columns
    {
        // 得到所有列的区域范围
      CGRect *columnRects = [self copyColumnRects];
      // 为每一列创建一个路径
      for (int column = 0; column < kColumnCount; column++) {
        CGPathRef 
        path = CGPathCreateWithRect(columnRects[column], NULL);
        CFArrayAppendValue(paths, path);
        CGPathRelease(path);
      }
      free(columnRects);
      break;
    }
      
    case 1: // 3 columns as a single pat
    {
      CGRect *columnRects = [self copyColumnRects];
      
      // 只有一个路径
      CGMutablePathRef path = CGPathCreateMutable();
      for (int column = 0; column < kColumnCount; column++) {
        CGPathAddRect(path, NULL, columnRects[column]);
      }
      free(columnRects);
      CFArrayAppendValue(paths, path);
      CGPathRelease(path);
      break;    
    }
      
    case 2: // two columns with box
    {
      CGMutablePathRef path = CGPathCreateMutable();
      CGPathMoveToPoint(path, NULL, 30, 30);  // Bottom left
      CGPathAddLineToPoint(path, NULL, 344, 30);  // Bottom right
      
      CGPathAddLineToPoint(path, NULL, 344, 400);
      CGPathAddLineToPoint(path, NULL, 200, 400);
      CGPathAddLineToPoint(path, NULL, 200, 800);
      CGPathAddLineToPoint(path, NULL, 344, 800);
      
      CGPathAddLineToPoint(path, NULL, 344, 944); // Top right
      CGPathAddLineToPoint(path, NULL, 30, 944);  // Top left
      CGPathCloseSubpath(path);
      CFArrayAppendValue(paths, path);
      CFRelease(path);
      
      path = CGPathCreateMutable();
      CGPathMoveToPoint(path, NULL, 700, 30); // Bottom right
      CGPathAddLineToPoint(path, NULL, 360, 30);  // Bottom left
      
      CGPathAddLineToPoint(path, NULL, 360, 400);
      CGPathAddLineToPoint(path, NULL, 500, 400);
      CGPathAddLineToPoint(path, NULL, 500, 800);
      CGPathAddLineToPoint(path, NULL, 360, 800);
      
      CGPathAddLineToPoint(path, NULL, 360, 944); // Top left
      CGPathAddLineToPoint(path, NULL, 700, 944); // Top right
      CGPathCloseSubpath(path);
      CFArrayAppendValue(paths, path);
      CGPathRelease(path);    
      break;
    }
    case 3: // ellipse
    {
      //椭圆路径
      CGPathRef 
      path = CGPathCreateWithEllipseInRect(CGRectInset([self bounds],
                                                       30, 
                                                       30),
                                           NULL);
        //将元素添加到数组中
      CFArrayAppendValue(paths, path);
      CGPathRelease(path);
      break;
    }           
  }
  return paths;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Flip the view's context. Core Text runs bottom to top, even 
    // on iPad, and the view is much simpler if we do everything in
    // Mac coordinates.
      //利用仿射变换翻转坐标系
//    CGAffineTransform transform = CGAffineTransformMakeScale(1, -1);
      //平移坐标系
//    CGAffineTransformTranslate(transform, 0, -self.bounds.size.height);
//    self.transform = transform;
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

- (void)drawRect:(CGRect)rect
{
  if (self.attributedString == nil)
  {
    return;
  }
  
  // Initialize the context (always initialize your text matrix)

    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //每次都要把文本矩阵重置为最初的坐标系（即UIKit坐标系）
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //向下平移到底部
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //绕x轴翻转
    CGContextScaleCTM(context, 1, -1);
  
    //将NSAttributedString 转化为 CFAttributedStringRef （指针）
  CFAttributedStringRef 
  attrString = (__bridge CFTypeRef)self.attributedString;
  
  //框架设置器（用属性字符串创建框架设置器）
  CTFramesetterRef
  framesetter = CTFramesetterCreateWithAttributedString(attrString);
  
    //得到路径数组
  CFArrayRef paths = [self copyPaths];
    //获取数组中元素的个数
  CFIndex pathCount = CFArrayGetCount(paths);
    //CFIndex 即是signed long型（有符号长整形）
  CFIndex charIndex = 0;
  for (CFIndex pathIndex = 0; pathIndex < pathCount; ++pathIndex) {
    //根据下表获取数组中的元素
    CGPathRef path = CFArrayGetValueAtIndex(paths, pathIndex);
    
    //根据 框架设置器（CTFramesetterRef），文本路径（CGPathRef），CFRangeMake来创建文本框架（CTFrameRef）
    //CFRangeMake: 0 告诉框架排版器尽可能多的排版属性化字符串  charIndex:开始的位置
    CTFrameRef
    frame = CTFramesetterCreateFrame(framesetter, 
                                     CFRangeMake(charIndex, 0),
                                     path,
                                     NULL);
    //根据文本框架（CTFrameRef），以及上下文（CGContextRef）画出文本
    CTFrameDraw(frame, context);
    //得到可见文本的范围
    CFRange frameRange = CTFrameGetVisibleStringRange(frame);
      NSLog(@"frameRange.length = %ld",frameRange.length);
    charIndex += frameRange.length;
    //只有带copy，create之类的才需要CFRelease释放
    CFRelease(frame);
  }
  
  CFRelease(paths);
  CFRelease(framesetter);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  self.mode = (self.mode + 1 ) % 4;
    NSLog(@"%ld",self.mode);
  [self setNeedsDisplay];
}

@end
