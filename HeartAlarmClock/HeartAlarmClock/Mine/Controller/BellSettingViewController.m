//  BellSettingViewController.m
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
//  @class BellSettingViewController
//  @abstract 铃声设置
//  @discussion <#类的功能#>
//

#import "BellSettingViewController.h"
#import "JCBellTableViewCell.h"
#import "JCBellHeaderView.h"
#import <AudioToolbox/AudioToolbox.h>


@interface BellSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     SystemSoundID _currentID;
     NSIndexPath  *selectIndexPath;
    
}
@property(nonatomic,strong)UITableView *jcBellTable;
@property(nonatomic,strong)NSArray *musicTypeArr;//音乐类型List
@property(nonatomic,strong)NSDictionary *jcMusicDic;//音乐字典
@property(nonatomic,strong)UIImageView *huluImg;//最上边葫芦娃的img
@property(nonatomic,strong)NSString *soundName;

@end

@implementation BellSettingViewController


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
    [self.huluImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(495/2.0);
        make.height.mas_equalTo(76/2.0);
        make.top.mas_equalTo(self.view.mas_top).offset(JCNavBarHeight+20/2.0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.view addSubview:self.jcBellTable];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"plist"];
    NSDictionary *jcDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"读取plist文件%@",jcDic);
    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"musickey" ofType:@"plist"];
    NSArray *jcArr = [NSArray arrayWithContentsOfFile:filePath1];
    NSLog(@"key=%@",jcArr);
    self.jcMusicDic = jcDic;
    self.musicTypeArr = jcArr;
    [self.jcBellTable reloadData];
    
}

- (void)layoutNavigationBar
{
    self.navigationBarSelf.title = @"铃声设置";
}
- (void)backToPrevious
{
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.musicTypeArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.musicTypeArr objectAtIndex:section];
    NSArray  *musicArr = [self.jcMusicDic objectForKey:key];
    return musicArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *jcBellID = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
    JCBellTableViewCell *jcBellCell = [[JCBellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jcBellID];
    jcBellCell.selectionStyle = UITableViewCellSelectionStyleNone;
    jcBellCell.backgroundColor = [UIColor clearColor];
    jcBellCell.tintColor = [UIColor greenColor];
    NSString *key = [self.musicTypeArr objectAtIndex:indexPath.section];
    NSArray  *musicArr = [self.jcMusicDic objectForKey:key];
    NSString *title = [musicArr objectAtIndex:indexPath.row];
    jcBellCell.title = title;
    
    return jcBellCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JCBellHeaderView *headerView = [JCBellHeaderView new];
    NSString *title = [self.musicTypeArr objectAtIndex:section];
    headerView.title = title;
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.musicTypeArr objectAtIndex:indexPath.section];
    NSArray  *musicArr = [self.jcMusicDic objectForKey:key];
    NSString *title = [musicArr objectAtIndex:indexPath.row];
    NSLog(@"点击了哪个标题:%@",title);
    NSString *musicName = [NSString stringWithFormat:@"%@.wav",title];
    [tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.accessoryType = UITableViewCellAccessoryNone;
    }];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self playWithName:musicName];
//    SystemSoundID soundId;
//    NSString *path = [[NSBundle mainBundle] pathForResource:title ofType:@"wav"];
//    if (path) {
//        //注册声音到系统
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&soundId);
//        AudioServicesPlaySystemSound(soundId);
//    }
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"jcreceivebellname" object:title];
//    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)playWithName:(NSString *)name {
    //关闭上次
    AudioServicesDisposeSystemSoundID(_currentID);
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    
    NSURL *url = [[NSBundle mainBundle] URLForAuxiliaryExecutable:name];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    //    NSLog(@"ID = %U",soundID);
    AudioServicesPlaySystemSound(soundID);
    _currentID = soundID;
    
    //震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

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
- (UITableView *)jcBellTable
{
    if (!_jcBellTable) {
        
        _jcBellTable = [[UITableView alloc]initWithFrame:CGRectMake(30, JCNavBarHeight+76/2+20/2, KScreenWidth-60, KScreenHeight-JCNavBarHeight-JC_TabbarSafeBottomMargin-76/2-20/2) style:UITableViewStyleGrouped];
        _jcBellTable.delegate = self;
        _jcBellTable.dataSource = self;
        //IOS11适配
        _jcBellTable.estimatedRowHeight = 0;
        _jcBellTable.estimatedSectionHeaderHeight = 0;
        _jcBellTable.estimatedSectionFooterHeight = 0;
        //隐藏垂直滚动条
        _jcBellTable.showsVerticalScrollIndicator = NO;
        _jcBellTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _jcBellTable.backgroundColor = [ToolsHelper colorWithHexString:@"#2e2e30"];
        _jcBellTable.layer.masksToBounds = YES;
        _jcBellTable.layer.cornerRadius = 20;
    }
    return _jcBellTable;
}

#pragma mark - Setter

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AudioServicesDisposeSystemSoundID(_currentID);
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    
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
