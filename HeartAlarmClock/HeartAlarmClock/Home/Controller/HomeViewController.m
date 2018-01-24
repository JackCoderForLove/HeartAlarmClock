//  HomeViewController.m
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
//  Created by xingjian on 2018/1/16.
//  Copyright © 2018年 xingjian. All rights reserved.杰克
//  @class HomeViewController
//  @abstract 主页
//  @discussion <#类的功能#>
//

#import "HomeViewController.h"
#import "EvaluateRemindModel.h"
#import "EvaluateRemindManger.h"
#import "SettingViewController.h"
#import "ClockSettingViewController.h"


@interface HomeViewController ()
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)NSMutableArray *jcRemindData;
@property(nonatomic,strong)UIImageView *topImgView;
@property(nonatomic,strong)UIImageView *bottomImgView;
@property(nonatomic,strong)UITableView *remindTable;
@end

@implementation HomeViewController


#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self jcConfigData];
    [self jcLayoutMyUI];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self jcGetRemindDataRequest];
    });
    //获取数据
    NSLog(@"获取数据%@",[[EvaluateRemindManger shareManger]jcAllData]);
}
- (void)layoutNavigationBar
{
    self.navigationBarSelf.leftView = self.leftBtn;
    self.navigationBarSelf.rightView = self.rightBtn;
}
- (void)jcConfigData
{
    EvaluateRemindModel *model = [EvaluateRemindModel new];
    model.evaluateRemindId = @"123";
    model.remindTime = @"13:51";
    model.remindDate = @[@"1",@"2",@"3",@"4",@"5"];
    model.status = @0;
    EvaluateRemindModel *model1 = [EvaluateRemindModel new];
    model1.evaluateRemindId = @"124";
    model1.remindTime = @"13:52";
    model1.remindDate = @[@"1",@"2",@"3",@"5",@"6"];
    model1.status = @0;
    [[EvaluateRemindManger shareManger]saveDataWithModel:model];
    [[EvaluateRemindManger shareManger]saveDataWithModel:model1];
}
- (void)jcLayoutMyUI
{
        self.view.backgroundColor = [UIColor whiteColor];
}
//获取本地提醒数据
- (void)jcGetRemindDataRequest
{
  
    self.jcRemindData = [[EvaluateRemindManger shareManger]jcAllData];
    //刷新表格数据
    //设置本地通知
    [self jcSetLocalNotification];
    
}
//点击主页
- (void)jcLeftBtnOnClick:(UIButton *)sender
{
    NSLog(@"点击主页");
    //跳转到设置页面
    SettingViewController *settingVC = [SettingViewController new];
    [self.navigationController pushViewController:settingVC animated:YES];
    //跳转到关于我们
//    AboutusViewController *aboutVC = [AboutusViewController new];
//    [self.navigationController pushViewController:aboutVC animated:YES];
  
}

//点击添加
- (void)jcRightBtnOnClick:(UIButton *)sender
{
    NSLog(@"点击添加");
    ClockSettingViewController *clockVC = [ClockSettingViewController new];
    [self.navigationController pushViewController:clockVC animated:YES];
    
}
- (void)jcSetLocalNotification
{
    //获取所有通知
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in localNotifications)
    {
        NSDictionary *userInfo = notification.userInfo;
        NSLog(@"杰克提醒通知:%@",userInfo);
    }
    
    //先移除本地所有通知
    [self deleteAllLocalNotifcation];
    //添加本地通知
    for (int i = 0; i<self.jcRemindData.count; i++)
    {
        EvaluateRemindModel *remindModel = [self.jcRemindData objectAtIndex:i];
        if (remindModel.status.integerValue == 1) {
            //如果通知提醒是关闭状态，则继续下一个循环
            continue;
        }
        else if(remindModel.status.integerValue == 0)
        {
            //如果通知提醒是开启状态，则添加本地通知提醒
            [self addMineLocalNotification:remindModel againTime:remindModel.remindDate];
        }
        
    }
    NSArray *alocalNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in alocalNotifications)
    {
        NSDictionary *userInfo = notification.userInfo;
        NSLog(@"杰克添加完之后通知:%@",userInfo);
    }
    
}

/**
 自定义闹钟    有重复
 
 @param remindModel 巡逻提醒数据
 @param array 要重复的日期（周几）
 */
