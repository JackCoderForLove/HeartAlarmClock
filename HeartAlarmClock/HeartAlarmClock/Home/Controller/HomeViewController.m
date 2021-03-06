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
#import "JCRemindTableViewCell.h"



@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,JCRemindTableViewCellDelegate>
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)NSMutableArray *jcRemindData;
@property(nonatomic,strong)UIImageView *topImgView;
@property(nonatomic,strong)UIImageView *middlImgView;
@property(nonatomic,strong)UIImageView *leftBImgView;
@property(nonatomic,strong)UIImageView *rightBImgView;
@property(nonatomic,strong)UIButton  *addBtn;
@property(nonatomic,strong)UIImageView *bottomImgView;
@property(nonatomic,strong)UITableView *remindTable;
@property(nonatomic,strong)UILabel  *timeLab;//时间lab
@property(nonatomic,strong)UILabel *dateLab;//日期lab
@property(nonatomic,strong)UILabel *weekLab;//周几
@property(nonatomic,strong)UILabel *temperatureLab;//温度lab
@property(nonatomic,strong)UIImageView *huluImg;
@property(nonatomic,strong)UIImageView *jchuluBImg;
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
    [self jcLayoutMyUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jcConfigData:) name:@"jcReloadClock" object:nil];
    //定时器 反复执行
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self jcGetRemindDataRequest];
    });
    //获取数据
    NSLog(@"获取数据%@",[[EvaluateRemindManger shareManger]jcAllData]);
    
}
- (void)updateTime
{
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    
    [dataFormatter setDateFormat:@"MM dd HH mm"];
    
    NSString *dateString = [dataFormatter stringFromDate:currentDate];
    NSArray *timeArr = [dateString componentsSeparatedByString:@" "];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@/%@",[timeArr objectAtIndex:0],[timeArr objectAtIndex:1]];
    NSString *timeStr = [NSString stringWithFormat:@"%@:%@",[timeArr objectAtIndex:2],[timeArr objectAtIndex:3]];
    self.dateLab.text = dateStr;
    self.timeLab.text = timeStr;
    //获取周几
//    NSCalendar * cal=[NSCalendar currentCalendar];
//
//    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
//
//    NSDateComponents * conponent= [cal components:unitFlags fromDate:currentDate];
//    NSInteger weekDay = [conponent weekday]+1;
    self.weekLab.text = [self datestr];

    
    
}
//返回周几的问题
- (NSString *)datestr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSArray *weekdayAry = [NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    [dateFormat  setShortWeekdaySymbols:weekdayAry];
    [dateFormat setDateFormat:@"eee"];
    NSDate *date = [NSDate date];
    NSString *srting = [dateFormat stringFromDate:date];
    return srting;
}

- (void)layoutNavigationBar
{
    self.navigationBarSelf.leftView = self.leftBtn;
    self.navigationBarSelf.rightView = self.rightBtn;
}

