//
//  JRBFooterView.m
//  JRB
//
//  Created by weixhe on 16/5/6.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "TKFooterView.h"

@interface TKFooterView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UIActivityIndicatorView *loading;


@end

@implementation TKFooterView

- (void)prepare
{
    [super prepare];
    
    self.mj_h = kDeviceScaleFactor(60);
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorWithRGBHex(0xaaaaaa);
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    self.label = label;
    self.label.hidden = YES;
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pc_jiaoyilogo_"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    // loading
    self.loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:self.loading];
    
    self.automaticallyHidden = YES;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    
    self.label.frame = CGRectMake(0, self.mj_h - kDeviceScaleFactor(25), self.mj_w, kDeviceScaleFactor(20));
    
    self.logo.frame = CGRectMake(0, self.mj_h - kDeviceScaleFactor(50), kDeviceScaleFactor(89), kDeviceScaleFactor(32));
    self.logo.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    
    self.loading.center = CGPointMake(kDeviceScaleFactor(60), self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉加载";
            [self.loading stopAnimating];
            break;
        case MJRefreshStatePulling:
            self.label.text = @"松开即可加载";
            [self.loading stopAnimating];
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在加载";
            [self.loading startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"没有更多故事了";
            [self.loading stopAnimating];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    //    CGFloat red = 1.0 - pullingPercent * 0.5;
    //    CGFloat green = 0.5 - 0.5 * pullingPercent;
    //    CGFloat blue = 0.5 * pullingPercent;
    //    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


@end
