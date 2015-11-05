

//
//  UIViewController+Tracking.m
//  MethodSwizzling
//
//  Created by 刘华健 on 15/10/27.
//  Copyright © 2015年 MK. All rights reserved.
//
#import <objc/runtime.h>
#import "UIViewController+Tracking.h"
void swizzle_method(Class class,SEL originalSelector,SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didSwizzleMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didSwizzleMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation UIViewController (Tracking)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzle_method(self.class, @selector(viewDidLoad), @selector(swizze_viewDidLoad));
    });
}

- (void)swizze_viewDidLoad {
    NSLog(@"2");
    NSLog(@"%@",NSStringFromClass(self.class));
    [self swizze_viewDidLoad];//将会把这个函数内的代码执行完，再跳转执行ViewDidLoad中的剩余的代码（所以一般应该放到最后一行）
    NSLog(@"3");

}
@end
