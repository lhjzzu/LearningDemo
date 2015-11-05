//
//  ViewController.m
//  CoreFoundation
//
//  Created by 刘华健 on 15/10/29.
//  Copyright © 2015年 MK. All rights reserved.
//

#import <malloc/malloc.h>
#import "ViewController.h"

CF_IMPLICIT_BRIDGING_ENABLED
char *MYCFstringCopyUTF8String(CFStringRef aString);
const char * MYCFStringGetUTF8String(CFStringRef aString, char **buffer);
CF_IMPLICIT_BRIDGING_DISABLED


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1 基本
    CFStringRef errName = CFSTR("error");
    CFErrorRef error = CFErrorCreate(NULL, errName, 0, NULL);
    CFPropertyListRef propertyList = error;//错误
    
    CFStringRef string = CFSTR("Hello");
    CFArrayRef array = CFArrayCreate(NULL, (const void **) &string, 1, &kCFTypeArrayCallBacks);
    CFShow(array);
    CFShow(string);
    CFShowStr(string);
    
    
    //2 从C字符串生成CFString
    const char *cstring = "Hello, world";
    CFStringRef string2 = CFStringCreateWithCString(NULL, cstring, NSUTF8StringEncoding);
    CFShow(string2);
//    CFRelease(string2); 为什么会崩溃
//
    //3 在网络协议中，如果长度编码是1字节长，那么缓冲区就是Pascal风格的字符串
    //常见的网络缓冲区类型
    struct NetworkBuffer {
        UInt8 length;
        UInt8 data[];
    };
    //从网络上提取数据到缓冲区中
    static struct NetworkBuffer buffer = {4,{'T','e','x','t'}};
    CFStringRef string3 = CFStringCreateWithPascalString(NULL, (ConstStr255Param)&buffer, kCFStringEncodingUTF8);
    CFShow(string3);
    CFRelease(string3);
    
    
    //4 如果长度以其他方式存在，或者不是1个字节
    //isExternalRepresentation:false表示这个字符串没有BOM（byte order mark 字节序标记） UTF-8编码（尽量使用）不需要BOM
    //kCFStringEncodingUTF8 与 NSUTF8StringEncoding 相对应
    CFStringRef string4 = CFStringCreateWithBytes(NULL, buffer.data, buffer.length, kCFStringEncodingUTF8, false);
    CFShow(string4);
    CFRelease(string4);
    
    
    //5 将CFString转化为C字符串
    CFStringRef string5 = CFSTR("Hello");
    char *cString5 = MYCFstringCopyUTF8String(string5);
    printf("%s\n",cString5);
    free(cString5);
    
    
    CFStringRef strings[3] ={CFSTR("One"),CFSTR("Two"),CFSTR("Three")};
    char *buffer6 = NULL;
    const char *cString6 = NULL;
    for (unsigned i = 0; i < 3; i++) {
        cString6 = MYCFStringGetUTF8String(strings[i], &buffer6);
        printf("%s\n",cString6);
    }
    free(buffer6);
    
    
    int a[3][4] = {0};
    for(int i = 0; i < 3; i++)
    {
        for(int j = 0; j < 4; j++)
        {
            scanf("%d",&a[i][j]);
          //此时要用取地址符&
        }
    }
    
    
    float a1 = 2, b1 = 3;
    changeFloat2(&a1 , &b1);
    printf("a1:%.2f, b1:%.2f\n",a1,b1);
    
}

// 函数指针的类型定义
typedef int(*Function) (int, int);



void changeFloat2(float *a, float *b){
    float temp = *a;
    *a = *b;
    *b = temp;
    
}
 //每次转换都要分配缓存区，速度不是最快的
char *MYCFstringCopyUTF8String(CFStringRef aString) {
    if (aString == NULL) {
        return NULL;
    }
    CFIndex length = CFStringGetLength(aString);
    CFIndex maxSize = CFStringGetMaximumSizeForEncoding(length, kCFStringEncodingUTF8);
    
    char *buffer = (char *)malloc(maxSize);
    if (CFStringGetCString(aString, buffer, maxSize, kCFStringEncodingUTF8)) {
        return buffer;
    }
    free(buffer);
    return NULL;
}

const char * MYCFStringGetUTF8String(CFStringRef aString, char **buffer) {
    if (aString == NULL) {
        return NULL;
    }
    //得到内部的C字符串指针(但在某些情况下指针会为空)
    const char *cstr = CFStringGetCStringPtr(aString, kCFStringEncodingUTF8);
    if (cstr == NULL) {
        CFIndex length = CFStringGetLength(aString);
        CFIndex maxSize = CFStringGetMaximumSizeForEncoding(length, kCFStringEncodingUTF8) + 1;
        
        if (maxSize > malloc_size(buffer)) {
            *buffer = realloc(*buffer, maxSize);
        }
        
        if (CFStringGetCString(aString, *buffer, maxSize, kCFStringEncodingUTF8)) {
            cstr = *buffer;
        }
    }
    return cstr;
}

@end
