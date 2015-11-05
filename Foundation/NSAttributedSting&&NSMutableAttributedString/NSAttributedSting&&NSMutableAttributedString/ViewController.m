//
//  ViewController.m
//  NSAttributedSting&&NSMutableAttributedString
//
//  Created by 刘华健 on 15/10/27.
//  Copyright © 2015年 MK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2);
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    [textView setEditable:NO];// 不能设置textView.userInteractionEnabled = NO;否则点击链接不响应
    textView.delegate = self;
    [self.view addSubview:textView];
    
    //创建NSAttributedString
    NSString *textString = @"从2007年开始参与当地的农村公墓建设，廖辉与3个朋友先后投入2000多万元。然而，7年后政策巨变，干杉镇镇政府在没有对墓地资产进行清算和交割的前提下，动用了几百人强制进行接管。市县两级人民法院判决镇政府的行为违法，却没有责令其撤销行政行为";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attributedString beginEditing];//为了防止属性未改变
    //添加属性
    [attributedString addAttribute:NSLinkAttributeName value:@"http://www/baidu.com" range:NSMakeRange(20, 5)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(20, 5)];
    //图片附件
//    NSTextAttachment *textAtt = [[NSTextAttachment alloc] init];
//    textAtt.image = [UIImage imageNamed:@"1"];
//    NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:textAtt];
//    [attributedString insertAttributedString:att atIndex:10];//插入下标为10的位置
//
    //字体
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 10)];
    //颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 20)];
    
    
    //字体描述符
    __weak typeof(attributedString) weakAttr = attributedString;
    [attributedString enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedString.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        
        UIFont *font = (UIFont *)value;
        UIFontDescriptor *descriptor = font.fontDescriptor;
        UIFontDescriptorSymbolicTraits traits =  UIFontDescriptorTraitItalic;
        
        UIFontDescriptor *toggledDescriptor = [descriptor fontDescriptorWithSymbolicTraits:traits];
        
        UIFont *italicFont = [UIFont fontWithDescriptor:toggledDescriptor size:0];
        [weakAttr addAttribute:NSFontAttributeName value:italicFont range:range];
    }];
    
    [attributedString endEditing];//为了防止属性未改变

//
    textView.attributedText = attributedString;

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    [attributedString enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedString.length) options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        NSLog(@"value == %@",value);
        NSLog(@"range11 == %@",NSStringFromRange(range));
    }];
    
    //枚举
    [attributedString enumerateAttributesInRange:NSMakeRange(0, attributedString.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        NSLog(@"attrs == %@",attrs);
        NSLog(@"range22 == %@",NSStringFromRange(range));
    }];
    
   NSRange range;
    NSDictionary *dic =  [attributedString attributesAtIndex:0 effectiveRange:&range];
    NSLog(@"dic == %@",dic);
    NSLog(@"range33 == %@",NSStringFromRange(range));//从下标index开始的文本，文本效果相同的范围
    

    
    UITextView *textView2 = [[UITextView alloc] init];
    textView2.frame = CGRectMake(0, CGRectGetMaxY(textView.frame), CGRectGetWidth(textView.frame), CGRectGetHeight(textView.frame));
    [textView2 setEditable:NO];
    textView2.delegate = self;
    [textView2 setSelectable: YES];
    NSString *htmlString = @"<h1>Header</h1><h2 src ="">Subheader</h2><p>Sometext</p><p><a href=\"http://www.baidu.com\">超链接HTML入门</a></p><p><font color=\"#aabb00\">颜色2</p><img src=\"files:1.png\" width=70 height=100></img><p><a href=\"https://www.baidu.com/img/bdlogo.png\">超链接HTML入门</a></p>";
    textView2.dataDetectorTypes = UIDataDetectorTypeAll;
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    textView2.attributedText = attributedString2;
    [self.view addSubview:textView2];
    

    
}
//响应文本附件
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"hhh");
    return YES;
}

//响应链接
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
