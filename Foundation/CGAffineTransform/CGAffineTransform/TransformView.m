
//  TransformView.m
//  CGAffineTransform
//
//  Created by 刘华健 on 15/11/4.
//  Copyright © 2015年 MK. All rights reserved.
//

#import "TransformView.h"

@implementation TransformView

//UIKit坐标系原点在左上角，CoreText坐标原点在左下角
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将坐标系转换成CoreText坐标系（坐标系翻转）
    //当改变过tranfrom后重置（CGAffineTransformIdentity）
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //平移tx，ty
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //x坐标乘以sx，y坐标乘以sy
    CGContextScaleCTM(context, 1.0, -1.0);
    //
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    //加载出图片
    CGRect imgRect = CGRectMake(10, 5, 100, 100);
    //CGContextDrawImage中的rect是CoreText坐标系下的坐标
    CGContextDrawImage(context, imgRect, image.CGImage);

}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextMoveToPoint(context, 10, 100);
//    CGContextAddLineToPoint(context, 100, 100);
//    CGContextAddLineToPoint(context, 59, 40);
//    CGContextAddLineToPoint(context, 100, 30);
//    CGContextAddLineToPoint(context, 200, 30);
//
//    CGContextSetLineWidth(context, 10);
//    CGContextSetLineCap(context, kCGLineCapSquare);//线的首尾端的样式
//    CGContextSetLineJoin(context, kCGLineJoinBevel);//线的连接处的样式
//    [[UIColor redColor] setStroke];
//    CGContextStrokePath(context);
//    
//    UIImage *image = [UIImage imageNamed:@"1.jpg"];
//    CGRect imgRect = CGRectMake(0, 0, 100, 100);
//    [image drawInRect:imgRect];
//    
//    
//}

//平移变换
//-(void)drawRect:(CGRect)rect
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 200.0f);
//    
//    CGAffineTransform transform = CGAffineTransformMakeTranslation(100.0f, 0.0f);
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    CGPathAddRect(path, &transform, rectangle);
//    
//    CGContextAddPath(currentContext, path);
//    [[UIColor brownColor] setStroke];
//    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
//    CGContextSetLineWidth(currentContext, 5.0f);
//    CGContextDrawPath(currentContext, kCGPathFillStroke);
//    CGContextFillPath(currentContext);
//    CGContextStrokePath(currentContext);
//    CGPathRelease(path);
//}


//平移变换图形上下文
//-(void)drawRect:(CGRect)rect
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 300.0f);
//    CGPathAddRect(path, NULL, rectangle);
//    
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    //存储上下文到栈中去
//    CGContextSaveGState(currentContext);
//    
//    CGContextTranslateCTM(currentContext, 100.0f, 40.0f);
//
//    CGContextAddPath(currentContext, path);
//    [[UIColor colorWithRed:0.20f green:0.6f blue:0.8f alpha:1.0f] setFill];
//    [[UIColor brownColor] setStroke];
//    
//    CGContextSetLineWidth(currentContext, 5.0f);
//    CGContextDrawPath(currentContext, kCGPathFillStroke);
//    
//    CGPathRelease(path);
//    //从栈中恢复图形上下文
//    CGContextRestoreGState(currentContext);
//}


//缩放路径

//-(void)drawRect:(CGRect)rect
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 200.0f);
//    
//    //缩放路径
//    CGAffineTransform transform = CGAffineTransformMakeScale(0.5f, 0.5f);
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    CGPathAddRect(path, &transform, rectangle);
//    
//    
//    CGContextAddPath(currentContext, path);
//    [[UIColor brownColor] setStroke];
//    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
//    CGContextSetLineWidth(currentContext, 5.0f);
//    CGContextDrawPath(currentContext, kCGPathFillStroke);
//    CGPathRelease(path);
//}


//缩放图形上下文
//-(void)drawRect:(CGRect)rect
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 300.0f);
//    CGPathAddRect(path, NULL, rectangle);
//    
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(currentContext);
//    //缩放图形上下文
//    CGContextScaleCTM(currentContext, 0.5f, 0.5f);
//    
//    CGContextAddPath(currentContext, path);
//    [[UIColor colorWithRed:0.20f green:0.6f blue:0.8f alpha:1.0f] setFill];
//    [[UIColor brownColor] setStroke];
//    
//    CGContextSetLineWidth(currentContext, 5.0f);
//    CGContextDrawPath(currentContext, kCGPathFillStroke);
//    CGPathRelease(path);
//    
//    CGContextRestoreGState(currentContext);
//}
//
//旋转路径
//-(void)drawRect:(CGRect)rect
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 200.0f);
//    
//    //旋转路径
//    CGAffineTransform transform = CGAffineTransformMakeRotation((45.0f * M_PI) / 180.0f);
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    CGPathAddRect(path, &transform, rectangle);
//    CGContextAddPath(currentContext, path);
//    [[UIColor brownColor] setStroke];
//    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
//    CGContextSetLineWidth(currentContext, 5.0f);
//    CGContextDrawPath(currentContext, kCGPathFillStroke);
//    CGPathRelease(path);
//}

//旋转图形上下文
//-(void)drawRect:(CGRect)rect
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 300.0f);
//    CGPathAddRect(path, NULL, rectangle);
//    
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(currentContext);
//    //旋转图形上下文
//    CGContextRotateCTM(currentContext, (45.0f * M_PI) / 180.0f);
//    CGContextAddPath(currentContext, path);
//    [[UIColor colorWithRed:0.20f green:0.6f blue:0.8f alpha:1.0f] setFill];
//    [[UIColor brownColor] setStroke];
//    
//    CGContextSetLineWidth(currentContext, 5.0f);
//    CGContextDrawPath(currentContext, kCGPathFillStroke);
//    CGPathRelease(path);
//    CGContextRestoreGState(currentContext);
//    
//}

//同时进行平移和缩放
//使用 CGAffineTransformConcact函数组合两个变换效果
//-(void)drawRect:(CGRect)rect
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 200.0f);
//    
//    CGAffineTransform transform1 = CGAffineTransformMakeTranslation(100.0f, 0.0f);
//    CGAffineTransform transform2 = CGAffineTransformMakeScale(0.5f, 0.5f);
//    CGAffineTransform transform = CGAffineTransformConcat(transform1, transform2);
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    CGPathAddRect(path, &transform, rectangle);
//    CGContextAddPath(currentContext, path);
//    [[UIColor brownColor] setStroke];
//    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
//    CGContextSetLineWidth(currentContext, 5.0f);
//    CGContextDrawPath(currentContext, kCGPathFillStroke);
//    CGPathRelease(path);
//}
//

@end
