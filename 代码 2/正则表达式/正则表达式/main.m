//
//  main.m
//  正则表达式
//
//  Created by apple on 14/11/15.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Extension.h"
#import "RegexKitLite.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *str = @"#呵呵呵#[偷笑] http://foo.com/blah_blah #解放军#//http://foo.com/blah_blah @Ring花椰菜:就#范德萨发生的#舍不得打[test] 就惯#急急急#着他吧[挖鼻屎]//@崔西狮:小拳头举起又放下了 说点啥好呢…… //@toto97:@崔西狮 蹦米咋不揍他#哈哈哈# http://foo.com/blah_blah";
//        NSString *str = @"#呵呵呵#返回加快速度会尽#解放军#快发货看电视#好几件#发货了速度了恢复良好";
        
        // 表情的规则
        NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
        // @的规则
        NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
        // #话题#的规则
        NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
        // url链接的规则
        NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
        NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
//        NSArray *cmps = [str componentsMatchedByRegex:pattern];
        
        // 遍历所有的匹配结果
        [str enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
            NSLog(@"%@ %@", *capturedStrings, NSStringFromRange(*capturedRanges));
        }];
        
        NSLog(@"-------------");
        
        // 以正则表达式为分隔符
        [str enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
            NSLog(@"%@ %@", *capturedStrings, NSStringFromRange(*capturedRanges));
        }];
    }
    return 0;
}

void test2()
{
    NSString *str = @"#呵呵呵#[偷笑] http://foo.com/blah_blah #解放军#//http://foo.com/blah_blah @Ring花椰菜:就#范德萨发生的#舍不得打[test] 就惯#急急急#着他吧[挖鼻屎]//@崔西狮:小拳头举起又放下了 说点啥好呢…… //@toto97:@崔西狮 蹦米咋不揍他#哈哈哈# http://foo.com/blah_blah";
    
    /**
     1.判断字符串是否符合某个特定规则
     * 判断某个字符串是否为QQ号码\电话号码\邮箱
     
     2.截取字符串中符合某个特定规则的内容
     * 截取@"#呵呵呵#[偷笑]5345 http://foo.com/blah_blah #解放军# 58937985"的所有话题\表情\链接
     */
    
    // 1.创建正则表达式
    //        NSString *pattern = @"[a-zA-Z]{1,}";
    //        NSString *pattern = @"[a-zA-Z]+";
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
    
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    
    // | 匹配多个条件,相当于or\或
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    // 3.遍历结果
    for (NSTextCheckingResult *result in results) {
        NSLog(@"%@ %@", NSStringFromRange(result.range), [str substringWithRange:result.range]);
    }
}

/**
 *  正则表达式的基本使用
 */
void test1()
{
    
    NSString *username = @"6gjkhdjkhgkjh7";
    //        NSString *pattern = @"^\\d{3}";
    //        NSString *pattern = @"\\d{3}$";
    // 1.创建正则表达式
    NSString *pattern = @"^\\d.*\\d$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    
    // 2.测试字符串
    NSArray *results = [regex matchesInString:username options:0 range:NSMakeRange(0, username.length)];
    
    NSLog(@"%zd", results.count);
    
    /**
     使用正则表达式的步骤:
     1.创建一个正则表达式对象:定义规则
     
     2.利用正则表达式对象 来测试 相应的字符串
     */
    
    // Pattern : 样式\规则
    //        NSString *pattern = @"ab7";
    // [] : 找到内部的某一个字符即可
    //        NSString *pattern = @"[0123456789]";
    //        NSString *pattern = @"[0-9]";
    //        NSString *pattern = @"[a-zA-Z0-9]";
    //        NSString *pattern = @"[0-9][0-9]";
    //        NSString *pattern = @"\\d\\d\\d";
    //        NSString *pattern = @"\\d{2,4}";
    
    // ? + *
    // ? : 0个或者1个
    // + : 至少1个
    // * : 0个或者多个
}

/**
 *  普通的做法:检测全数字
 */
void test()
{
    NSString *username = @"5347858h7";
    
    BOOL flag = YES;
    for (int i = 0; i<username.length; i++) {
        unichar c = [username characterAtIndex:i];
        if (!(c >= '0' && c <= '9')) {
            flag = NO;
            break;
        }
    }
    
    if (flag) {
        NSLog(@"用户名正确");
    } else {
        NSLog(@"里面包含了非数字");
    }
}

