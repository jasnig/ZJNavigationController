//
//  ZJNavigationBar.m
//  ZJNavigationController
//
//  Created by ZeroJ on 16/9/19.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJNavigationBar.h"

@interface ZJNavigationBar ()
@property (strong, nonatomic) UIView *statusBarView;
@property (strong, nonatomic) UIView *contentView;

@end

@implementation ZJNavigationBar

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    // 设置背景色---- 有透明度
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.95f];
    [self addSubview:self.contentView];
    [self addSubview:self.statusBarView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.backgroundColor = [UIColor redColor];
    self.titleView = titleLabel;
    
    UIButton *leftBtn = [[UIButton alloc] init];
     //layoutSubviews中会调整, 只有设置的宽度有效
    leftBtn.frame = CGRectMake(0.0f, 0.0f, 44.0f, 0.0f);
    
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnOnClick) forControlEvents:UIControlEventTouchUpInside];

    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    leftBtn.backgroundColor = [UIColor redColor];
    self.leftBackButton = leftBtn;
    
}

- (void)leftBtnOnClick {
    UIViewController *vc = [self getViewController];
    if (vc.navigationController) {
        if (vc.navigationController.viewControllers.count > 1) {
            
            [vc.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (UIViewController *)getViewController {
    UIResponder *nextResponder = self;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        else {
            nextResponder = nextResponder.nextResponder;
        }
    }
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat statusBarHeight = 20.0f;
    CGFloat leftOrRightMargin = 10.0f;
    self.statusBarView.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, statusBarHeight);
    self.contentView.frame = CGRectMake(0.0f, statusBarHeight, self.bounds.size.width, self.bounds.size.height - statusBarHeight);
    self.titleView.frame = CGRectOffset(self.titleView.bounds, (self.contentView.bounds.size.width-self.titleView.bounds.size.width)/2, (self.contentView.bounds.size.height-self.titleView.bounds.size.height)/2);
    if (_leftBackButton) {
        CGFloat leftBtnHeight = _leftBackButton.bounds.size.height != 0 ? _leftBackButton.bounds.size.height : self.contentView.bounds.size.height;
        CGFloat leftBtnY = (self.contentView.bounds.size.height-leftBtnHeight)/2;
        _leftBackButton.frame = CGRectMake(leftOrRightMargin, leftBtnY, _leftBackButton.bounds.size.width, leftBtnHeight);

    }
    if (_rightView) {

        _rightView.frame = CGRectMake(self.bounds.size.width - _rightView.bounds.size.width - leftOrRightMargin, 0.f, _rightView.bounds.size.width, self.contentView.bounds.size.height);
    }
    if (_leftView) {
        CGFloat leftViewHeight = _leftView.bounds.size.height != 0 ? _leftView.bounds.size.height : self.contentView.bounds.size.height;
        CGFloat leftViewY = (self.contentView.bounds.size.height-leftViewHeight)/2;

        _leftView.frame = CGRectMake(leftOrRightMargin, leftViewY, _leftView.bounds.size.width, leftViewHeight);
    }
}


- (void)setTitle:(NSString *)title {
    _title = title;
    if (_titleView && [_titleView isKindOfClass:[UILabel class]]) {
        UILabel *titleLabel = ((UILabel *)_titleView);
        if (titleLabel) {
            titleLabel.text = title;
            [titleLabel sizeToFit];
            
        }
        
    }
}

- (void)setLeftBackButton:(UIButton *)leftBackButton {
    if (_leftBackButton) {
        [_leftBackButton removeFromSuperview];
        _leftBackButton = nil;
    }
    _leftBackButton = leftBackButton;
    [self.contentView addSubview:_leftBackButton];

}

- (void)setTitleView:(UIView *)titleView {
    if (_titleView) {
        [_titleView removeFromSuperview];
        _titleView = nil;
    }
    _titleView = titleView;
    [self.contentView addSubview:_titleView];
}

- (void)setLeftView:(UIView *)leftView {
    if (_leftBackButton) {
        [_leftBackButton removeFromSuperview];
        _leftBackButton = nil;
    }
    if (_leftView) {
        [_leftView removeFromSuperview];
        _leftView = nil;
    }
    _leftView = leftView;
    [self.contentView addSubview:_leftView];
}

- (void)setRightView:(UIView *)rightView {
    if (_rightView) {
        [_rightView removeFromSuperview];
        _rightView = nil;
    }
    _rightView = rightView;
    [self.contentView addSubview:_rightView];
}

- (void)setStatusBarBackgroundColor:(UIColor *)statusBarBackgroundColor {
    _statusBarBackgroundColor = statusBarBackgroundColor;
    self.statusBarView.backgroundColor = statusBarBackgroundColor;
}


- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        
    }
    return _contentView;
}

- (UIView *)statusBarView {
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] init];
        _statusBarView.backgroundColor = [UIColor clearColor];
        
    }
    return _statusBarView;

}

@end