- (void)jcConfigData:(NSNotification *)noti
{
    self.jcRemindData = [[EvaluateRemindManger shareManger]jcAllData];
    if (self.jcRemindData.count == 0) {
        [self jcLayoutEmptyUI];
    }
    else
    {
        [self jcLayoutDataUI];
    }

    //刷新表格数据
    [self deleteAllLocalNotifcation];
    //设置本地通知
    [self jcSetLocalNotification];
    [self.remindTable reloadData];
}
- (void)jcLayoutMyUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topImgView];
    [self.topImgView addSubview:self.dateLab];
    [self.topImgView addSubview:self.weekLab];
    [self.topImgView addSubview:self.temperatureLab];
    [self.topImgView addSubview:self.timeLab];
    [self.view addSubview:self.middlImgView];
    [self.view addSubview:self.addBtn];
    [self.view addSubview:self.leftBImgView];
    [self.view addSubview:self.rightBImgView];
    [self.view addSubview:self.huluImg];
    [self.view addSubview:self.jchuluBImg];
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(543/2.0);
        make.height.mas_equalTo(313/2.0);
        make.top.mas_equalTo(self.view.mas_top).offset(130/2.0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.huluImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(495/2.0);
        make.height.mas_equalTo(76/2.0);
        make.top.mas_equalTo(self.topImgView.mas_bottom).offset(54/2.0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.jchuluBImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(732/2.0);
        make.height.mas_equalTo(335/2.0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-JC_TabbarSafeBottomMargin);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.weekLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
        make.centerX.mas_equalTo(self.topImgView.mas_centerX);
        make.top.mas_equalTo(self.topImgView.mas_top).offset(50);
    }];
    [self.temperatureLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(self.weekLab.mas_right).offset(15);
        make.top.mas_equalTo(self.topImgView.mas_top).offset(50);
    }];
    self.temperatureLab.hidden = YES;
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(self.weekLab.mas_left).offset(-15);
        make.top.mas_equalTo(self.topImgView.mas_top).offset(50);
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.topImgView.mas_centerX);
        make.top.mas_equalTo(self.dateLab.mas_bottom).offset(2);
    }];
    CGFloat jcMiddleY = 60/2;
    CGFloat jcAddY = 80/2;
    if (isIphone_5) {
        jcMiddleY = 20/2;
        jcAddY = 20/2;
    }
    [self.middlImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(394/2.0);
        make.height.mas_equalTo(378/2.0);
        make.top.mas_equalTo(self.topImgView.mas_bottom).offset(jcMiddleY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(182/2.0);
        make.height.mas_equalTo(182/2.0);
        make.top.mas_equalTo(self.middlImgView.mas_bottom).offset(jcAddY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.leftBImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(254/2.0);
        make.height.mas_equalTo(157/2.0);
        make.top.mas_equalTo(self.addBtn.mas_centerY);
        make.right.mas_equalTo(self.addBtn.mas_left).offset(22);
    }];
    [self.rightBImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(117/2.0);
        make.height.mas_equalTo(227/2.0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-JC_TabbarSafeBottomMargin);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    [self updateTime];
    [self.view addSubview:self.remindTable];
    //布局空页面
//    [self jcLayoutDataUI];
    //获取唯一id
//    NSString *jcID = [ToolsHelper jcGetIdentifyID];
//    NSLog(@"唯一的id:%@",jcID);
    
}
//布局空页面
- (void)jcLayoutEmptyUI
{

    self.middlImgView.hidden = NO;
    self.addBtn.hidden = NO;
    self.leftBImgView.hidden = NO;
    self.rightBImgView.hidden = NO;
    self.jchuluBImg.hidden = YES;
    self.huluImg.hidden = YES;
    self.remindTable.hidden = YES;
    
}
//布局有数据页面
- (void)jcLayoutDataUI
{
    self.middlImgView.hidden = YES;
    self.addBtn.hidden = YES;
    self.leftBImgView.hidden = YES;
    self.rightBImgView.hidden = YES;
    self.jchuluBImg.hidden = NO;
    self.huluImg.hidden = NO;
    self.remindTable.hidden = NO;

}
//获取本地提醒数据
- (void)jcGetRemindDataRequest
{
  
    self.jcRemindData = [[EvaluateRemindManger shareManger]jcAllData];
    if (self.jcRemindData.count == 0) {
        [self jcLayoutEmptyUI];
    }
    else
    {
        [self jcLayoutDataUI];
    }
    //刷新表格数据
    [self deleteAllLocalNotifcation];
    //设置本地通知
    [self jcSetLocalNotification];
    [self.remindTable reloadData];
    
}
//点击主页
- (void)jcLeftBtnOnClick:(UIButton *)sender
{
    NSLog(@"点击主页");
    //跳转到设置页面
    SettingViewController *settingVC = [SettingViewController new];
    [self.navigationController pushViewController:settingVC animated:YES];
  
}

//点击添加
- (void)jcRightBtnOnClick:(UIButton *)sender
{
    NSLog(@"点击添加");
    ClockSettingViewController *clockVC = [ClockSettingViewController new];
    clockVC.remindModel = nil;
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
        if (remindModel.status == 1) {
            //如果是关闭
            continue;
        }
        else
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
- (void)jcRemindTableViewChange:(JCRemindTableViewCell *)jcCell withModel:(EvaluateRemindModel *)remodel
{
    //修改本地数据
    remodel.status = remodel.status==0?1:0;
    [[EvaluateRemindManger shareManger]saveDataWithModel:remodel];
    if (remodel.status == 0) {
        //如果是开启，则添加本地通知提醒
        [self addMineLocalNotification:remodel againTime:remodel.remindDate];
    }
    else if (remodel.status == 1)
    {
        //如果是关闭，删除本地单个通知提醒
        [self deleteLocalNotification:remodel];
        
    }}

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
    NSDate *jcFirstDate = [self jcgetFirstDayWithDate:dateNow withDay:jcIndex];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //设置这个时区就不符合本地通知的时区了，很坑爹
    //[calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //[comps setTimeZone:[NSTimeZone timeZoneWithName:@"CMT"]];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:dateNow];
    [comps setHour:[[clockTimeArray objectAtIndex:0] intValue]];
    [comps setMinute:[[clockTimeArray objectAtIndex:1] intValue]];
    [comps setSecond:0];
    [comps setWeekday:2];
    // NSInteger startDay =(NSInteger) array.firstObject;
    //    [comps setFirstWeekday:startDay];
    
    int i = 0;
    int j = 0;
    NSInteger days = 0;
    NSInteger count = [array count];
    NSMutableArray *jcArr = [NSMutableArray array];
    NSArray *tempWeekdays = [NSArray arrayWithObjects:@"7",@"1", @"2", @"3", @"4", @"5", @"6", nil];
    //查找设定的周期模式
    for (i = 0; i < count; i++) {
        for (j = 0; j < 7; j++) {
            if ([[array objectAtIndex:i]integerValue] == [[tempWeekdays objectAtIndex:j]integerValue]) {
                [jcArr addObject:[NSNumber numberWithInt:j+1]];
                break;
            }
        }
    }
    
    if (count == 0) {
        //如果日期为空，则为永不重复
        [jcArr addObject:[NSNumber numberWithInteger:jcIndex]];
    }
    //  根据相差天数  计算出第一次响铃的日期  并设置周循环
    for (i = 0; i < jcArr.count; i++) {
      NSInteger  temp = [jcArr[i]integerValue] - jcIndex;
        days = (temp >= 0 ? temp : temp + 7);
        
        NSDate *newFireDate = [[calendar dateFromComponents:comps] dateByAddingTimeInterval:3600 * 24 * days];
        NSDate *jcCPFirDate = [[calendar dateFromComponents:comps] dateByAddingTimeInterval:3600 * 24 * days];
        NSString *jcNewDateStr = [ToolsHelper jcGetGLNZTimeStrWithDate:jcCPFirDate  withFormatter:@"yyyy-MM-dd"];
        NSString *jcNowDateStr = [ToolsHelper jcGetGLNZTimeStrWithDate:[NSDate date] withFormatter:@"yyyy-MM-dd"];
//        NSDate *jcNewDate = [ToolsHelper jcGetDateWithString:jcNewDateStr withFormatter:@"yyyy-MM-dd"];
//        NSDate *jcNowDate = [ToolsHelper jcGetDateWithString:jcNowDateStr withFormatter:@"yyyy-MM-dd"];
            UILocalNotification *newNotification = [[UILocalNotification alloc] init];
            if (newNotification) {
                newNotification.fireDate = newFireDate;
               // newNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10] ;
    //            newNotification.timeZone =  [NSTimeZone timeZoneWithName:@"GMT"];
                newNotification.alertBody =  remindModel.remindContent;
                newNotification.applicationIconBadgeNumber = 0;
                newNotification.hasAction = YES;
                //newNotification.soundName = UILocalNotificationDefaultSoundName;
                NSString *jcSoundName = remindModel.soundName.length==0?@"动物园":remindModel.soundName;
                newNotification.soundName = [NSString stringWithFormat:@"%@.wav",jcSoundName];
                if (array.count == 0) {
                     newNotification.repeatInterval = 0;
                }
                else
                {
                     newNotification.repeatInterval = NSCalendarUnitWeekOfYear;
                }
               
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
    return [comps weekday];
    
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
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.jcRemindData.count;
//    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *jcCellID = @"jcCellID";
    JCRemindTableViewCell *jcCell = [tableView dequeueReusableCellWithIdentifier:jcCellID];
    if (!jcCell) {
        jcCell = [[JCRemindTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jcCellID];
    }
    jcCell.selectionStyle = UITableViewCellSelectionStyleNone;
    EvaluateRemindModel *jcModel = [self.jcRemindData objectAtIndex:indexPath.section];
    jcCell.delegate = self;
    jcCell.reModel = jcModel;
    return jcCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了%ld",indexPath.section);
    ClockSettingViewController *clockVC = [ClockSettingViewController new];
    EvaluateRemindModel *remindModel = [self.jcRemindData objectAtIndex:indexPath.section];
    clockVC.remindModel = remindModel;
    [self.navigationController pushViewController:clockVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
     
        //1 获取当前选择的数据Model
        EvaluateRemindModel *eveModel =[self.jcRemindData objectAtIndex:indexPath.section];
        [[EvaluateRemindManger shareManger]deleteDataWithModel:eveModel];
        //删除本地通知提醒
        [self deleteLocalNotification:eveModel];
        self.jcRemindData  = [[EvaluateRemindManger shareManger]jcAllData];
        if (self.jcRemindData.count == 0) {
            [self jcLayoutEmptyUI];
        }
        else
        {
            [self jcLayoutDataUI];
        }
        [self.remindTable reloadData];

        //2 先删除本地提醒通知
        //3 向后台删除提醒通知
        //4 删除数组中的model
    }
}
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
        _topImgView.image = [UIImage imageNamed:@"形状3.png"];
    }
    return _topImgView;
}

- (UIImageView *)bottomImgView
{
    if (!_bottomImgView) {
        
        _bottomImgView = [UIImageView new];
        _bottomImgView.image = [UIImage imageNamed:@"扎心了.png"];
    }
    return _bottomImgView;
}
- (UIImageView *)middlImgView
{
    if (!_middlImgView) {
        
        _middlImgView = [UIImageView new];
        _middlImgView.image = [UIImage imageNamed:@"老铁设置闹钟.png"];
    }
    return _middlImgView;
}
- (UIImageView *)leftBImgView
{
    if (!_leftBImgView) {
        
        _leftBImgView = [UIImageView new];
        _leftBImgView.image = [UIImage imageNamed:@"点这里.png"];
    }
    return _leftBImgView;
}
- (UIImageView *)rightBImgView
{
    if (!_rightBImgView) {
        
        _rightBImgView = [UIImageView new];
        _rightBImgView.image = [UIImage imageNamed:@"黄色小人.png"];
    }
    return _rightBImgView;
}
- (UIImageView *)jchuluBImg
{
    if (!_jchuluBImg) {
        
        _jchuluBImg = [UIImageView new];
        _jchuluBImg.image = [UIImage imageNamed:@"扎心了.png"];
    }
    return _jchuluBImg;
}
- (UIImageView *)huluImg
{
    if (!_huluImg) {
        
        _huluImg = [UIImageView new];
        _huluImg.image = [UIImage imageNamed:@"葫芦娃.png"];
    }
    return _huluImg;
}
- (UIButton *)addBtn
{
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"添加闹钟.png"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(jcRightBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
- (UILabel *)dateLab
{
    if (!_dateLab) {
        
        _dateLab = [UILabel new];
        //_dateLab.backgroundColor = [UIColor purpleColor];
        _dateLab.font = [UIFont systemFontOfSize:14];
        _dateLab.textColor = [UIColor blackColor];
        _dateLab.text = @"01/25";

        
    }
    return _dateLab;
}
- (UILabel *)timeLab
{
    if (!_timeLab) {
        
        _timeLab = [UILabel new];
        //_timeLab.backgroundColor = [UIColor blueColor];
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.font = [UIFont systemFontOfSize:55];
        _timeLab.textColor = [UIColor redColor];
        _timeLab.text = @"08:33";

    }
    return _timeLab;
    
}
- (UILabel *)weekLab
{
    if (!_weekLab)
    {
        _weekLab = [UILabel new];
       // _weekLab.backgroundColor = [UIColor greenColor];
        _weekLab.font = [UIFont systemFontOfSize:14];
        _weekLab.textColor = [UIColor blackColor];
        _weekLab.text = @"周五";
    }
    return _weekLab;
}
- (UILabel *)temperatureLab
{
    if (!_temperatureLab) {
        
        _temperatureLab = [UILabel new];
       // _temperatureLab.backgroundColor = [UIColor redColor];
        _temperatureLab.font = [UIFont systemFontOfSize:14];
        _temperatureLab.textColor = [UIColor blackColor];
        _temperatureLab.text = @"-13C";
        
    }
    return _temperatureLab;
}
- (UITableView *)remindTable
{
    if (!_remindTable) {
        
        _remindTable = [[UITableView alloc]initWithFrame:CGRectMake(30, 566/2.0, KScreenWidth-60, KScreenHeight-566/2.0-JC_TabbarSafeBottomMargin-335/2.0) style:UITableViewStyleGrouped];
        _remindTable.delegate = self;
        _remindTable.dataSource = self;
        //IOS11适配
        _remindTable.estimatedRowHeight = 0;
        _remindTable.estimatedSectionHeaderHeight = 0;
        _remindTable.estimatedSectionFooterHeight = 0;
        //隐藏垂直滚动条
        _remindTable.showsVerticalScrollIndicator = NO;
        _remindTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _remindTable.backgroundColor = [UIColor whiteColor];
    }
    return _remindTable;
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


@end
