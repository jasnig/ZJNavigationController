//
//  ZJNavigationControllerAnimator.m
//  ZJNavigationController
//
//  Created by ZeroJ on 16/9/19.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJNavigationControllerAnimator.h"

@interface ZJNavigationControllerAnimator ()

@end

@implementation ZJNavigationControllerAnimator


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

// 真正的动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 将要消失的控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 将要显示的Vc
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 容器view
    UIView *containerView = [transitionContext containerView];
    UIView *fromView;
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        // 执行动画的view不一定是对应controller.view
        // 系统内部可能会调整,  所有通过这种方法获取的fromView和toView才准确
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    else {
        fromView = fromVc.view;
        toView = toVc.view;
    }
    // 最终显示在屏幕上的frame
    CGRect finialVisibleFrame = [[UIScreen mainScreen] bounds];
    // 隐藏在屏幕左边的frame
    CGRect leftHiddenFrame = finialVisibleFrame;
    leftHiddenFrame.origin.x = -finialVisibleFrame.size.width/2;
    // 影藏在屏幕右边的frame
    CGRect rightHiddenFrame = finialVisibleFrame;
    rightHiddenFrame.origin.x = finialVisibleFrame.size.width;

    if (self.operationType == UINavigationControllerOperationPush) {
        // push动画, 设置将要出现的view的初始位置 --- 影藏在屏幕的右边
        toView.frame = rightHiddenFrame;
        // 添加将要出现的toView在上面
        [containerView insertSubview:toView aboveSubview:fromView];
        [self drawShadowForView:toView];

        UIViewAnimationOptions option = self.isInteractionAnimation ? UIViewAnimationOptionCurveLinear : UIViewAnimationOptionCurveEaseInOut;
        

        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f options:option animations:^{
            // 消失的view隐藏在屏幕的左边
            fromView.frame = leftHiddenFrame;
            // 显示在屏幕上
            toView.frame = finialVisibleFrame;
        } completion:^(BOOL finished) {
            // 是否取消
            BOOL canceled = [transitionContext transitionWasCancelled];
            if (canceled) {
                // 如果取消就移除toView
                [toView removeFromSuperview];
            }
            // 一定要调用这个方法, 告诉系统动画已经执行完成
            [transitionContext completeTransition:!canceled];
        }];
  
    }
    
    if (self.operationType == UINavigationControllerOperationPop) {

        toView.frame = leftHiddenFrame;
        // 添加toView在下面
        [containerView insertSubview:toView belowSubview:fromView];
        [self drawShadowForView:fromView];

        UIViewAnimationOptions option = self.isInteractionAnimation ? UIViewAnimationOptionCurveLinear : UIViewAnimationOptionCurveEaseInOut;
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f options:option animations:^{
            fromView.frame = rightHiddenFrame;
            toView.frame = finialVisibleFrame;
        } completion:^(BOOL finished) {
            BOOL canceled = [transitionContext transitionWasCancelled];
            if (canceled) {
                [toView removeFromSuperview];
            }
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

- (void)drawShadowForView:(UIView *)view {
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 3.0f;
    view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:view.bounds] CGPath];
    view.layer.shadowOffset = CGSizeZero;
    view.layer.shadowOpacity = 0.3f;
    
}
@end
