//  JCTimePickerView.m
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
//  @class JCTimePickerView
//  @abstract 自定义时间选择器滚轮View
//  @discussion <#类的功能#>
//

#import "JCTimePickerView.h"
@interface JCTimePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView *hourPicker;
@property(nonatomic,strong)UIPickerView *minutePicker;
@property(nonatomic,strong)NSMutableArray *hourArr;
@property(nonatomic,strong)NSMutableArray *minuteArr;
@property(nonatomic,strong)UILabel *pointLab;
@property(nonatomic,strong)UILabel *lineTop;
@property(nonatomic,strong)UILabel *lineBottom;
@end
static CGFloat jcMaxRowCount = 16384;
@implementation JCTimePickerView
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
    self.backgroundColor = [UIColor clearColor];
    self.hourArr = [NSMutableArray array];
    self.minuteArr = [NSMutableArray array];
    for (int i = 0; i<24; i++)
    {
        NSString *jcStr = [NSString stringWithFormat:@"%02d",i];
        [self.hourArr addObject:jcStr];
    }
    for (int i = 0; i<60; i++) {
        NSString *jcStr = [NSString stringWithFormat:@"%02d",i];
        [self.minuteArr addObject:jcStr];
    }
    [self addSubview:self.pointLab];
    [self.pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(80/2);
        make.top.mas_equalTo(348/2);
        make.centerX.mas_equalTo(self.mas_centerX);
        
    }];
    [self addSubview:self.lineTop];
    [self addSubview:self.lineBottom];
    self.hourPicker = [[UIPickerView alloc]init];
    self.hourPicker.backgroundColor = [UIColor clearColor];
    [self addSubview:self.hourPicker];
    self.hourPicker.tag = 9001;
    self.hourPicker.delegate = self;
    self.hourPicker.dataSource = self;
    [self.hourPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(110/2);
        make.height.mas_equalTo(370/2.0);
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.right.mas_equalTo(self.pointLab.mas_left);
    }];
    self.minutePicker = [[UIPickerView alloc]init];
    self.minutePicker.backgroundColor = [UIColor clearColor];
    [self addSubview:self.minutePicker];
    self.minutePicker.tag = 9002;
    self.minutePicker.delegate = self;
    self.minutePicker.dataSource = self;
    [self.minutePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(110/2);
        make.height.mas_equalTo(370/2.0);
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.pointLab.mas_right);
    }];
    [self.lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-30);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.mas_top).offset(70);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-30);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-75);
        make.centerX.mas_equalTo(self.mas_centerX);

    }];
    
}
- (void)setJcDateStr:(NSString *)jcDateStr
{
    _jcDateStr = jcDateStr;
    //拆解小时和分钟
    NSArray *jcDateArr = [_jcDateStr componentsSeparatedByString:@":"];
    if (jcDateArr.count == 2)
    {
        NSString *hour = [jcDateArr objectAtIndex:0];
        NSString *minute = [jcDateArr objectAtIndex:1];
        NSInteger jcHourSelctRow = 0;
        NSInteger jcMinuteSelctRow = 0;
        
        if ([self.hourArr indexOfObject:hour]!=NSNotFound) {
            jcHourSelctRow = [self.hourArr indexOfObject:hour]+self.hourArr.count*100;
        }
        else
        {
            jcHourSelctRow = 0+jcMaxRowCount/2;
        }
        if ([self.minuteArr indexOfObject:minute]!=NSNotFound) {
            jcMinuteSelctRow = [self.minuteArr indexOfObject:minute]+self.minuteArr.count*100;
        }
        else
        {
            jcMinuteSelctRow = 0+jcMaxRowCount/2;
        }
        [self.hourPicker selectRow:jcHourSelctRow inComponent:0 animated:YES];
        [self.minutePicker selectRow:jcMinuteSelctRow inComponent:0 animated:YES];
        
    }
}
#pragma mark -
#pragma makr UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.hourPicker)
    {
        //return self.hourArr.count;
        return jcMaxRowCount;
    }
    else
    {
        // return self.minuteArr.count;
        return jcMaxRowCount;
    }
}
#pragma mark -
#pragma mark UIPickerViewDelegate
// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED
{
    return 110/2;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED
{
    return 40;
}

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED
{
    if (pickerView == self.hourPicker) {
        return [self.hourArr objectAtIndex:row%self.hourArr.count];
    }
    else
    {
        return [self.minuteArr objectAtIndex:row%self.minuteArr.count];
    }
    
}
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED; // attributed title is favored if both methods are implemented
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED
{
    UILabel *jcLab = (UILabel*)view;
    if (!jcLab)
    {
        jcLab = [UILabel new];
        jcLab.font = [UIFont fontWithName:@"impact" size:47];
        jcLab.textAlignment = NSTextAlignmentCenter;
        jcLab.textColor = [ToolsHelper colorWithHexString:@"#ffffff"];
        jcLab.backgroundColor = [UIColor clearColor];
        
    }
    //在该代理方法里添加以下两行代码删掉上下的黑线
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];
    jcLab.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return jcLab;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
    NSString *hour = [self.hourArr objectAtIndex:[self.hourPicker selectedRowInComponent:0]%self.hourArr.count];
    NSString *minute = [self.minuteArr objectAtIndex:[self.minutePicker selectedRowInComponent:0]%self.minuteArr.count];
    NSString *jcSelectTimeStr = [NSString stringWithFormat:@"%@:%@",hour,minute];
    if ([self.delegate respondsToSelector:@selector(jcDatePickerSelect:withTimeStr:)]) {
        [self.delegate jcDatePickerSelect:self withTimeStr:jcSelectTimeStr];
    }
    
}
- (UILabel *)pointLab
{
    if (!_pointLab) {
        
        _pointLab = [UILabel new];
        _pointLab.font = [UIFont fontWithName:@"impact" size:47];
        _pointLab.text = @":";
        _pointLab.textAlignment = NSTextAlignmentCenter;
        _pointLab.textColor = [ToolsHelper colorWithHexString:@"#ffffff"];
    }
    return _pointLab;
}
- (UILabel *)lineTop
{
    if (!_lineTop) {
        
        _lineTop = [UILabel new];
        _lineTop.backgroundColor = [ToolsHelper colorWithHexString:@"#666666"];
    }
    return _lineTop;
}
- (UILabel *)lineBottom
{
    if (!_lineBottom) {
        _lineBottom = [UILabel new];
        _lineBottom.backgroundColor = [ToolsHelper colorWithHexString:@"#666666"];
    }
    return _lineBottom;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
