//
//  NavigationBar.h
//  App
//
//  Created by weixhe on 16/5/20.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBar : UIView

@property (nonatomic, strong) UIImage *bgImage;

@property (nonatomic, strong) UIColor *statusColor;  // 状态栏的颜色，默认与 bgColor 一致
@property (nonatomic, strong) UIColor *bgColor;

@property (nonatomic, assign) BOOL showShadow;
@property (nonatomic, assign) BOOL showLine;  // 显示底部line

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSDictionary <NSString *, id> *titleAttributions;

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)addGradientColors:(NSArray *)colors;

@end
