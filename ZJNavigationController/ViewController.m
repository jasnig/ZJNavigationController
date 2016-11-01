//
//  ViewController.m
//  ZJNavigationController
//
//  Created by ZeroJ on 16/9/19.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ViewController.h"
#import "ZJNavigationController.h"
#import "ZJTest1ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
    [btn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    self.zj_navigationBar.title = @"这是自定义的标题";
    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    test.backgroundColor = [UIColor redColor];
    self.zj_navigationBar.leftView = test;

    [self setStatusBarBackgroundColor:[UIColor purpleColor]];
}

- (void)btnOnClick {
    ZJTest1ViewController *vc = [ZJTest1ViewController new];
    [self showViewController:vc sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
