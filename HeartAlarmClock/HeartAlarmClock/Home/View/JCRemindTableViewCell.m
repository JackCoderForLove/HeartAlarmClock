//  JCRemindTableViewCell.m
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
//  Created by xingjian on 2018/1/25.
//  Copyright © 2018年 xingjian. All rights reserved.杰克
//  @class JCRemindTableViewCell
//  @abstract 首页闹钟提醒Cell
//  @discussion <#类的功能#>
//


#import "JCRemindTableViewCell.h"
#import "EvaluateRemindModel.h"
#import "EvaluateRemindManger.h"

@interface JCRemindTableViewCell ()
@property(nonatomic,strong)UILabel *timeLab;//时间Lab
@property(nonatomic,strong)UILabel *tipLab;//标签Lab
@property(nonatomic,strong)UISwitch *jcSwitch;//开关btn
@property(nonatomic,strong)UILabel  *dateLab;//日期lab

@end

@implementation JCRemindTableViewCell
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
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 30;
    self.backgroundColor = [ToolsHelper colorWithHexString:@"#2e2e30"];
    [self addSubview:self.timeLab];
    [self addSubview:self.tipLab];
    [self addSubview:self.dateLab];
    [self addSubview:self.jcSwitch];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(25);
        make.top.mas_equalTo(self.mas_top).offset(12);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(18);
    }];
    self.timeLab.text = @"10:12";
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLab.mas_centerY);
        make.left.mas_equalTo(self.timeLab.mas_right).offset(15);
        make.width.mas_equalTo(KScreenWidth-90-60-15);
        make.height.mas_equalTo(12);
    }];
    self.tipLab.text = @"闹钟";
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-90-60-15);
        make.height.mas_equalTo(12);
        make.left.mas_equalTo(self.mas_left).offset(25);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(7);
    }];
  
    [self.jcSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.jcSwitch addTarget:self action:@selector(jcSwitchChange:) forControlEvents:UIControlEventValueChanged];
    
    
}
- (NSString *)jcGetDescStr
{
    NSString *jcDescStr = [NSString string];
    if (self.reModel.remindDate.count == 0)
    {
        //仅一次
        jcDescStr = @"仅一次";
        
    }
    else if (self.reModel.remindDate.count == 7)
    {
        jcDescStr = @"每天";
    }
    else
    {
        for (int i = 0; i<self.reModel.remindDate.count; i++) {
            NSNumber *jcItemStr = [self.reModel.remindDate objectAtIndex:i];
            jcDescStr = [jcDescStr stringByAppendingString:[self jcDateItemStr:jcItemStr]];
            if (self.reModel.remindDate.count>1) {
                if (i!=self.reModel.remindDate.count-1) {
                    jcDescStr = [jcDescStr stringByAppendingString:@"、"];
                }
            }
        }
    }
    return jcDescStr;
}
- (NSString *)jcDateItemStr:(NSNumber *)jcItem
{
    NSString *jcItemStr;
    if (jcItem.intValue == 1) {
        jcItemStr = @"周一";
    }
    else if (jcItem.intValue == 2)
    {
        jcItemStr = @"周二";
    }
    else if (jcItem.intValue == 3)
    {
        jcItemStr = @"周三";
    }
    else if (jcItem.intValue == 4)
    {
        jcItemStr = @"周四";
    }
    else if (jcItem.intValue == 5)
    {
        jcItemStr = @"周五";
    }
    else if (jcItem.intValue == 6)
    {
        jcItemStr = @"周六";
    }
    else if (jcItem.intValue == 7)
    {
        jcItemStr = @"周日";
    }
    return jcItemStr;
}
- (void)jcSwitchChange:(UISwitch *)jcSwitch
{
    NSInteger jcStatus = jcSwitch.isOn == YES?0:1;
    _reModel.status = jcStatus;
    [[EvaluateRemindManger shareManger]saveDataWithModel:_reModel];

}
- (void)setReModel:(EvaluateRemindModel *)reModel
{
    _reModel = reModel;
    self.timeLab.text = _reModel.remindTime;
    if (_reModel.status == 0) {
        self.jcSwitch.on = YES;
    }
    else
    {
        self.jcSwitch.on = NO;
    }
    self.tipLab.text = self.reModel.remindContent;
    self.dateLab.text = [self jcGetDescStr];
    
    
}
- (UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [UILabel new];
        _timeLab.font = [UIFont systemFontOfSize:45/2.0];
        _timeLab.textColor = [UIColor whiteColor];
        
    }
    return _timeLab;
}

- (UILabel *)tipLab
{
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.font = [UIFont systemFontOfSize:12];
        _tipLab.textColor = [UIColor whiteColor];
    }
    return _tipLab;
}

- (UILabel *)dateLab
{
    if (!_dateLab) {
        _dateLab = [UILabel new];
        _dateLab.textColor = [ToolsHelper colorWithHexString:@"#ed6763"];
        _dateLab.font = [UIFont systemFontOfSize:12];
    }
    return _dateLab;
}

- (UISwitch *)jcSwitch
{
    if (!_jcSwitch) {
        _jcSwitch = [[UISwitch alloc]init];
    }
    return _jcSwitch;
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
