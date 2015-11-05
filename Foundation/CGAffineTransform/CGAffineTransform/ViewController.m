//
//  ViewController.m
//  CGAffineTransform
//
//  Created by 刘华健 on 15/11/4.
//  Copyright © 2015年 MK. All rights reserved.
//

#import "TransformView.h"
#import "ViewController.h"
@interface ViewController ()
{
    TransformView *transformView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    transformView = [[TransformView alloc] init];
    transformView.frame = self.view.bounds;
    transformView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:transformView];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
