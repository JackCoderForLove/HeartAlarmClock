//
//  BaseViewController.m
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabbarController.h"
#import "MBProgressHUD+Extension.h"
//#import "GifLoadingView.h"
#import "AppScene.h"


#define LoadingImage  @"loading.gif"

@interface BaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavigationBar];
    self.navigationBarSelf.backgroundColor = [UIColor blueColor];
    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));

    if (self.navigationController.viewControllers.count > 1) {
//        [self leftTitle:@"返回" target:self action:@selector(backToPrevious)];
        [self leftImage:@"public_btn_black_back" target:self action:@selector(backToPrevious)];
    }
    [self layoutNavigationBar];
    
    [self refreshViewsForNewScene];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshViewsForNewScene) name:kNotifycation_ChangeScene object:nil];
    [self addNoticeForKeyboard];

}




#pragma mark - 键盘通知
- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = 0.0;
    if (self.assistantHeight > 0) {
        offset = self.assistantHeight - (self.view.frame.size.height - kbHeight);
    }
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //针对iOS11转场动画导致的view偏移进行修复
    if ([self.navigationBarSelf isHidden]) {
        //导航栏隐藏，view top = 0
        self.view.top = 0;
    }
//    else{
//        if (self.navigationController) {
//            CGRect frame = self.view.frame;
//            frame.origin.y = kTopHeight;
//            self.view.frame = frame;
//        }
//    }
}



- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.navigationBarSelf.title = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - NSNotification Center

// 更新主题，刷新view， 主题可能包括：颜色，字体，图片 ...
- (void)refreshViewsForNewScene
{
//    self.navigationBarSelf.backgroundColor = [AppTheme color_nav_bg];
    self.navigationBarSelf.backgroundColor = [UIColor whiteColor];

}

#pragma mark - Navigation Bar

- (void)layoutNavigationBar
{
}

- (void)bringNavToTop
{
    [self.view bringSubviewToFront:self.navigationBarSelf];
}

- (void)backToPrevious
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MB HUD

- (void)showErrorMessage:(NSString *)message
{
    [MBProgressHUD showError:message];
}

- (void)showSuccessMessage:(NSString *)message
{
    [MBProgressHUD showSuccess:message];
}

- (void)showPlainMessage:(NSString *)message
{
    [MBProgressHUD showMessage:message];
}

- (void)showErrorMessage:(NSString *)message toView:(UIView *)view
{
    [MBProgressHUD showError:message toView:view];
}

- (void)showSuccessMessage:(NSString *)message toView:(UIView *)view
{
    [MBProgressHUD showSuccess:message toView:view];
}

- (void)showPlainMessage:(NSString *)message toView:(UIView *)view
{
    [MBProgressHUD showMessage:message toView:view];
}

- (void)showHud
{
    [MBProgressHUD showHud];
}

- (void)showHudMessge:(NSString *)message
{
    [MBProgressHUD showHudMessge:message];
}

- (void)showHudMessge:(NSString *)message toView:(UIView *)view
{
    [MBProgressHUD showHudMessge:message toView:view];
}

- (void)dismissHudView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view];
}

- (void)dismissHudView
{
    [MBProgressHUD hideHUD];
}

#pragma mark - Gif HUD

- (void)showModalLoading
{
//    [GifLoadingView setGifWithImageName:LoadingImage];
//    [GifLoadingView showWithOverlay];
}

- (void)showModalLoadingWithMessage:(NSString *)message
{
//    [GifLoadingView setGifWithImageName:LoadingImage message:message];
//    [GifLoadingView showWithOverlay];
}

- (void)dismissModalLoadingView
{
//    [GifLoadingView dismiss];
}


@end
