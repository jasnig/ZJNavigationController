//
//  ZJTest1ViewController.m
//  ZJNavigationController
//
//  Created by ZeroJ on 16/9/19.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTest1ViewController.h"

@interface ZJTest1ViewController ()

@end

@implementation ZJTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.zj_navigationBar.title = @"这也是自定义的标题";
    self.zj_navigationBar.backgroundColor = [UIColor greenColor];
    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44.0, 44.0)];
    test.backgroundColor = [UIColor redColor];
    self.zj_navigationBar.rightView = test;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
    [btn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"隐藏" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    [backBtn addTarget:self action:@selector(backBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"自定义" forState:UIControlStateNormal];
    
//    self.zj_navigationBar.leftBackButton = backBtn;
}

- (void)backBtnOnClick {
    NSLog(@"点击了返回按钮");
}

- (void)btnOnClick {
    [self setZJ_navigationBarHidden:!self.zj_navigationBar.hidden animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
