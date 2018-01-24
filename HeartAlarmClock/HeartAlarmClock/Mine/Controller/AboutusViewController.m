//  AboutusViewController.m
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
//  @class AboutusViewController
//  @abstract 关于我们
//  @discussion <#类的功能#>
//

#import "AboutusViewController.h"

@interface AboutusViewController ()
@property(nonatomic,strong)UIImageView *iconImg;
@property(nonatomic,strong)UILabel *versionLab;
@property(nonatomic,strong)UIImageView *tipImg;
@property(nonatomic,strong)UITextView  *jcTextV;
@end

@implementation AboutusViewController


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
    [self.view addSubview:self.iconImg];
    [self.view addSubview:self.versionLab];
    [self.view addSubview:self.tipImg];
    [self.view addSubview:self.jcTextV];
    CGFloat jcTopSpaceY = 146/2;
    if (isIphone_5) {
        jcTopSpaceY = 60/2;
    }
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(90);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(JCNavBarHeight+jcTopSpaceY);
    }];
    [self.versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth);
        make.height.mas_equalTo(16);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.iconImg.mas_bottom).offset(15);
    }];
    
    [self.tipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(250/2.0);
        make.height.mas_equalTo(220/2.0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.versionLab.mas_bottom).offset(15);
    }];
    
    [self.jcTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-40);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.tipImg.mas_bottom).offset(40/2);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-JC_TabbarSafeBottomMargin);
    }];

}

- (void)layoutNavigationBar
{
    self.navigationBarSelf.title = @"扎心闹钟";
}
#pragma mark - UITableViewDelegate

#pragma mark - Public

#pragma mark - Private

#pragma mark - Getter
- (UIImageView *)iconImg
{
    if (!_iconImg) {
        
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"蓝色小人.png"];
    }
    return _iconImg;
}
- (UILabel *)versionLab
{
    if (!_versionLab) {
        
        _versionLab = [UILabel new];
        _versionLab.font = [UIFont systemFontOfSize:16];
        _versionLab.textColor = [ToolsHelper colorWithHexString:@"#000000"];
        _versionLab.text = [NSString stringWithFormat:@"版本号V%@",[ToolsHelper getAppVersion]];
        _versionLab.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLab;
}
- (UIImageView *)tipImg
{
    if (!_tipImg) {
        
        _tipImg = [UIImageView new];
        _tipImg.image = [UIImage imageNamed:@"关于我们.png"];
    }
    return _tipImg;
}
- (UITextView *)jcTextV
{
    if (!_jcTextV) {
        
        _jcTextV = [[UITextView alloc]init];
        _jcTextV.textColor = [ToolsHelper colorWithHexString:@"#000000"];
        _jcTextV.font = [UIFont systemFontOfSize:16];
        _jcTextV.text = @"hey！天将降大任于斯人、必先叫他起床！dei，我就是来叫你起床的！好吧，也是叫我起床…作为常年起床困难户，决定自己动手丰衣足食，于是就有了这个扎心闹钟。为了做闹钟里的蒂花之秀，我准备了许多神奇的魔音让大家一起摆脱频困！关机、结束进程和静音都不会响啊！你可憋又不想起床给我关了啊！好了，你要迟到了！";
        _jcTextV.editable = NO;
      
        
    }
    return _jcTextV;
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
