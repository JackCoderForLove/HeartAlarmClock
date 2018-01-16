//
//  BaseViewController.h
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseNavigationController, BaseTabbarController;
@interface BaseViewController : UIViewController

@property (nonatomic ,assign) CGFloat assistantHeight;// 偏移量  指键盘顶部控件的Y值

// 更新主题，刷新view， 主题可能包括：颜色，字体，图片 ...
- (void)refreshViewsForNewScene;

#pragma mark - UINavigation Bar
- (void)layoutNavigationBar;
- (void)bringNavToTop;
- (void)backToPrevious;

#pragma mark - MB HUD 

/**
 *  显示 HUD，没有 indicator icon，并且 一段是时间后会自动消失，
 *  如果对 success.png，或者error.png 图片不满意，请替换MBHUD中的相应的图片。
 */
- (void)showErrorMessage:(NSString *)message;
- (void)showSuccessMessage:(NSString *)message;
- (void)showPlainMessage:(NSString *)message;
- (void)showErrorMessage:(NSString *)message toView:(UIView *)view;
- (void)showSuccessMessage:(NSString *)message toView:(UIView *)view;
- (void)showPlainMessage:(NSString *)message toView:(UIView *)view;

/**
 *  显示HUD，带 indicator icon， 不能自动消失，需要用户手动控制
 */
- (void)showHud;
- (void)showHudMessge:(NSString *)message;
- (void)showHudMessge:(NSString *)message toView:(UIView *)view;

/**
 *  手动控制消失
 */
- (void)dismissHudView:(UIView *)view;
- (void)dismissHudView;

#pragma mark - Gif HUD

- (void)showModalLoading;
- (void)showModalLoadingWithMessage:(NSString *)message;
- (void)dismissModalLoadingView;

@end
