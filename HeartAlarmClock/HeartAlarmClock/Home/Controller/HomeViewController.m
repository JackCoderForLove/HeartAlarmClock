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
//  @abstract <#类的描述#>
//  @discussion <#类的功能#>
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
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
    self.view.backgroundColor = [UIColor greenColor];
}
- (void)layoutNavigationBar
{
    self.navigationBarSelf.leftView = self.leftBtn;
    self.navigationBarSelf.rightView = self.rightBtn;
}
//点击主页
- (void)jcLeftBtnOnClick:(UIButton *)sender
{
    NSLog(@"点击主页");
}

//点击添加
- (void)jcRightBtnOnClick:(UIButton *)sender
{
    NSLog(@"点击添加");
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