-(void)addMineLocalNotification:(EvaluateRemindModel *)remindModel againTime:(NSArray *)array
{
    NSArray *clockTimeArray = [remindModel.remindTime componentsSeparatedByString:@":"];
    NSDate *dateNow = [NSDate date];
    //获取今天是周几
    NSInteger jcIndex = [self jcgetweekDayWithDate:dateNow];
    NSLog(@"周几:%ld",jcIndex);
    //获取该周周一的日期
    NSDate *jcFirstDate = [self jcgetFirstDayWithDate:dateNow withDay:jcIndex-1];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //设置这个时区就不符合本地通知的时区了，很坑爹
    //[calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //[comps setTimeZone:[NSTimeZone timeZoneWithName:@"CMT"]];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:jcFirstDate];
    [comps setHour:[[clockTimeArray objectAtIndex:0] intValue]];
    [comps setMinute:[[clockTimeArray objectAtIndex:1] intValue]];
    [comps setSecond:0];
    [comps setWeekday:2];
    // NSInteger startDay =(NSInteger) array.firstObject;
    //    [comps setFirstWeekday:startDay];
    
    int i = 0;
    int j = 0;
    int days = 0;
    NSInteger count = [array count];
    NSMutableArray *jcArr = [NSMutableArray array];
    NSArray *tempWeekdays = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6",@"7", nil];
    //查找设定的周期模式
    for (i = 0; i < count; i++) {
        for (j = 0; j < 7; j++) {
            if ([[array objectAtIndex:i]integerValue] == [[tempWeekdays objectAtIndex:j]integerValue]) {
                [jcArr addObject:[NSNumber numberWithInt:[[tempWeekdays objectAtIndex:j]intValue]-1]];
                break;
            }
        }
    }
    //  根据相差天数  计算出第一次响铃的日期  并设置周循环
    for (i = 0; i < jcArr.count; i++) {
        days = [jcArr[i]intValue];
        
        NSDate *newFireDate = [[calendar dateFromComponents:comps] dateByAddingTimeInterval:3600 * 24 * days];
        NSDate *jcCPFirDate = [[calendar dateFromComponents:comps] dateByAddingTimeInterval:3600 * 24 * days];
        NSString *jcNewDateStr = [ToolsHelper jcGetGLNZTimeStrWithDate:jcCPFirDate  withFormatter:@"yyyy-MM-dd"];
        NSString *jcNowDateStr = [ToolsHelper jcGetGLNZTimeStrWithDate:[NSDate date] withFormatter:@"yyyy-MM-dd"];
        NSDate *jcNewDate = [ToolsHelper jcGetDateWithString:jcNewDateStr withFormatter:@"yyyy-MM-dd"];
        NSDate *jcNowDate = [ToolsHelper jcGetDateWithString:jcNowDateStr withFormatter:@"yyyy-MM-dd"];
            UILocalNotification *newNotification = [[UILocalNotification alloc] init];
            if (newNotification) {
                newNotification.fireDate = newFireDate ;
           //     newNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:3] ;
    //            newNotification.timeZone =  [NSTimeZone timeZoneWithName:@"GMT"];
                newNotification.alertBody =  @"评测时间到了！快去评测吧!";
                newNotification.applicationIconBadgeNumber = 0;
                newNotification.hasAction = YES;
               // newNotification.alertLaunchImage = @"老子今天没睡觉.png";
                newNotification.soundName = UILocalNotificationDefaultSoundName;
                newNotification.repeatInterval = NSCalendarUnitWeekOfYear;
                NSDictionary * info = @{@"infoKey":remindModel.evaluateRemindId,@"fireDate":newFireDate};
                newNotification.userInfo = info;
                [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
            }
            NSLog(@"Post new localNotification:%@", [newNotification fireDate]);
    }
}
//获取当天是周几
- (NSInteger) jcgetweekDayWithDate:(NSDate *) date
{
    NSCalendar * calendar = [NSCalendar currentCalendar]; // 指定日历的算法
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //[calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //[comps setTimeZone:[NSTimeZone timeZoneWithName:@"CMT"]];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    
    // 1 是周日，2是周一 3.以此类推
    return [comps weekday]-1;
    
}
//获取该周周一的日期
- (NSDate *)jcgetFirstDayWithDate:(NSDate *)date withDay:(NSInteger)day
{
    NSCalendar * calendar = [NSCalendar currentCalendar]; // 指定日历的算法
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    // [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //[comps setTimeZone:[NSTimeZone timeZoneWithName:@"CMT"]];
    [comps setDay:-day];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *newdate = [calendar dateByAddingComponents:comps toDate:date options:0];
    
    return newdate;
}
//获取该周周一的日期
- (NSDate *)jcgetAfterDayWithDate:(NSDate *)date withDay:(NSInteger)day
{
    NSCalendar * calendar = [NSCalendar currentCalendar]; // 指定日历的算法
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //[calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //[comps setTimeZone:[NSTimeZone timeZoneWithName:@"CMT"]];
    [comps setDay:day];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *newdate = [calendar dateByAddingComponents:comps toDate:date options:0];
    
    return newdate;
}
/**
 删除某一个巡逻提醒   开关关闭
 
 @param model 要删除的巡逻提醒数据
 */
-(void) deleteLocalNotification:(EvaluateRemindModel *)model
{
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in localNotifications)
    {
        NSDictionary *userInfo = notification.userInfo;
        if (model.evaluateRemindId.integerValue == [userInfo[@"infoKey"]integerValue]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}

/**
 删除某一个巡逻提醒   开关关闭
 
 @param dict 要删除的巡逻提醒数据
 */
- (void)deleteAllLocalNotifcation
{
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
}

#pragma mark - UITableViewDelegate

#pragma mark - Public

#pragma mark - Private

#pragma mark - Getter
- (UIButton *)leftBtn
{
    if (!_leftBtn)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"菜单.png"] forState:UIControlStateNormal];
        _leftBtn.frame = CGRectMake(0, 0, 42, 42);
        [_leftBtn addTarget:self action:@selector(jcLeftBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _leftBtn;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"添加2.png"] forState:UIControlStateNormal];
        _rightBtn.frame = CGRectMake(0, 0, 42, 42);
        [_rightBtn addTarget:self action:@selector(jcRightBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _rightBtn;
}
- (UIImageView *)topImgView
{
    if (!_topImgView) {
        
        _topImgView = [UIImageView new];
        _topImgView.image = [UIImage imageNamed:@""];
    }
    return _topImgView;
}

- (UIImageView *)bottomImgView
{
    if (!_bottomImgView) {
        
        _bottomImgView = [UIImageView new];
        _bottomImgView.image = [UIImage imageNamed:@""];
    }
    return _bottomImgView;
}
#pragma mark - Setter

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
