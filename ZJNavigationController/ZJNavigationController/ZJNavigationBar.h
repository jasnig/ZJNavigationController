//
//  ZJNavigationBar.h
//  ZJNavigationController
//
//  Created by ZeroJ on 16/9/19.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNavigationBar : UIView
/** 中间的标题 */
@property (copy, nonatomic) NSString *title;
/** 中间的view */
@property (strong, nonatomic) UIView *titleView;
/** 左边的返回按钮 */
@property (strong, nonatomic) UIButton *leftBackButton;
/** 可以间接设置状态栏背景色 */
@property (strong, nonatomic) UIColor *statusBarBackgroundColor;
/** 右边的view 需要设置frame的宽度 */
@property (strong, nonatomic) UIView *rightView;
/** 左边的view 需要设置frame的宽度 */
@property (strong, nonatomic) UIView *leftView;

@end
