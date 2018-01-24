//  JCShareView.m
//  HeartAlarmClock
/**
 * ━━━━━━神兽出没━━━━━━
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛Code is far away from bug with the animal protecting
 * 　　　　┃　　　┃    神兽保佑,代码无bug
 * 　　　　┃　　　┃
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 *
 * ━━━━━━感觉萌萌哒━━━━━━
 */
//  Created by xingjian on 2018/1/24.
//  Copyright © 2018年 xingjian. All rights reserved.杰克
//  @class JCShareView
//  @abstract <#类的描述#>
//  @discussion <#类的功能#>
//

#import "JCShareView.h"
//shareView的边距
#define margin kDeviceScaleFactor(20)
@interface JCShareView ()

@end

@implementation JCShareView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    [self jcLayoutMyUI];
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self jcLayoutMyUI];
    return self;
}
#pragma mark - 布局UI
- (void)jcLayoutMyUI
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor=[UIColor blackColor];
    self.alpha=0.5f;
    [kUIWindow addSubview:self];
    self.hidden = YES;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *jcTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jcClickTap:)];
    [self addGestureRecognizer:jcTap];
    
    _shareView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 230/2.0)];
    _shareView.backgroundColor = UIColorWithRGB(241, 241, 241);
    [kUIWindow addSubview:_shareView];
    _shareView.hidden = YES;
}
- (void)jcClickTap:(UITapGestureRecognizer *)jcTap
{
    [self hide];
}
- (void)setJcType:(NSInteger)jcType
{
    _jcType = jcType;
    NSArray *titles;
    NSArray *images;
    if (self.jcType == 0) {
        titles = @[@"微信好友",@"朋友圈",@"复制链接"];
        images =@[@"微信.png",@"朋友圈.png",@"复制链接-2.png"];
    }
    else if (self.jcType == 1)
    {
        titles = @[@"微信好友",@"朋友圈",@"复制链接"];
        images =@[@"微信.png",@"朋友圈.png",@"复制链接-2.png"];

    }
    
    
    CGFloat btnWidth = 50;
    CGFloat hSpace = (CGRectGetWidth(_shareView.frame) - 3*btnWidth)/4.0;
    CGFloat vSpace = kDeviceScaleFactor(30);
    CGFloat originY = kDeviceScaleFactor(20);
    for (int i = 0; i < titles.count; i++)
    {
        if (i % 3 == 0 && i != 0) {
            originY += kDeviceScaleFactor(59 + 10 + 15) + vSpace;
        }
        UIButton *btn = [UIButton createButtonWithFrame:CGRectMake(hSpace + (i % 3) * (btnWidth + hSpace), originY, btnWidth, btnWidth) title:nil imageName:images[i] bgImageName:nil superView:_shareView];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lab = [[UILabel alloc]init];
        lab.tag = 2000 + i;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont fontScaleByDevice:22];
        lab.textColor =UIColorWithRGBHex(0x777777);
        lab.numberOfLines = 1;
        [_shareView  addSubview:lab];
        lab.sd_layout.topSpaceToView(btn,kDeviceScaleFactor(10)).leftEqualToView(btn).widthIs(btnWidth).autoHeightRatio(0);
        lab.text = titles[i];
    }

}
#pragma mark - event method -
-(void)cancelAction
{
    [self hide];
}
//显示
-(void)show
{
    self.hidden=NO;
    _shareView.hidden = NO;
    __block CGRect frame = _shareView.frame;
    [UIView animateWithDuration:0.3f animations:^{
        frame.origin.y = SCREEN_HEIGHT - 230/2.0-JC_TabbarSafeBottomMargin;
        _shareView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}
//隐藏
-(void)hide
{
    self.hidden=YES;
    
    __block CGRect frame = _shareView.frame;
    [UIView animateWithDuration:0.3f animations:^{
        frame.origin.y = SCREEN_HEIGHT;
        _shareView.frame = frame;
    } completion:^(BOOL finished) {
        _shareView.hidden = YES;
    }];
    
}
-(void)shareAction:(UIButton*)sender
{
    [self hide];
    NSInteger index = sender.tag - 1000;
    if (_delegate && [_delegate respondsToSelector:@selector(shareWithType:)])
    {
        [_delegate shareWithType:[NSString stringWithFormat:@"%ld",(long)index]];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
