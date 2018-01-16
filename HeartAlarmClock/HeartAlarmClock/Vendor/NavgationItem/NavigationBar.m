//
//  NavigationBar.m
//  App
//
//  Created by weixhe on 16/5/20.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "NavigationBar.h"

@interface NavigationBar ()

@property (nonatomic, strong) UIView *statusBar;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end

@implementation NavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.statusBar = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kStatusBarHeight) bgColor:nil alpha:1 superView:self];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTopHeight);            // 4s,5,6,6plus 的尺寸都是44
        // 屏蔽控制器view的tap事件，如有特殊需求，可进行特殊处理
        [self addTapGesture:^{
            
        }];
        
//        UIView *line = [UIView createViewWithBgColor:CLineColor alpha:.8 superView:self];
//        line.sd_layout
//        .leftEqualToView(self)
//        .bottomEqualToView(self)
//        .rightEqualToView(self)
//        .heightIs(.8);
        
    }
    return self;
}

#pragma mark - Privite

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel createLabelWithFont:[AppTheme font_nav_title] text:self.controller.title superView:self];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.textColor = [AppTheme color_nav_title];
//        _titleLabel.font = [UIFont fontWithName:@"impact" size:16];
        _titleLabel.font = [UIFont fontScaleByDevice:32];
//        _titleLabel.textColor = UIColorWithRGB(119, 119, 119);
        _titleLabel.textColor = UIColorWithRGB(119, 119, 119);

        CGFloat width = SCREEN_WIDTH - 124;
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(10);
            make.height.equalTo(@40);
            make.width.greaterThanOrEqualTo(@(width));
        }];
    }
    return _titleLabel;
}

- (UIView *)bttomLine
{
    if (!_bottomLine) {
        _bottomLine = [UIView createViewWithFrame:CGRectMake(0, self.height - 1, SCREEN_WIDTH, 1) bgColor:UIColorWithRGBHex(0xeeeeee) alpha:1 superView:self];;
    }
    return _bottomLine;
}

- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc] init];
        _gradientLayer.frame = self.bounds;
        [self.layer addSublayer:_gradientLayer];
    }
    return _gradientLayer;
}

#pragma mark - 外部属性 & 方法
- (void)setBgImage:(UIImage *)bgImage
{
    _bgImage = bgImage;
    self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
    
    if (self.statusColor) {
        self.statusBar.backgroundColor = self.statusColor;
    } else {
        self.statusBar.backgroundColor = bgColor;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    if (self.statusColor) {
        self.statusBar.backgroundColor = self.statusColor;
    } else {
        self.statusBar.backgroundColor = backgroundColor;
    }
}

- (void)setStatusColor:(UIColor *)statusColor
{
    _statusColor = statusColor;
    self.statusBar.backgroundColor = _statusColor;
}

// 显示阴影
- (void)setShowShadow:(BOOL)showShadow
{
    _showShadow = showShadow;
    if (showShadow) {
        [self shadowRadius:3 shadowOffset:CGSizeMake(0, 1) shadowOpacity:0.5 shadowColor:[UIColor blackColor]];
        
    } else {
        self.layer.shadowOpacity = 0;
    }
}

// 显示不底部线
- (void)setShowLine:(BOOL)showLine
{
    _showLine = showLine;
    self.bottomLine.hidden = !_showLine;
}

// Title
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTitleAttributions:(NSDictionary <NSString *, id> *)titleAttributions
{
    if ([self.title isNotNull]) {
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.title];
        [string addAttributes:titleAttributions range:NSRangeFromString(self.title)];
        self.titleLabel.attributedText = string;
    }
}

// leftView
- (void)setLeftView:(UIView *)leftView
{
    if (leftView) {
        [_leftView removeFromSuperview];
        _leftView = nil;
        _leftView = leftView;
        [self addSubview:leftView];
        
        UIButton *btn = (UIButton *)leftView;

        btn.sd_layout
        .centerYEqualToView(self.titleLabel)
        .leftSpaceToView(self, kPt(40));
        if (btn.titleLabel.text) {  // 文字
            [btn setupAutoSizeWithHorizontalPadding:10 buttonHeight:30];
        } else if (btn.imageView.image) {
            
            if (btn.imageView.image.size.width == btn.imageView.image.size.height  || btn.imageView.image.size.width > 30   || btn.imageView.image.size.height > 30) {
                btn.sd_layout
                .widthIs(kPt(64))
                .heightIs(kPt(64));
                btn.sd_cornerRadius = @(kPt(32));

            }else{
                [btn setupAutoSizeWithHorizontalPadding:btn.imageView.image.size.width buttonHeight:30];
                btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
            }
            
        }

    }
}

// rightView
- (void)setRightView:(UIView *)rightView
{
    if (rightView) {
        [_rightView removeFromSuperview];
        _rightView = nil;
        _rightView = rightView;
        [self addSubview:rightView];
        
        UIButton *btn = (UIButton *)rightView;
        btn.sd_layout
        .centerYEqualToView(self.titleLabel)
        .rightSpaceToView(self, kPt(40));
        if (btn.titleLabel.text) {  // 文字
            [btn setupAutoSizeWithHorizontalPadding:10 buttonHeight:30];
        } else if (btn.imageView.image) {
            [btn setupAutoSizeWithHorizontalPadding:btn.imageView.image.size.width buttonHeight:30];
        
        }
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);

    }
}

// titleView
- (void)setTitleView:(UIView *)titleView
{
    if (titleView) {
        [_titleView removeFromSuperview];
        _titleView = nil;
        _titleView = titleView;
        [self addSubview:titleView];
        
        _titleView.sd_layout
        .centerXEqualToView(self)
        .centerYIs(kTopHeight / 2)
        .maxHeightIs(kNavBarHeight);
        [_titleView updateLayout];
    }
}

- (void)addGradientColors:(NSArray *)colors
{
    self.gradientLayer.colors = colors;;
}

@end
