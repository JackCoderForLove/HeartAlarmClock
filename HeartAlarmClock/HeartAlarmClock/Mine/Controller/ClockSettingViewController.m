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
#import "EvaluateRemindModel.h"

@interface ClockSettingViewController ()<JCTimePickerViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView *huluImg;//最上边葫芦娃的img
@property(nonatomic,strong)JCTimePickerView  *timePicker;//时间选择器
@property(nonatomic,strong)JCRepeatSelectView *repeatView;//时间重复选择
@property(nonatomic,strong)JCBellSelctView    *bellView;//铃声选择View
@property(nonatomic,strong)JCTipSelectView    *tipView;//闹钟标签View
@property(nonatomic,strong)JCVibrationSelectView *vibrationView;//震动选择View
@property(nonatomic,strong)NSString  *bellName;
@property(nonatomic,strong)UIScrollView *jcBgScrollView;
@property(nonatomic,strong)UILabel *vibrationLab;
@property(nonatomic,strong)UISwitch *vibrantionSwtich;
@property(nonatomic,strong)UILabel *tipLab;
@property(nonatomic,strong)UITextField *tipTF;
@property(nonatomic,strong)UILabel *bellLab;
@property(nonatomic,strong)UILabel *bellValueLab;
@property(nonatomic,strong)UILabel *repeatLab;
@property(nonatomic,strong)NSMutableArray *repeatDateArr;
@property(nonatomic,strong)NSMutableArray *repeatOptionArr;
@property(nonatomic,strong)NSArray *repeatDateTitleArr;
@property(nonatomic,strong)NSArray *repeatOptionTitleArr;
@property(nonatomic,strong)UIButton *saveBtn;
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
    [self jcRegisterApns];
    if (self.remindModel == nil) {
        
        //默认显示当前时间
        NSString *nowTime = [ToolsHelper jcGetTimeStrWithDate:[ToolsHelper jcGetCurrentDate] withFormatter:@"HH:mm"];
//        NSLog(@"现在的时间:%@",nowTime);
//        self.jcDateStr = nowTime;
        self.timePicker.jcDateStr = nowTime;
        
    }
    else
    {
        self.timePicker.jcDateStr = self.remindModel.remindTime;
    }
    
    
}

