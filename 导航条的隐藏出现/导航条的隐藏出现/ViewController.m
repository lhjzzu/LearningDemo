//
//  ViewController.m
//  导航条的隐藏出现
//
//  Created by 刘华健 on 15/11/9.
//  Copyright © 2015年 MK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *dTableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self renderDataComponents];
    [self renderUIComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- renderDataComponents
- (void)renderDataComponents
{
    
}

#pragma mark -- renderUIComponents
- (void)renderUIComponents
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:tableView];
    dTableView = tableView;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 给导航条的背景图片传递一个空图片的UIImage对象
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 隐藏底部阴影条，传递一个空图片的UIImage对象
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"hhahah" style:UIBarButtonItemStylePlain target:self action:@selector(barItemClick:)];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)barItemClick:(UIBarButtonItem *)barItem
{
    NSLog(@"ddd");
    
    
}
// 根据颜色生成一张尺寸为1*1的相同颜色图片
- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat alpha = 0;
    if (scrollView.contentOffset.y <= 0) {
        alpha = 0;

    } else if (scrollView.contentOffset.y <= 150) {
       alpha = scrollView.contentOffset.y / 150;

    } else if (scrollView.contentOffset.y > 150) {
      alpha = 1;

    }
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
    NSLog(@"alpha == %@",@(alpha));

}

#pragma mark -- UITableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark -- UITableDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}








@end
