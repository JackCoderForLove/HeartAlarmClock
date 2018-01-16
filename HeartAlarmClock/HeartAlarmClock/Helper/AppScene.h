//
//  AppScene.h
//  App
//
//  Created by weixhe on 16/4/15.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  场景类，改变app的场景，可以改变主题（需要刷新 viewController的view，调用BaseViewController中设置所有view的某些参数，例如，bg，font等）
 */
typedef NS_ENUM(NSUInteger, AppThemeStyle) {

    ThemeStyleDefault    = 0,
    ThemeStyleDark       = 1,  // 晚上
    
    
    // 。999。 以后的自定义（如从网络获取）则直接在 999+
};

@class NotificationModel;

@interface AppScene : NSObject

@property (nonatomic, assign) AppThemeStyle themeStyle;

+ (instancetype)shareScene;




extern NSString * const kNotifycation_ChangeScene;

@end

