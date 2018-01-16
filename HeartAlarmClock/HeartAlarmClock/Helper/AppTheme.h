//
//  AppTheme.h
//  App
//
//  Created by weixhe on 16/4/14.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  主题类，对应不同的场景，设置不同的主题，包括颜色，字体大小，字号等
 */
@interface AppTheme : NSObject

// 改变主题，path为主题plist文件的路径
+ (AppTheme * (^)(NSString *path))changeTheme;

#pragma mark - 颜色配置
+ (UIColor *)color_nav_bg;
+ (UIColor *)color_nav_title;
+ (UIColor *)color_tab;
+ (UIColor *)color_tab_title_normal;
+ (UIColor *)color_tab_title_selected;
+ (UIColor *)color_tab_bridge_bg;
+ (UIColor *)color_tab_bridge_text;

+ (UIColor *)color_0xeeeeee;
+ (UIColor *)color_0xffffff;

#pragma mark - 字体，字号配置
+ (UIFont *)font_nav_title;
+ (UIFont *)font_nav_left;
+ (UIFont *)font_tab_normal;
+ (UIFont *)font_tab_selected;
+ (UIFont *)font_tab_bridge;

+ (UIFont *)font_11;
+ (UIFont *)font_bold_11;
+ (UIFont *)font_12;
+ (UIFont *)font_bold_12;
+ (UIFont *)font_13;
+ (UIFont *)font_bold_13;
+ (UIFont *)font_14;
+ (UIFont *)font_bold_14;
+ (UIFont *)font_15;
+ (UIFont *)font_bold_15;
+ (UIFont *)font_16;
+ (UIFont *)font_bold_16;
+ (UIFont *)font_17;
+ (UIFont *)font_bold_17;


@end
