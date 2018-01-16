//
//  AppScene.m
//  App
//
//  Created by weixhe on 16/4/15.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "AppScene.h"
#import "AppTheme.h"

NSString * const kNotifycation_ChangeScene = @"app_changeScene";

@interface AppScene ()

@end

static AppScene *scene = nil;
@implementation AppScene

+ (instancetype)shareScene {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scene = [[AppScene alloc] init];
    });
    return scene;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _themeStyle = ThemeStyleDefault;
    }
    return self;
}


#pragma mark - Setter & Getter

// 设置 Scene
- (void)setThemeStyle:(AppThemeStyle)themeStyle
{
    if (_themeStyle != themeStyle) {
        _themeStyle = themeStyle;
        switch (_themeStyle) {
            case ThemeStyleDefault:
                
                AppTheme.changeTheme([[NSBundle mainBundle] pathForResource:@"DefaultTheme" ofType:@"plist"]);
                
                break;
            case ThemeStyleDark:
                AppTheme.changeTheme([[NSBundle mainBundle] pathForResource:@"DarkTheme" ofType:@"plist"]);
                break;
                
            default:
                
                if (_themeStyle > 999) {
                    // 用户从网络下载下来的theme，命名为999+.plist
                    
                }
                
                break;
        }
        // 请在baseViewController，baseView中实现这个通知，否则，主题将不会刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifycation_ChangeScene object:nil];
    }
}

@end
