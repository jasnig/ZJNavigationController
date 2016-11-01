//
//  ZJBaseViewController.m
//  ZJNavigationController
//
//  Created by ZeroJ on 16/9/19.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJBaseViewController.h"

@interface ZJBaseViewController ()

@end

static const CGFloat kStatusBarHeight = 20.0f;
static const CGFloat kNavigationBarHeight = 64.0f;

@implementation ZJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.zj_navigationBar];

}

- (void)leftBtnOnClick {
    if (self.navigationController.viewControllers.count > 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.view bringSubviewToFront:self.zj_navigationBar];
    if (self.zj_navigationBar.hidden == NO) {
        CGFloat navigationBarY = 0.0f;
        if (self.view.bounds.size.width > self.view.bounds.size.height) {// 横屏
            navigationBarY = -kStatusBarHeight;
        }// 模仿系统横屏时隐藏状态栏, navigationBar上移
        self.zj_navigationBar.frame = CGRectMake(0.0f, navigationBarY, self.view.bounds.size.width, kNavigationBarHeight);
    }


}

// 隐藏自定义的导航栏
- (void)setZJ_navigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (hidden) {
        CGRect frame = self.zj_navigationBar.frame;
        frame.origin.y = -frame.size.height;
        CGFloat duration = animated ? 0.25f : 0.0f;
        [UIView animateWithDuration:duration animations:^{
            self.zj_navigationBar.frame = frame;

        } completion:^(BOOL finished) {
            // 动画完成再隐藏, 当然不隐藏也没有关系, 因为已经移动到了屏幕外面
            self.zj_navigationBar.hidden = hidden;

        }];
    }
    else {
        CGRect frame = self.zj_navigationBar.frame;
        frame.origin.y = 0.0f;
        if (self.view.bounds.size.width > self.view.bounds.size.height) {// 横屏
            frame.origin.y = -kStatusBarHeight;
        }
        CGFloat duration = animated ? 0.25f : 0.0f;
        [UIView animateWithDuration:duration animations:^{
            self.zj_navigationBar.frame = frame;
            self.zj_navigationBar.hidden = hidden;
        }];
    }
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    if (self.zj_navigationBar) {
        self.zj_navigationBar.statusBarBackgroundColor = color;
    }
}

- (ZJNavigationBar *)zj_navigationBar {
    if(!_zj_navigationBar) {
        _zj_navigationBar = [[ZJNavigationBar alloc] init];
    }
    return _zj_navigationBar;
}


@end
