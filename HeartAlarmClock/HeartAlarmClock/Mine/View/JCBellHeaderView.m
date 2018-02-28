//  JCBellHeaderView.m
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
//  Created by xingjian on 2018/2/28.
//  Copyright © 2018年 xingjian. All rights reserved.杰克
//  @class JCBellHeaderView
//  @abstract 铃声设置headerView
//  @discussion <#类的功能#>
//

#import "JCBellHeaderView.h"
@interface JCBellHeaderView ()
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *titleLab;
@end

@implementation JCBellHeaderView
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
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-60);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-60-25-35);
        make.left.mas_equalTo(self.mas_left).offset(25);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(15);
    }];
    self.titleLab.text = @"主播真会玩";
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLab.text = _title;
    
}
- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont systemFontOfSize:17];
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}
- (UIView *)lineView
{
    if (!_lineView) {
        
        _lineView = [UIView new];
        _lineView.backgroundColor = [ToolsHelper colorWithHexString:@"#666666"];
    }
    return _lineView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
