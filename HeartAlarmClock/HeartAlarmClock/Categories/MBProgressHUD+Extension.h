//
//  MBProgressHUD+Extension.h
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "MBProgressHUD.h"


#define DuringTime 2.0

@interface MBProgressHUD (Extension)

/**
 *  显示 indicator icon 和文字, 不能自动消失
 */
+ (void)showHud;
+ (void)showHudMessge:(NSString *)message;
+ (void)showHudMessge:(NSString *)message toView:(UIView *)view;

/**
 *  只显示文字
 */
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message time:(CGFloat)time;
+ (void)showMessage:(NSString *)message toView:(UIView *)view;

/**
 *  显示文字和成功的图片
 */
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success time:(CGFloat)time;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view time:(CGFloat)time;

/**
 *   显示文字和失败图片
 */
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error time:(CGFloat)time;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view time:(CGFloat)time;

/**
 *  隐藏 HUD
 */
+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

/**
 *  点击，使得 HUD 消失
 */
@property (nonatomic, strong, readonly) UITapGestureRecognizer *tapGesture;

@end
