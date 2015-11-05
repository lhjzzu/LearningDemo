//
//  ViewController.m
//  RegularExpression
//
//  Created by 刘华健 on 15/10/28.
//  Copyright © 2015年 MK. All rights reserved.
//

#import "RegexKitLite.h"
#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *str = @"#呵呵呵#[偷笑] http://foo.com/blah_blah #解放军#//http://foo.com/blah_blah @Ring花椰菜:就#范德萨发生的#舍不得打[test] 就惯#急急急#着他吧[挖鼻屎]//@崔西狮:小拳头举起又放下了 说点啥好呢…… //@toto97:@崔西狮 蹦米咋不揍他#哈哈哈# http://foo.com/blah_blah";
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";

    
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    //枚举所有匹配结果
    [reg enumerateMatchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSLog(@"result == %@",[str substringWithRange:result.range]);
    }];
    
    //返回所有匹配结果的集合
    NSArray *resultArr = [reg matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    NSLog(@"resultArr == %@",resultArr);
    
    for (int i = 0; i < resultArr.count; i++) {
        NSTextCheckingResult *result = resultArr[i];
        NSLog(@"result2 == %@",[str substringWithRange:result.range]);
    }
    
    //返回正确匹配的个数
    NSUInteger count = [reg numberOfMatchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    NSLog(@"count == %lud",(unsigned long)count);
    
    
    //返回第一个匹配的结果。注意，匹配的结果保存在  NSTextCheckingResult 类型中。
    NSTextCheckingResult *result = [reg firstMatchInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    NSLog(@"result3 == %@",[str substringWithRange:result.range]);
    
    //返回第一个正确匹配结果字符串的NSRange。
    NSRange range = [reg rangeOfFirstMatchInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    NSLog(@"range == %@",NSStringFromRange(range));
    
    
    // 遍历所有的匹配结果
    [str enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSLog(@"%@ %@", *capturedStrings, NSStringFromRange(*capturedRanges));
    }];
    // 以正则表达式为分隔符
    [str enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSLog(@"%@ %@", *capturedStrings, NSStringFromRange(*capturedRanges));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
