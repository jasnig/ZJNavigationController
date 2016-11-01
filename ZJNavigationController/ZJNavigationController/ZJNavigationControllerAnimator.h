//
//  ZJNavigationControllerAnimator.h
//  ZJNavigationController
//
//  Created by ZeroJ on 16/9/19.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNavigationControllerAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic) UINavigationControllerOperation operationType;
@property (assign, nonatomic) BOOL isInteractionAnimation;

@end
