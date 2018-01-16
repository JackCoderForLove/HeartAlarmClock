//
//  MBProgressHUD+Extension.m
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "MBProgressHUD+Extension.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

@implementation MBProgressHUD (Extension)

#pragma mark - indicator 和文字
+ (void)showHud
{
    [self showHudMessge:nil];
}

+ (void)showHudMessge:(NSString *)message
{
    [self showHudMessge:message toView:nil];
}

+ (void)showHudMessge:(NSString *)message toView:(UIView *)view
{
    if (view == nil) {
        view = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.removeFromSuperViewOnHide = YES;
}

#pragma mark - 只文字

+ (void)showMessage:(NSString *)message
{
    [self showMessage:message toView:nil];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) {
        view = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:DuringTime];
    
    if (!hud.tapGesture) {
        hud.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:hud action:@selector(tapGestureAction:)];
        hud.tapGesture.numberOfTapsRequired = 1;
        hud.tapGesture.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:hud.tapGesture];
    }
    __weak UITapGestureRecognizer *tapToHide = hud.tapGesture;
    hud.completionBlock = ^() {
        [view removeGestureRecognizer:tapToHide];
    };
}

+ (void)showMessage:(NSString *)message time:(CGFloat)time
{
    UIView *view = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:time];
}


#pragma mark - 文字和错误图片
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)showError:(NSString *)error time:(CGFloat)time
{
    [self showError:error toView:nil time:time];
}

+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showError:(NSString *)error toView:(UIView *)view time:(CGFloat)time
{
    [self show:error icon:@"error.png" view:view time:time];
}

#pragma mark - 文字和正确图片
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showSuccess:(NSString *)success time:(CGFloat)time
{
    [self showSuccess:success toView:nil time:time];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view time:(CGFloat)time
{
    [self show:success icon:@"success.png" view:view time:time];
}

#pragma mark - 隐藏 HUD
+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:kAppDelegate.window];
}

#pragma mark private
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view time:(CGFloat)time
{
    if (!view) {
        view = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    }
    [MBProgressHUD hideHUDForView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    if (icon) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:time];
    
    if (!hud.tapGesture) {
        hud.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:hud action:@selector(tapGestureAction:)];
        hud.tapGesture.numberOfTapsRequired = 1;
        hud.tapGesture.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:hud.tapGesture];
    }
    __weak UITapGestureRecognizer *tapToHide = hud.tapGesture;
    hud.completionBlock = ^() {
        [view removeGestureRecognizer:tapToHide];
    };
}

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    [MBProgressHUD show:text icon:icon view:view time:DuringTime];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    
    [MBProgressHUD hideHUDForView:tapGesture.view];
}

- (UITapGestureRecognizer *)tapGesture
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTapGesture:(UITapGestureRecognizer *)tapGesture
{
    objc_setAssociatedObject(self, @selector(tapGesture), tapGesture, OBJC_ASSOCIATION_RETAIN);
}
@end
