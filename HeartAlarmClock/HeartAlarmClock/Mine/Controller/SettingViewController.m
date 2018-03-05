//  SettingViewController.m
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
//  @class SettingViewController
//  @abstract 设置
//  @discussion <#类的功能#>
//

#import "SettingViewController.h"
#import "AboutusViewController.h"
#import "WallpaperViewController.h"
#import "JCShareView.h"

@interface SettingViewController ()<ShareDelegate>
@property(nonatomic,strong)UIImageView *topImgView;
@property(nonatomic,strong)UIImageView *bottomImgView;
@property(nonatomic,strong)NSMutableArray *jcBtnTitleArr;
@property(nonatomic,strong)NSMutableArray *jcBtnColorArr;
@property(nonatomic,strong)JCShareView    *shareView;//分享视图
@end

@implementation SettingViewController


#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.jcBtnTitleArr = [NSMutableArray arrayWithObjects:@"壁纸",@"分享",@"关于\n我们", nil];
    self.jcBtnColorArr = [NSMutableArray arrayWithObjects:@"0xfb635e",@"0xb9e051",@"0x72746c", nil];
    [self jcLayoutMyUI];
}

- (void)jcLayoutMyUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topImgView];
    CGFloat topW = 608/2.0;
    CGFloat topH = 554/2.0;
    if (isIphone_5)
    {
        topW = 608/2.0*0.8;
        topH = 554/2.0*0.8;
    }
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(topW);
        make.height.mas_equalTo(topH);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(JCNavBarHeight+80/2);
    }];
    CGFloat jcBtnW = 126/2.0;
    CGFloat jcBtnY = 130/2.0;
    if (isIphone_5) {
        jcBtnY = 80/2.0;
    }
    CGFloat jcBtnX = (KScreenWidth-126/2.0*3-70)/2.0;
    for (int i = 0; i<self.jcBtnTitleArr.count; i++) {
        CGFloat jcLLX = jcBtnX+(jcBtnW+35)*i;
        UIButton *jcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [self.jcBtnTitleArr objectAtIndex:i];
        NSString *color = [self.jcBtnColorArr objectAtIndex:i];
        [jcBtn setTitle:title forState:UIControlStateNormal];
        [jcBtn setBackgroundColor:[ToolsHelper colorWithHexString:color]];
        [jcBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (i == 2)
        {
            jcBtn.titleLabel.numberOfLines = 2;
            jcBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        }
        jcBtn.tag = 1000+i;
        [jcBtn addTarget:self action:@selector(jcBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        jcBtn.layer.masksToBounds = YES;
        jcBtn.layer.cornerRadius = 126/2.0/2.0;
        [self.view addSubview:jcBtn];
        [jcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(jcBtnW);
            make.left.mas_equalTo(self.view.mas_left).offset(jcLLX);
            make.top.mas_equalTo(self.topImgView.mas_bottom).offset(jcBtnY);
        }];
        if (i<2) {
            jcBtn.hidden = YES;
        }
        
    }
    [self.view addSubview:self.bottomImgView];
    [self.bottomImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(454/2.0);
        make.height.mas_equalTo(233/2.0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-JC_TabbarSafeBottomMargin);
    }];
    
}


- (void)layoutNavigationBar
{
    self.navigationBarSelf.title = @"扎心闹钟";
}

- (void)jcBtnOnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
        {
            //点击了壁纸
            WallpaperViewController *wallVC = [WallpaperViewController new];
            [self.navigationController pushViewController:wallVC animated:YES];
            break;
        }
        case 1001:
        {
            //点击了分享
            NSLog(@"去分享吧");
            [self.shareView show];
            break;
        }
        case 1002:
        {
            //点击了关于我们
            AboutusViewController *aboutVC = [AboutusViewController new];
            [self.navigationController pushViewController:aboutVC animated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark -
#pragma mark ShareDelegate
- (void)shareWithType:(NSString *)type
{
    switch (type.integerValue) {
        case 0://微信好友
        {
            NSLog(@"点击了微信好友");
            break;
        }
        case 1://朋友圈
        {
            NSLog(@"点击了微信朋友圈");
            break;
        }
        case 2://复制链接
        {
            NSLog(@"点击了复制链接");
            break;
        }

        default:
            break;
    }
}
#pragma mark - UITableViewDelegate

#pragma mark - Public

#pragma mark - Private

#pragma mark - Getter
- (UIImageView *)topImgView
{
    if (!_topImgView) {
        
        _topImgView = [UIImageView new];
        _topImgView.image = [UIImage imageNamed:@"老子今天没睡觉.png"];
    }
    return _topImgView;
}
- (UIImageView *)bottomImgView
{
    if (!_bottomImgView) {
        
        _bottomImgView = [UIImageView new];
        _bottomImgView.image = [UIImage imageNamed:@"扎心.png"];
    }
    return _bottomImgView;
}
-(JCShareView *)shareView
{
    if (!_shareView) {
        _shareView = [[JCShareView alloc] init];
        _shareView.delegate = self;
        _shareView.jcType = 0;
        
    }
    return _shareView;
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
