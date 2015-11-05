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
{
    UITextView *textView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    textView = [[UITextView alloc] init];
    textView.frame = self.view.bounds;
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    [textView setEditable:NO];
    textView.delegate = self;
    [self.view addSubview:textView];
    
    //创建NSAttributedString
    NSString *textString = @"从2007年开始参与当地的农村公墓建设，廖辉与3个朋友先后投入2000多万元。然而，7年后政策巨变，干杉镇镇政府在没有对墓地资产进行清算和交割的前提下，动用了几百人强制进行接管。市县两级人民法院判决镇政府的行为违法，却没有责令其撤销行政行为";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attributedString beginEditing];
    //1 NSFontAttributeName （文本字体）
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(0, textString.length)];
    //2 NSParagraphStyleAttributeName （段落样式）
    NSMutableParagraphStyle *mutablePara = [[NSMutableParagraphStyle alloc] init];
    mutablePara.lineSpacing = 10;
    mutablePara.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:mutablePara range:NSMakeRange(0, textString.length)];
    
    //3 NSForegroundColorAttributeName （前景色）
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 8)];
    //4 NSBackgroundColorAttributeName（背景色）
    
    [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(10, 8)];
    //5 NSLigatureAttributeName（连字符）(没有效果)
    [attributedString addAttribute:NSLigatureAttributeName value:@(1) range:NSMakeRange(10, 8)];
    
    //6 NSKernAttributeName （字间距）
    [attributedString addAttribute:NSKernAttributeName value:@(40) range:NSMakeRange(20, 8)];
    
    //7 NSStrikethroughStyleAttributeName（删除线）
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(1) range:NSMakeRange(20, 8)];
    
    //8 NSUnderlineStyleAttributeName （下划线）值为枚举： NSUnderlineStyle
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleDouble) range:NSMakeRange(28, 5)];
    //9 NSStrokeColorAttributeName（边线颜色）(不设置时，与前景色相同，需要设置宽度才有效果)
    [attributedString addAttribute:NSStrokeColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, 8)];
    //10 NSStrokeWidthAttributeName（边线宽度）正值中空效果，负值填充效果
    [attributedString addAttribute:NSStrokeWidthAttributeName value:@(3) range:NSMakeRange(0, 8)];
    
    //11 NSShadowAttributeName （阴影）
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 5;
    shadow.shadowOffset = CGSizeMake(5, 5);
    shadow.shadowColor = [UIColor blueColor];
    [attributedString addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(34, 5)];
    
    
    //12 NSTextEffectAttributeName（文本特殊效果）
    //    [attributedString addAttribute:NSTextEffectAttributeName value:nil range:NSMakeRange(34, 5)];
    //13 NSAttachmentAttributeName (文本附件) (暂无效果)
    NSTextAttachment *textAtt = [[NSTextAttachment alloc] init];
    textAtt.image = [UIImage imageNamed:@"1.png"];
    textAtt.bounds = CGRectMake(0, 0, 300, 100);
    NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:textAtt];
    [attributedString appendAttributedString:att];
    
    //    [attributedString addAttribute:NSAttachmentAttributeName value:textAtt range:NSMakeRange(45, 5)];
    
    //14 NSLinkAttributeName
    [attributedString addAttribute:NSLinkAttributeName value:@"http://www.baidu.com" range:NSMakeRange(40, 5)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(40, 5)];
    
    //15 NSBaselineOffsetAttributeName （基线偏移）正值向上偏移，负值向下偏移
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(10) range:NSMakeRange(50, 5)];
    
    //16 NSUnderlineColorAttributeName （下划线的颜色）下划线默认为NSUnderlineStyleNone
    [attributedString addAttribute:NSUnderlineColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(55, 5)];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(2) range:NSMakeRange(55, 5)];
    
    //17 NSStrikethroughColorAttributeName （删除线的颜色）
    [attributedString addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(60, 5)];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(1) range:NSMakeRange(60, 5)];
    
    
    
    //18 NSObliquenessAttributeName （自行的倾斜度）(正值右倾，负值左倾)NSNumber（float）
    [attributedString addAttribute:NSObliquenessAttributeName value:@(-0.3) range:NSMakeRange(60, 5)];
    
    //19 NSExpansionAttributeName （文本横向拉伸）正值横向拉伸文本，负值横向压缩文本
    [attributedString addAttribute:NSExpansionAttributeName value:@(.6) range:NSMakeRange(65, 5)];
    
    //20 NSWritingDirectionAttributeName（文字书写方向）(没有效果)
    //    [attributedString addAttribute:NSWritingDirectionAttributeName value:@(NSWritingDirectionLeftToRight|NSWritingDirectionEmbedding) range:NSMakeRange(0, attributedString.length)];
    
    //21 NSVerticalGlyphFormAttributeName （横竖排版）(0横排，1竖排)（ios中只有横排有效）
    [attributedString addAttribute:NSVerticalGlyphFormAttributeName value:@(1) range:NSMakeRange(39, 10)];
    
    [attributedString endEditing];
    textView.attributedText = attributedString;
    
    
    
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"hhh");
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
