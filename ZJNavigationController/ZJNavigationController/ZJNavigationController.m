//
//  ZJNavigationController.m
//  ZJNavigationController
//
//  Created by ZeroJ on 16/9/19.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJNavigationController.h"
#import "ZJNavigationControllerAnimator.h"
#import "ZJBaseViewController.h"
@interface ZJNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate> {
    BOOL _isInteracting;
}

@property (strong, nonatomic) UIPanGestureRecognizer *fullScreenPanGesture;
@property (strong, nonatomic) ZJNavigationControllerAnimator *animator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactor;
@end

@implementation ZJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)zj_enableFullScreenPop:(BOOL)enabled {
    if (enabled) {
        // 添加手势在系统的手势的view上面
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fullScreenPanGesture];
        // 禁用系统的手势
        self.interactivePopGestureRecognizer.enabled = NO;
        // 设置代理
        self.delegate = self;
        // 隐藏系统的navigationBar
        self.navigationBarHidden = YES;
    }
    else {
        self.delegate = nil;
        _fullScreenPanGesture = nil;
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)panGesture {
    CGPoint transtion = [panGesture translationInView:panGesture.view];
    CGFloat progress = transtion.x / panGesture.view.bounds.size.width;
    progress = MIN(1.0f, MAX(progress, 0.0f)); // 最小为0, 最大为1.0
//    NSLog(@"%f------", progress);
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            // 记录手势开始
            _isInteracting = YES;
            if (self.viewControllers.count > 1) { // 不是第一个页面
                // 执行pop动画 设置为YES
                [self popViewControllerAnimated:YES];
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint transtion = [panGesture translationInView:panGesture.view];
            CGFloat progress = transtion.x / panGesture.view.bounds.size.width;
            progress = MIN(1.0f, MAX(progress, 0.0f)); // 最小为0, 最大为1.0
            // 更新动画执行进度
            [self.interactor updateInteractiveTransition:progress];
            break;
        }
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            if (progress > 0.35) { // 滑动距离较大时视为完成
                // 完成
                [self.interactor finishInteractiveTransition];
            }
            else {
                CGPoint velocity = [panGesture velocityInView:panGesture.view];

                if (velocity.x > 200) { // 滑动距离较小 但是滑动速度很快 视为完成
                    [self.interactor finishInteractiveTransition];
                }
                else {
                    // 取消动画
                    [self.interactor cancelInteractiveTransition];
                }
            }
            // 手势完成
            _isInteracting = NO;
        }
            break;
        default:
            _isInteracting = NO;
            break;
    }
}

#pragma mark - getter ---- setter

- (UIPanGestureRecognizer *)fullScreenPanGesture {
    if (_fullScreenPanGesture == nil) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        pan.delegate = self;
        _fullScreenPanGesture = pan;
        
    }
    return _fullScreenPanGesture;
}

- (ZJNavigationControllerAnimator *)animator {
    if (!_animator) {
        _animator = [ZJNavigationControllerAnimator new];
    }
    return _animator;
}

- (UIPercentDrivenInteractiveTransition *)interactor {
    if (!_interactor) {
        _interactor = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return _interactor;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.fullScreenPanGesture) {
        CGPoint velocity = [self.fullScreenPanGesture velocityInView:self.fullScreenPanGesture.view];
        // 只有一个控制器的时候就不接受手势事件
        if (velocity.x > 0 &&
            self.viewControllers.count > 1) {// 向右滑动时
            return YES;
        }
    }
    return NO;
}


#pragma mark - UINavigationControllerDelegate

// 手势交互对象
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    // 如果使用自定义的动画, 就返回我们的交互对象
    if ([animationController isKindOfClass:[ZJNavigationControllerAnimator class]] &&
        _isInteracting) {
        // 如果手势已经开始才返回self.interactor
        self.animator.isInteractionAnimation = YES;
        return self.interactor;
    }
    else {
        self.animator.isInteractionAnimation = NO;
        // 手势没有开始返回nil, 否则我们的非交互性动画也是不能执行的,
        // 因为系统会优先调用这个代理方法, 如果返回的不是nil, 就不会调用非交互性代理方法了
        return nil;
    }
    
}

// 非交互动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    // 设置类型 pop还是push
    self.animator.operationType = operation;
    return self.animator;
    // 这样使用临时变量是不正确的
//    ZJNavigationControllerAnimator *animator = [ZJNavigationControllerAnimator new];
//    animator.operationType = operation;
//    return animator;
}

// 处理返回按钮的隐藏
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[ZJBaseViewController class]]) {
        ZJBaseViewController *baseVc = (ZJBaseViewController *)viewController;
        if (self.viewControllers.count > 1) {
            baseVc.zj_navigationBar.leftBackButton.hidden = NO;
            
        }
        else {
            baseVc.zj_navigationBar.leftBackButton.hidden = YES;
            
        }
    }
}

@end


@implementation UIViewController (ZJNavigationController)

- (ZJNavigationController *)zj_navigationController {
    return (ZJNavigationController *)self.navigationController;
}

@end