- (void)jcLayoutMyUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.repeatDateArr = [NSMutableArray array];
    self.repeatOptionArr = [NSMutableArray array];
    self.repeatDateTitleArr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    self.repeatOptionTitleArr = @[@"永不",@"工作日",@"每天",@"周末"];
    [self.view addSubview:self.huluImg];
    [self.view addSubview:self.jcBgScrollView];
    [self.jcBgScrollView addSubview:self.timePicker];
    [self.jcBgScrollView addSubview:self.repeatView];
    [self.jcBgScrollView addSubview:self.bellView];
    [self.jcBgScrollView addSubview:self.tipView];
    [self.jcBgScrollView addSubview:self.vibrationView];
    [self.huluImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(495/2.0);
        make.height.mas_equalTo(76/2.0);
        make.top.mas_equalTo(self.view.mas_top).offset(JCNavBarHeight+20/2.0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    if (self.remindModel)
    {
        self.bellName = self.remindModel.soundName;
        
    }
    [self.repeatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-30);
        make.height.mas_equalTo(310/2);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.timePicker.mas_bottom).offset(10);
    }];
    [self.repeatView addSubview:self.repeatLab];
    [self.repeatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(self.repeatView.mas_left).offset(25);
        make.top.mas_equalTo(self.repeatView.mas_top).offset(15);
    }];
    CGFloat kItemW = 40;
    CGFloat kSpace = (KScreenWidth-30-kItemW*7)/8.0;
    for (int i = 0; i<7; i++)
    {
        UIButton *jcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [self.repeatDateTitleArr objectAtIndex:i];
        [jcBtn setTitle:title forState:UIControlStateNormal];
        [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
        [jcBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        jcBtn.layer.masksToBounds = YES;
        jcBtn.layer.cornerRadius = kItemW/2.0;
        jcBtn.tag = 8000+i;
        [self.repeatView addSubview:jcBtn];
        [jcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(kItemW);
            make.left.mas_equalTo(self.repeatView.mas_left).offset(kSpace+(kSpace+kItemW)*i);
            make.top.mas_equalTo(self.repeatLab.mas_bottom).offset(15);
        }];
        [jcBtn addTarget:self action:@selector(jcDateClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.repeatDateArr addObject:jcBtn];
    }
    CGFloat kOItemW = 65;
    CGFloat kOItemH = 30;
    CGFloat kOSpace = (KScreenWidth-65*4-30)/5.0;
    for (int i = 0; i<4; i++)
    {
        UIButton *jcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [self.repeatOptionTitleArr objectAtIndex:i];
        [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
        [jcBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        jcBtn.layer.masksToBounds = YES;
        jcBtn.layer.cornerRadius = kOItemH/2.0;
        jcBtn.tag = 9000+i;
        [jcBtn setTitle:title forState:UIControlStateNormal];
        [self.repeatView addSubview:jcBtn];
        [jcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kOItemW);
            make.height.mas_equalTo(kOItemH);
            make.left.mas_equalTo(self.repeatView.mas_left).offset(kOSpace+(kOSpace+kOItemW)*i);
            make.bottom.mas_equalTo(self.repeatView.mas_bottom).offset(-15);
        }];
        [jcBtn addTarget:self action:@selector(jcOptionClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.repeatOptionArr addObject:jcBtn];

        
    }
    [self.bellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-30);
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.repeatView.mas_bottom).offset(10);

    }];
    [self.bellView addSubview:self.bellLab];
    [self.bellView addSubview:self.bellValueLab];
    [self.bellLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.bellView.mas_centerY);
        make.left.mas_equalTo(self.bellView.mas_left).offset(25);
    }];
    [self.bellValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-60-50-10);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(self.bellView.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.bellView.mas_centerY);
    }];
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-30);
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.bellView.mas_bottom).offset(10);

    }];
    [self.tipView addSubview:self.tipLab];
    [self.tipView addSubview:self.tipTF];
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.tipView.mas_centerY);
        make.left.mas_equalTo(self.tipView.mas_left).offset(25);
    }];
    [self.tipTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.tipView.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.tipView.mas_centerY);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(200);
    }];
    [self.vibrationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-30);
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.tipView.mas_bottom).offset(10);

    }];
    [self.vibrationView addSubview:self.vibrationLab];
    [self.vibrationView addSubview:self.vibrantionSwtich];
    [self.vibrationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.vibrationView.mas_centerY);
        make.left.mas_equalTo(self.vibrationView.mas_left).offset(25);
    }];
    [self.vibrantionSwtich mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self.vibrationView.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.vibrationView.mas_centerY);
    }];
    
    
}
//点击选择日期
- (void)jcDateClick:(UIButton *)sender
{
    NSLog(@"点击了日期");
  
    for (int i = 0; i<self.repeatDateArr.count; i++) {
        UIButton *jcBtn = [self.repeatDateArr objectAtIndex:i];
        if (jcBtn.tag == sender.tag) {
            
            //将按钮置为选中状态
            if (jcBtn.isSelected == YES) {
                [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
                jcBtn.selected = NO;
            }
            else
            {
                [jcBtn setBackgroundColor:[UIColor redColor]];
                jcBtn.selected = YES;
            }
            
        }
        
    }
    for (int i = 0; i<self.repeatOptionArr.count; i++) {
        UIButton *jcBtn = [self.repeatOptionArr objectAtIndex:i];
        jcBtn.selected = NO;
        [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
        
    }
    BOOL first;
    BOOL second;
    BOOL third;
    BOOL fourth;
    BOOL fifth;
    BOOL sixth;
    BOOL seventh;
    UIButton *firstBtn = [self.repeatDateArr objectAtIndex:0];
    UIButton *secondBtn = [self.repeatDateArr objectAtIndex:1];
    UIButton *thirdtn = [self.repeatDateArr objectAtIndex:2];
    UIButton *fourthBtn = [self.repeatDateArr objectAtIndex:3];
    UIButton *fifthBtn = [self.repeatDateArr objectAtIndex:4];
    UIButton *sixBtn = [self.repeatDateArr objectAtIndex:5];
    UIButton *seventhBtn = [self.repeatDateArr objectAtIndex:6];
    first = firstBtn.isSelected;
    second = secondBtn.isSelected;
    third = thirdtn.isSelected;
    fourth = fourthBtn.isSelected;
    fifth = fifthBtn.isSelected;
    sixth = sixBtn.isSelected;
    seventh = seventhBtn.isSelected;
    //判断
    if (first==YES&&second==YES&&third==YES&&fourth==YES&&fifth==YES&&sixth == YES&&seventh==YES) {
        
        for (int i = 0; i<self.repeatOptionArr.count; i++) {
            UIButton *jcBtn = [self.repeatOptionArr objectAtIndex:i];
            if (i == 2) {
                jcBtn.selected = YES;
                [jcBtn setBackgroundColor:[UIColor redColor]];
            }
            else
            {
                jcBtn.selected = NO;
                [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
                
            }
        }
    }
    if (first==YES&&second==YES&&third==YES&&fourth==YES&&fifth==YES&&sixth == NO&&seventh==NO) {
        for (int i = 0; i<self.repeatOptionArr.count; i++)
        {
              
        UIButton *jcBtn = [self.repeatOptionArr objectAtIndex:i];
        if (i == 1) {
            jcBtn.selected = YES;
            [jcBtn setBackgroundColor:[UIColor redColor]];
        }
        else
        {
            jcBtn.selected = NO;
            [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
            
        }
      }
        
    }
    if (first==NO&&second==NO&&third==NO&&fourth==NO&&fifth==NO&&sixth == YES &&seventh==YES) {
        for (int i = 0; i<self.repeatOptionArr.count; i++)
        {
            
            UIButton *jcBtn = [self.repeatOptionArr objectAtIndex:i];
            if (i == 3) {
                jcBtn.selected = YES;
                [jcBtn setBackgroundColor:[UIColor redColor]];
            }
            else
            {
                jcBtn.selected = NO;
                [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
                
            }
        }
        
    }
    if (first==NO&&second==NO&&third==NO&&fourth==NO&&fifth==NO&&sixth == NO &&seventh==NO) {
        for (int i = 0; i<self.repeatOptionArr.count; i++)
        {
            
            UIButton *jcBtn = [self.repeatOptionArr objectAtIndex:i];
          
                jcBtn.selected = NO;
                [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
                
        }
        
    }
    
    
    
    
}
//点击选项
- (void)jcOptionClick:(UIButton *)sender
{
    NSLog(@"点击了选项");
    //先设置点击选中按钮
    for (int i = 0; i<self.repeatOptionArr.count; i++) {
        UIButton *jcBtn = [self.repeatOptionArr objectAtIndex:i];
        if (jcBtn.tag == sender.tag) {
            jcBtn.selected = YES;
            jcBtn.backgroundColor = [UIColor redColor];
        }
        else
        {
            jcBtn.selected = NO;
            jcBtn.backgroundColor = [ToolsHelper colorWithHexString:@"#5d5d5d"];
        }
    }
    if (sender.tag == 9000)
    {
       
        //点击永不
        for (int i = 0; i<self.repeatDateArr.count; i++) {
            UIButton *jcBtn = [self.repeatDateArr objectAtIndex:i];
            jcBtn.selected = NO;
            [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
        }
        
    }
    else if (sender.tag == 9001)
    {
        //点击工作日
        for (int i = 0; i<self.repeatDateArr.count; i++) {
            UIButton *jcBtn = [self.repeatDateArr objectAtIndex:i];
            if (i<5)
            {
                jcBtn.selected = YES;
                [jcBtn setBackgroundColor:[UIColor redColor]];
                
                
            }
            else
            {
                jcBtn.selected = NO;
                [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
                
            }
        }

    }
    else if (sender.tag == 9002)
    {
        //点击每天
        for (int i = 0; i<self.repeatDateArr.count; i++) {
            UIButton *jcBtn = [self.repeatDateArr objectAtIndex:i];
            jcBtn.selected = YES;
            [jcBtn setBackgroundColor:[UIColor redColor]];
        }
        
    }
    else if (sender.tag == 9003)
    {
        //点击周末
        for (int i = 0; i<self.repeatDateArr.count; i++) {
            UIButton *jcBtn = [self.repeatDateArr objectAtIndex:i];
            if (i<5)
            {
                jcBtn.selected = NO;
                [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:@"#5d5d5d"]];
                
            }
            else
            {
                jcBtn.selected = YES;
                [jcBtn setBackgroundColor:[UIColor redColor]];
            }
        }
    }
    
}

//注册通知
- (void)jcRegisterApns
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jcReceiveBellNotifi:) name:@"jcreceivebellname" object:nil];
}
- (void)jcReceiveBellNotifi:(NSNotification *)noti
{
    NSLog(@"选择:%@ 铃声",noti.object);
    self.bellName = noti.object;
    self.bellValueLab.text = self.bellName;
    
}
- (void)layoutNavigationBar
{
    self.navigationBarSelf.title = @"闹钟设置";
    self.navigationBarSelf.rightView = self.saveBtn;
}
#pragma mark - JCTimePickerViewDelegate
- (void)jcDatePickerSelect:(JCTimePickerView *)jcPickerView withTimeStr:(NSString *)timeStr
{
    
}
//点击铃声条目
- (void)jcJumpToBellVC:(UITapGestureRecognizer *)jcTap
{
    
    //跳转到铃声设置页面
    BellSettingViewController *bellVC = [BellSettingViewController new];
    [self.navigationController pushViewController:bellVC animated:YES];

    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
        _timePicker = [[JCTimePickerView alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth-30, 370/2)];
        _timePicker.delegate = self;
        _timePicker.backgroundColor = [ToolsHelper colorWithHexString:@"#2e2e30"];
        _timePicker.layer.cornerRadius = 30;
        _timePicker.layer.masksToBounds = YES;
        
    }
    return _timePicker;
}
- (JCRepeatSelectView *)repeatView
{
    if (!_repeatView) {
        
        _repeatView = [JCRepeatSelectView new];
        _repeatView.layer.masksToBounds = YES;
        _repeatView.layer.cornerRadius = 30;
        _repeatView.backgroundColor = [ToolsHelper colorWithHexString:@"#2e2e30"];
    }
    return _repeatView;
}
- (UILabel *)repeatLab
{
    if (!_repeatLab) {
        
        _repeatLab = [UILabel new];
        _repeatLab.font = [UIFont systemFontOfSize:16];
        _repeatLab.textColor = [UIColor whiteColor];
        _repeatLab.text = @"重复";
        
    }
    return _repeatLab;
}
- (JCBellSelctView *)bellView
{
    if (!_bellView) {
        
        _bellView = [JCBellSelctView new];
        _bellView.layer.masksToBounds = YES;
        _bellView.layer.cornerRadius = 30;
        _bellView.backgroundColor = [ToolsHelper colorWithHexString:@"#2e2e30"];
        _bellView.userInteractionEnabled = YES;
        UITapGestureRecognizer *jcTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jcJumpToBellVC:)];
        [_bellView addGestureRecognizer:jcTap];
        
    }
    return _bellView;
}
- (UILabel *)bellLab
{
    if (!_bellLab) {
        
        _bellLab = [UILabel new];
        _bellLab.font = [UIFont systemFontOfSize:16];
        _bellLab.text = @"铃声";
        _bellLab.textColor = [UIColor whiteColor];
    }
    return _bellLab;
}
- (UILabel *)bellValueLab
{
    if (!_bellValueLab) {
        
        _bellValueLab = [UILabel new];
        _bellValueLab.font = [UIFont systemFontOfSize:16];
        _bellValueLab.text = @"动物园";
        _bellValueLab.textAlignment = NSTextAlignmentRight;
        _bellValueLab.textColor = [UIColor whiteColor];
    }
    return _bellValueLab;
}
- (JCTipSelectView *)tipView
{
    if (!_tipView) {
        
        _tipView = [JCTipSelectView new];
        _tipView.layer.masksToBounds = YES;
        _tipView.layer.cornerRadius = 30;
        _tipView.backgroundColor = [ToolsHelper colorWithHexString:@"#2e2e30"];

    }
    return _tipView;
}
- (JCVibrationSelectView *)vibrationView
{
    if (!_vibrationView) {
        
        _vibrationView = [JCVibrationSelectView new];
        _vibrationView.layer.masksToBounds = YES;
        _vibrationView.layer.cornerRadius = 30;
        _vibrationView.backgroundColor = [ToolsHelper colorWithHexString:@"#2e2e30"];

        
    }
    return _vibrationView;
}
- (UILabel *)vibrationLab
{
    if (!_vibrationLab) {
        
        _vibrationLab = [UILabel new];
        _vibrationLab.text = @"震动";
        _vibrationLab.textColor = [UIColor whiteColor];
        
    }
    return _vibrationLab;
}
- (UISwitch *)vibrantionSwtich
{
    if (!_vibrantionSwtich) {
        
        _vibrantionSwtich = [UISwitch new];
        
    }
    return _vibrantionSwtich;
}
- (UILabel *)tipLab
{
    if (!_tipLab) {
        
        _tipLab = [UILabel new];
        _tipLab.font = [UIFont systemFontOfSize:16];
        _tipLab.text = @"标签";
        _tipLab.textColor = [UIColor whiteColor];
    }
    return _tipLab;
}
- (UITextField *)tipTF
{
    if (!_tipTF) {
        
        _tipTF = [UITextField new];
        _tipTF.text = @"闹钟";
        _tipTF.textColor = [UIColor whiteColor];
        _tipTF.textAlignment = NSTextAlignmentRight; 
    }
    return _tipTF;
}
- (UIScrollView *)jcBgScrollView
{
    if (!_jcBgScrollView) {
        
        _jcBgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, JCNavBarHeight+20/2+76/2, KScreenWidth, kScreenHeight-JCNavBarHeight-20/2-76/2)];
        _jcBgScrollView.contentSize = CGSizeMake(KScreenWidth, 1200/2.0);
        _jcBgScrollView.showsVerticalScrollIndicator = NO;
        _jcBgScrollView.delegate = self;
    }
    return _jcBgScrollView;
}
- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(jcSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setTitleColor:[ToolsHelper colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _saveBtn.titleFont = [UIFont systemFontOfSize:15];
    }
    return _saveBtn;
}

- (void)jcSaveBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
