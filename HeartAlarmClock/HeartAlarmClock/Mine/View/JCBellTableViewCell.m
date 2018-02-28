//  JCBellTableViewCell.m
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
//  Created by xingjian on 2018/2/27.
//  Copyright © 2018年 xingjian. All rights reserved.杰克
//  @class JCBellTableViewCell
//  @abstract 铃声自定义Cell
//  @discussion <#类的功能#>
//


#import "JCBellTableViewCell.h"

@interface JCBellTableViewCell ()
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *titleLab;
@end

@implementation JCBellTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        
        return nil;
    }
    [self jcLayoutMyUI];
    return self;
}

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
    self.titleLab.text = @"无敌吧啦啦啦";

  
}
- (void)jcConfigNormalState
{
    self.titleLab.textColor = [ToolsHelper colorWithHexString:@"#666666"];
}
- (void)jcConfigSelectState
{
    self.titleLab.textColor = [ToolsHelper colorWithHexString:@"#51e500"];
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
        _titleLab.font = [UIFont systemFontOfSize:15];
        _titleLab.textColor = [ToolsHelper colorWithHexString:@"#666666"];
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
