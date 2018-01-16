//
//  BaseViewController+NavigationBar.m
//  App
//
//  Created by weixhe on 16/5/27.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "BaseViewController+NavigationBar.h"

@implementation BaseViewController (NavigationBar)

@dynamic navigationBarSelf;
@dynamic leftItem, rightItem, titleView;

#pragma mark - Getter & Setter
- (void)setNavigationBarSelf:(NavigationBar *)navigationBarSelf
{
    objc_setAssociatedObject(self, @selector(navigationBarSelf), navigationBarSelf, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NavigationBar *)navigationBarSelf
{
    return objc_getAssociatedObject(self, @selector(navigationBarSelf));
}

- (void)setLeftItem:(BarButtonItem *)leftItem
{
    objc_setAssociatedObject(self, @selector(leftItem), leftItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BarButtonItem *)leftItem
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setRightItem:(BarButtonItem *)rightItem
{
    objc_setAssociatedObject(self, @selector(rightItem), rightItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BarButtonItem *)rightItem
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTitleView:(UIView *)titleView
{
    objc_setAssociatedObject(self, @selector(titleView), titleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)titleView
{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark -

- (void)addNavigationBar
{
    self.navigationBarSelf = [[NavigationBar alloc] init];
    self.navigationBarSelf.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTopHeight);
    [self.view addSubview:self.navigationBarSelf];
}

#pragma mark - Method

- (void)leftTitle:(NSString *)title target:(id)target action:(SEL)action
{
    BarButtonItem *item = [self generateBtnWithTitle:title selectedTitle:nil image:nil selectedImage:nil target:target action:action];
    self.leftItem = item;

    self.navigationBarSelf.leftView = item.button;
}

- (void)leftTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action
{
    BarButtonItem *item = [self generateBtnWithTitle:title selectedTitle:selectedTitle image:nil selectedImage:nil target:target action:action];
    self.leftItem = item;
    self.navigationBarSelf.leftView = item.button;
}

- (void)leftImage:(NSString *)image target:(id)target action:(SEL)action
{
    BarButtonItem *item = [self generateBtnWithTitle:nil selectedTitle:nil image:image selectedImage:nil target:target action:action];
    
    self.leftItem = item;
    self.navigationBarSelf.leftView = item.button;
}

- (void)leftImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    BarButtonItem *item = [self generateBtnWithTitle:nil selectedTitle:nil image:image selectedImage:selectedImage target:target action:action];
    
    self.leftItem = item;
    self.navigationBarSelf.leftView = item.button;
}

- (void)rightTitle:(NSString *)title target:(id)target action:(SEL)action
{
    BarButtonItem *item = [self generateBtnWithTitle:title selectedTitle:nil image:nil selectedImage:nil target:target action:action];
    [item.button setupAutoSizeWithHorizontalPadding:10 buttonHeight:40];
    self.rightItem = item;
    self.navigationBarSelf.rightView = item.button;
}

- (void)rightTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action
{
    BarButtonItem *item = [self generateBtnWithTitle:title selectedTitle:selectedTitle image:nil selectedImage:nil target:target action:action];
    [item.button setupAutoSizeWithHorizontalPadding:10 buttonHeight:40];
    self.rightItem = item;
    self.navigationBarSelf.rightView = item.button;
}

- (void)rightImage:(NSString *)image target:(id)target action:(SEL)action
{
    BarButtonItem *item = [self generateBtnWithTitle:nil selectedTitle:nil image:image selectedImage:nil target:target action:action];
    
    self.rightItem = item;
    self.navigationBarSelf.rightView = item.button;
}

- (void)rightImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    BarButtonItem *item = [self generateBtnWithTitle:nil selectedTitle:nil image:image selectedImage:selectedImage target:target action:action];
    
    self.rightItem = item;
    self.navigationBarSelf.rightView = item.button;
}

- (void)titleView:(UIView *)view
{
    self.titleView = view;
    self.navigationBarSelf.titleView = view;
}

- (BarButtonItem *)generateBtnWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle image:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    BarButtonItem * item = nil;
    
    if (title.length != 0) {
        item = [BarButtonItem itemWithTitle:title selectedTitle:selectedTitle];
    }
    if (image.length != 0) {
        item = [BarButtonItem itemWithImage:image selectedImage:selectedImage];
    }
    item.target = target;
    item.selector = action;
    return item;
}


@end
