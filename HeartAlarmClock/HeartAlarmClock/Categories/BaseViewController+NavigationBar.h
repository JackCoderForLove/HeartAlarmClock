//
//  BaseViewController+NavigationBar.h
//  App
//
//  Created by weixhe on 16/5/27.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "BaseViewController.h"
#import "NavigationBar.h"
#import "BarButtonItem.h"

@interface BaseViewController (NavigationBar)

@property (nonatomic, strong) NavigationBar *navigationBarSelf;

@property (nonatomic, strong) BarButtonItem *leftItem;
@property (nonatomic, strong) BarButtonItem *rightItem;
@property (nonatomic, strong) UIView *titleView;



- (void)addNavigationBar;

- (void)titleView:(UIView *)view;

- (void)leftTitle:(NSString *)title target:(id)target action:(SEL)action;
- (void)leftImage:(NSString *)image target:(id)target action:(SEL)action;

- (void)rightTitle:(NSString *)title target:(id)target action:(SEL)action;
- (void)rightImage:(NSString *)image target:(id)target action:(SEL)action;

/**
 *  可变的 ‘title’ 和 ‘image’ ，点击的时候需要设置按钮的‘selected’属性，用来标识是 ’正常‘还是’已选中‘
 *
 *  @param title         正常状态下的title
 *  @param selectedTitle 选中状态下的title
 *  @param image         正常状态下的image
 *  @param selectedImage 选中状态下的selectedImage
 *  @param target        目标对象，一般传‘self’，如果需要在其他的类中响应事件，可设置其他的对象
 *  @param action        事件action
 */
- (void)leftTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action;
- (void)leftImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action;

- (void)rightTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action;
- (void)rightImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action;
@end
