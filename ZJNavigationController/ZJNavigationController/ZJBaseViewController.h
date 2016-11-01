//
//  ZJBaseViewController.h
//  ZJNavigationController
//
//  Created by ZeroJ on 16/9/19.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJNavigationBar.h"
@interface ZJBaseViewController : UIViewController
/** 自定义的导航栏 继承自ZJBaseViewController都会拥有 */
@property (strong, nonatomic) ZJNavigationBar *zj_navigationBar;

/** 设置自定义的状态栏的颜色 */
- (void)setStatusBarBackgroundColor:(UIColor *)color;

/** 隐藏自定义的导航栏 */
- (void)setZJ_navigationBarHidden:(BOOL)hidden animated:(BOOL)animated;
@end
