//  ClockSettingViewController.m
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
//  @class ClockSettingViewController
//  @abstract 闹钟设置
//  @discussion <#类的功能#>
//

#import "ClockSettingViewController.h"
#import "JCTimePickerView.h"
#import "JCTipSelectView.h"
#import "JCRepeatSelectView.h"
#import "JCBellSelctView.h"
#import "JCVibrationSelectView.h"
#import "BellSettingViewController.h"

@interface ClockSettingViewController ()
@property(nonatomic,strong)UIImageView *huluImg;//最上边葫芦娃的img
@property(nonatomic,strong)JCTimePickerView  *timePicker;//时间选择器
@property(nonatomic,strong)JCRepeatSelectView *repeatView;//时间重复选择
@property(nonatomic,strong)JCBellSelctView    *bellView;//铃声选择View
@property(nonatomic,strong)JCTipSelectView    *tipView;//闹钟标签View
@property(nonatomic,strong)JCVibrationSelectView *vibrationView;//震动选择View
@end

@implementation ClockSettingViewController


#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self jcLayoutMyUI];
}

- (void)jcLayoutMyUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.huluImg];
    [self.view addSubview:self.timePicker];
    [self.view addSubview:self.repeatView];
    [self.view addSubview:self.bellView];
    [self.view addSubview:self.tipView];
    [self.view addSubview:self.vibrationView];
    [self.huluImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(495/2.0);
        make.height.mas_equalTo(76/2.0);
        make.top.mas_equalTo(self.view.mas_top).offset(JCNavBarHeight+20/2.0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BellSettingViewController *bellVC = [BellSettingViewController new];
        [self.navigationController pushViewController:bellVC animated:YES];
    });
    
}

- (void)layoutNavigationBar
{
    self.navigationBarSelf.title = @"闹钟设置";
}
#pragma mark - UITableViewDelegate

#pragma mark - Public

#pragma mark - Private

#pragma mark - Getter
- (UIImageView *)huluImg
{
    if (!_huluImg) {
        
        _huluImg = [UIImageView new];
        _huluImg.image = [UIImage imageNamed:@"葫芦娃.png"];
    }
    return _huluImg;
}
- (JCTimePickerView *)timePicker
{
    if (!_timePicker)
    {
        _timePicker = [JCTimePickerView new];
        
    }
    return _timePicker;
}
- (JCRepeatSelectView *)repeatView
{
    if (!_repeatView) {
        
        _repeatView = [JCRepeatSelectView new];
        _repeatView.layer.masksToBounds = YES;
        _repeatView.layer.cornerRadius = 20;
    }
    return _repeatView;
}
- (JCBellSelctView *)bellView
{
    if (!_bellView) {
        
        _bellView = [JCBellSelctView new];
        _bellView.layer.masksToBounds = YES;
        _bellView.layer.cornerRadius = 20;
    }
    return _bellView;
}
- (JCTipSelectView *)tipView
{
    if (!_tipView) {
        
        _tipView = [JCTipSelectView new];
        _tipView.layer.masksToBounds = YES;
        _tipView.layer.cornerRadius = 20;
    }
    return _tipView;
}
- (JCVibrationSelectView *)vibrationView
{
    if (!_vibrationView) {
        
        _vibrationView = [JCVibrationSelectView new];
        _vibrationView.layer.masksToBounds = YES;
        _vibrationView.layer.cornerRadius = 20;
        
    }
    return _vibrationView;
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
