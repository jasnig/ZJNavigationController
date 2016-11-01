//
//  ZJNavigationController.h
//  ZJNavigationController
//
//  Created by ZeroJ on 16/9/19.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZJNavigationControllerAnimationStyle) {
    ZJNavigationControllerAnimationStyleNone
};

@class ZJNavigationControllerAnimator;

@interface ZJNavigationController : UINavigationController

@property (assign, nonatomic) ZJNavigationControllerAnimationStyle animationStyle;


- (void)zj_enableFullScreenPop:(BOOL)enabled;

@end


@interface UIViewController (ZJNavigationController)
@property (weak, nonatomic, readonly) ZJNavigationController *zj_navigationController;

@end

