//
//  JRBHeaderView.m
//  JRB
//
//  Created by weixhe on 16/5/6.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "TKHeaderView.h"

@interface TKHeaderView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UIActivityIndicatorView *loading;

@end

@implementation TKHeaderView
- (void)prepare
{
    [super prepare];
    
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorWithRGBHex(0xaaaaaa);
    label.font = [AppTheme font_15];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_pull_loading_icon"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    self.logo.hidden = YES;
    
    // loading
    self.loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:self.loading];
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = CGRectMake(0, self.mj_h - 24, self.mj_w, 20);
    self.label.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    
    self.logo.bounds = CGRectMake(0, self.logo.mj_y - 26, 30, 30);
    self.logo.center = CGPointMake(self.mj_w * 0.5, self.logo.center.y);
    
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
            self.label.text = @"下拉刷新";
            [self.loading stopAnimating];
            break;
        case MJRefreshStatePulling:
            self.label.text = @"松开即可刷新";
            [self.loading stopAnimating];
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在刷新";
            [self.loading startAnimating];
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
