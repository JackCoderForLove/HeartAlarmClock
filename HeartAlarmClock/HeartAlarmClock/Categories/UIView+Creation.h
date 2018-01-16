//
//  UIView+Creation.h
//  App
//
//  Created by weixhe on 16/4/25.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Creation)

+ (UIView *)createViewWithBgColor:(UIColor *)bgColor alpha:(CGFloat)alpha superView:(UIView *)superView;
+ (UIView *)createViewWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor alpha:(CGFloat)alpha superView:(UIView *)superView;

@end

@interface UILabel (Creation)

+ (UILabel *)createLabelWithFont:(UIFont *)font text:(NSString *)text superView:(UIView *)superView;

+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text superView:(UIView *)superView;

@end

@interface UITextField (Creation)

+ (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder
                                       delegate:(id)delegate
                                    bgImageName:(NSString *)imageName
                                       leftView:(UIView *)leftView
                                      rightView:(UIView *)rightView
                                     isPassWord:(BOOL)isPassWord
                                      superView:(UIView *)superView;

+ (UITextField *)createTextFieldFrame:(CGRect)frame
                             delegate:(id)delegate
                          placeholder:(NSString *)placeholder
                          bgImageName:(NSString *)imageName
                             leftView:(UIView *)leftView
                            rightView:(UIView *)rightView
                           isPassWord:(BOOL)isPassWord
                            superView:(UIView *)superView;

+ (UITextField *)createTextFieldWithFormatter:(UITextFieldFormatterType)formatter
                                     delegate:(id)delegate
                                  placeholder:(NSString *)placeholder
                                  bgImageName:(NSString *)imageName
                                     leftView:(UIView *)leftView
                                    rightView:(UIView *)rightView
                                   isPassWord:(BOOL)isPassWord
                                    superView:(UIView *)superView;

@end

@interface UIImageView (Creation)

+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName superView:(UIView *)superView;

+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName superView:(UIView *)superView;

@end

@interface UIButton (Creation)

+ (UIButton *)createButtonWithTitle:(NSString *)title imageName:(NSString *)imageName bgImageName:(NSString *)bgImageName superView:(UIView *)superView;

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName bgImageName:(NSString *)bgImageName superView:(UIView *)superView;


@end

@interface UITableView (Creation)

+ (UITableView *)createTableViewWithDelegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource superView:(UIView *)superView;

+ (UITableView *)createTableViewWithFrame:(CGRect)frame delegate:(id <UITableViewDelegate>)delegate dataSource:(id <UITableViewDataSource>)dataSource superView:(UIView *)superView;

@end

@interface UIWebView (Creation)

+ (UIWebView *)createWebViewFrame:(CGRect)frame delegate:(id)delegate superView:(UIView *)superView;

@end
