//
//  AppTheme.m
//  App
//
//  Created by weixhe on 16/4/14.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "AppTheme.h"

#define key_color_nav_bg                    @"color_nav_bg"
#define key_color_nav_title                 @"color_nav_title"
#define key_color_tab                       @"color_tab"
#define key_color_tab_title_norma           @"color_tab_title_normal"
#define key_color_tab_title_selected        @"color_tab_title_selected"
#define key_color_tab_bridge_bg             @"color_tab_bridge_bg"
#define key_color_tab_bridge_text           @"color_tab_bridge_text"

#define key_color_0xeeeeee                  @"color_0xeeeeee"
#define key_color_0xffffff                  @"color_0xffffff"



#define key_font_nav_title                  @"font_nav_title"
#define key_font_nav_left                   @"font_nav_left"
#define key_font_tab_normal                 @"font_tab_normal"
#define key_font_tab_selected               @"font_tab_selected"
#define key_font_tab_bridge                 @"font_tab_bridge"

#define key_font_11                         @"font_11"
#define key_font_bold_11                    @"font_bold_11"
#define key_font_12                         @"font_12"
#define key_font_bold_12                    @"font_bold_12"
#define key_font_13                         @"font_13"
#define key_font_bold_13                    @"font_bold_13"
#define key_font_14                         @"font_14"
#define key_font_bold_14                    @"font_bold_14"
#define key_font_15                         @"font_15"
#define key_font_bold_15                    @"font_bold_15"
#define key_font_16                         @"font_16"
#define key_font_bold_16                    @"font_bold_16"
#define key_font_17                         @"font_17"
#define key_font_bold_17                    @"font_bold_17"


@interface AppTheme ()

@property (nonatomic, strong) NSDictionary *fontInfo;
@property (nonatomic, strong) NSDictionary *colorInfo;

@end

static AppTheme * instance = nil;

@implementation AppTheme

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppTheme alloc] init];
    });
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DefaultTheme" ofType:@"plist"];
        [self changeTheme:path];
        
    }
    return self;
}

// 改变主题，path为主题plist文件的路径
- (void)changeTheme:(NSString *)path {
    
    self.fontInfo = [[NSDictionary dictionaryWithContentsOfFile:path] valueForKey:@"Fonts"];
    self.colorInfo = [[NSDictionary dictionaryWithContentsOfFile:path] valueForKey:@"Colors"];
    
}

+ (AppTheme * (^)(NSString *path))changeTheme {

    return ^(NSString *path) {
        
        [[AppTheme instance] changeTheme:path];
        
        return [AppTheme instance];
    };
}

#pragma mark - 颜色配置
+ (UIColor *)color_nav_bg {
    NSString *color_hex = [[AppTheme instance].colorInfo valueForKey:key_color_nav_bg];
    return [UIColor colorWithHexString:color_hex];
}

+ (UIColor *)color_nav_title {
    NSString *color_hex = [[AppTheme instance].colorInfo valueForKey:key_color_nav_title];
    return [UIColor colorWithHexString:color_hex];
}

+ (UIColor *)color_tab {
    NSString *color_hex = [[AppTheme instance].colorInfo valueForKey:key_color_tab];
    return [UIColor colorWithHexString:color_hex];
}

+ (UIColor *)color_tab_title_normal {
    
    NSString *color_hex = [[AppTheme instance].colorInfo valueForKey:key_color_tab_title_norma];
    return [UIColor colorWithHexString:color_hex];
}

+ (UIColor *)color_tab_title_selected {
    NSString *color_hex = [[AppTheme instance].colorInfo valueForKey:key_color_tab_title_selected];
    return [UIColor colorWithHexString:color_hex];
}

+ (UIColor *)color_tab_bridge_bg {
    NSString *color_hex = [[AppTheme instance].colorInfo valueForKey:key_color_tab_bridge_bg];
    return [UIColor colorWithHexString:color_hex];
}

+ (UIColor *)color_tab_bridge_text {
    NSString *color_hex = [[AppTheme instance].colorInfo valueForKey:key_color_tab_bridge_text];
    return [UIColor colorWithHexString:color_hex];
}



+ (UIColor *)color_0xeeeeee {
    NSString *color_hex = [[AppTheme instance].colorInfo valueForKey:key_color_0xeeeeee];
    return [UIColor colorWithHexString:color_hex];
}

+ (UIColor *)color_0xffffff {
    NSString *color_hex = [[AppTheme instance].colorInfo valueForKey:key_color_0xffffff];
    return [UIColor colorWithHexString:color_hex];
}

#pragma mark - 字体，字号配置
+ (UIFont *)font_nav_title {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_nav_title] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_nav_left {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_nav_left] floatValue] * kDeviceScale;
    
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_tab_normal {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_tab_normal] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_tab_selected {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_tab_selected] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_tab_bridge {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_tab_bridge] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_11 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_11] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_bold_11 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_bold_11] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_12 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_12] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_bold_12 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_bold_12] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_13 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_13] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_bold_13 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_bold_13] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_14 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_14] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_bold_14 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_bold_14] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_15 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_15] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_bold_15 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_bold_15] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_16 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_16] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_bold_16 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_bold_16] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_17 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_17] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

+ (UIFont *)font_bold_17 {
    float font_size = [[[AppTheme instance].fontInfo valueForKey:key_font_bold_17] floatValue] * kDeviceScale;
    return [UIFont systemFontOfSize:font_size];
}

@end
