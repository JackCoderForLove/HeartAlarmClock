//
//  UIView+Creation.m
//  App
//
//  Created by weixhe on 16/4/25.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "UIView+Creation.h"

@implementation UIView (Creation)

+ (UIView *)createViewWithBgColor:(UIColor *)bgColor alpha:(CGFloat)alpha superView:(UIView *)superView
{
    return [self createViewWithFrame:CGRectZero bgColor:bgColor alpha:alpha superView:superView];
}

+ (UIView *)createViewWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor alpha:(CGFloat)alpha superView:(UIView *)superView
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgColor;
    view.alpha = alpha;
    [superView addSubview:view];
    return view;
}

@end

@implementation UILabel (Creation)

+ (UILabel *)createLabelWithFont:(UIFont *)font text:(NSString *)text superView:(UIView *)superView {
    return [self createLabelWithFrame:CGRectZero font:font text:text superView:superView];
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text superView:(UIView *)superView {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    label.text = text;
    label.textAlignment = NSTextAlignmentLeft;
    if (superView) {
        [superView addSubview:label];
    }
    return label;
}

@end

@implementation UITextField (Creation)

+ (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder delegate:(id)delegate bgImageName:(NSString *)imageName leftView:(UIView *)leftView rightView:(UIView *)rightView isPassWord:(BOOL)isPassWord superView:(UIView *)superView;
{
    return [self createTextFieldFrame:CGRectZero delegate:delegate placeholder:placeholder bgImageName:imageName leftView:leftView rightView:rightView isPassWord:isPassWord superView:superView];
}

+ (UITextField *)createTextFieldFrame:(CGRect)frame delegate:(id)delegate placeholder:(NSString *)placeholder bgImageName:(NSString *)imageName leftView:(UIView *)leftView rightView:(UIView *)rightView isPassWord:(BOOL)isPassWord superView:(UIView *)superView
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.returnKeyType = UIReturnKeyDone;
    
    if (delegate) {
        textField.delegate = delegate;
    }
    
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    if (imageName) {
        textField.background = [UIImage imageNamed:imageName];
    }
    if (leftView) {
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    if (rightView) {
        textField.rightView = rightView;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    if (isPassWord) {
        textField.secureTextEntry = YES;
    }
    if (superView) {
        [superView addSubview:textField];
    }
    return textField;
}

+ (UITextField *)createTextFieldWithFormatter:(UITextFieldFormatterType)formatter delegate:(id)delegate placeholder:(NSString *)placeholder bgImageName:(NSString *)imageName leftView:(UIView *)leftView rightView:(UIView *)rightView isPassWord:(BOOL)isPassWord superView:(UIView *)superView
{
    UITextField *tf = [self createTextFieldWithPlaceholder:placeholder delegate:delegate bgImageName:imageName leftView:leftView rightView:rightView isPassWord:isPassWord superView:superView];
    tf.formatterType = formatter;
    return tf;
}

@end

@implementation UIImageView (Creation)

+ (UIImageView *)createImageViewWithImageName:(NSString *)imageName  superView:(UIView *)superView
{
    return [self createImageViewFrame:CGRectZero imageName:imageName superView:superView];
}

+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName  superView:(UIView *)superView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if (imageName) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    imageView.userInteractionEnabled = YES;
    if (superView) {
        [superView addSubview:imageView];
    }
    return imageView;
}

@end

@implementation UIButton (Creation)

+ (UIButton *)createButtonWithTitle:(NSString *)title imageName:(NSString *)imageName bgImageName:(NSString *)bgImageName  superView:(UIView *)superView
{
    return [self createButtonWithFrame:CGRectZero title:title imageName:imageName bgImageName:bgImageName superView:superView];
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName bgImageName:(NSString *)bgImageName superView:(UIView *)superViewv
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.normalTitleColor = [UIColor blackColor];

    if (title) {
        button.normalTitle = title;
    }
    if (imageName) {
        button.normalImage = imageName;
    }
    if (bgImageName) {
        button.normalBgImage = bgImageName;
    }
    if (superViewv) {
        [superViewv addSubview:button];
    }
    return button;
}

@end

@implementation UITableView (Creation)

+ (UITableView *)createTableViewWithDelegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource superView:(UIView *)superView
{
    return [self createTableViewWithFrame:CGRectZero delegate:delegate dataSource:dataSource superView:superView];
}

+ (UITableView *)createTableViewWithFrame:(CGRect)frame delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource superView:(UIView *)superView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    [superView addSubview:tableView];
    return tableView;
}

@end

@implementation UIWebView (Creation)

+ (UIWebView *)createWebViewFrame:(CGRect)frame delegate:(id)delegate  superView:(UIView *)superView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    if (delegate) {
        webView.delegate = delegate;
    }
    [webView sizeToFit];
    if (superView) {
        [superView addSubview:webView];
    }
    return webView;
}

@end

