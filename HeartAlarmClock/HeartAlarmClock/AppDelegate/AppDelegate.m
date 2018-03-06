//
//  AppDelegate.m
//  HeartAlarmClock
//
//  Created by xingjian on 2018/1/16.
//  Copyright © 2018年 xingjian. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate ()<UIAlertViewDelegate>
{
    AVAudioPlayer *musicPalyer;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //注册本地通知
    [self registerLocalNotification];
    [self configUSharePlatforms];
    HomeViewController *homeVC = [HomeViewController new];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
    self.window.rootViewController = homeNav;

    return YES;
}
#pragma mark ————— 配置第三方 —————
-(void)configUSharePlatforms{
    //打开日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    // 获取友盟social版本号
    //    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5a689d668f4a9d3b2f0002c1"];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx93c390cbed8517c8" appSecret:@"6d8cccf9b871f4aa872c1081c037f8a0" redirectURL:@"http://www.umeng.com/social"];
    //朋友圈
    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wx93c390cbed8517c8" appSecret:@"6d8cccf9b871f4aa872c1081c037f8a0" redirectURL:@"http://www.umeng.com/social"];
    /*
     * 添加某一平台会加入平台下所有分享渠道，如微信：好友、朋友圈、收藏，QQ：QQ和QQ空间
     * 以下接口可移除相应平台类型的分享，如微信收藏，对应类型可在枚举中查找
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    // 设置分享到QQ互联的appID
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kQQKey/*设置QQ平台的appID*/  appSecret:kQQAppSecret redirectURL:@"http://mobile.umeng.com/social"];
//    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_Qzone appKey:kQQKey appSecret:kQQAppSecret redirectURL:@"http://mobile.umeng.com/social"];
//
//    //设置新浪的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kWeiboKey  appSecret:kWeiboAppSecret redirectURL:kWeiboRedirectURI];
}

#pragma mark ————— OpenURL 回调 —————
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

//注册本地通知
- (void)registerLocalNotification
{
    //  ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
    
       // NSSet* set = [NSSet setWithObject:[self jcnotificationCategories]];
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
    }
}
- (UIMutableUserNotificationCategory *)jcnotificationCategories
{
    //初始化action
    UIMutableUserNotificationAction* action1 =  [[UIMutableUserNotificationAction alloc] init];
    //设置action的identifier
    [action1 setIdentifier:@"action1"];
    //title就是按钮上的文字
    [action1 setTitle:@"title1"];
    //设置点击后在后台处理,还是打开APP
    [action1 setActivationMode:UIUserNotificationActivationModeBackground];
    //是不是像UIActionSheet那样的Destructive样式
    [action1 setDestructive:NO];
    //在锁屏界面操作时，是否需要解锁
    [action1 setAuthenticationRequired:NO];
    
    UIMutableUserNotificationAction* action2 = [[UIMutableUserNotificationAction alloc] init];
    [action2 setIdentifier:@"action2"];
    [action2 setTitle:@"title2"];
    [action2 setActivationMode:UIUserNotificationActivationModeForeground];
    [action2 setDestructive:NO];
    [action2 setAuthenticationRequired:NO];
    
    //一个category包含一组action，作为一种显示样式
    UIMutableUserNotificationCategory* category = [[UIMutableUserNotificationCategory alloc] init];
    [category setIdentifier:@"category1"];
    //minimal作为banner样式时使用，最多只能有2个actions；default最多可以有4个actions
    [category setActions:@[action1,action2] forContext:UIUserNotificationActionContextMinimal];
    return category;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //收到本地通知
    NSLog(@"收到本地通知");
    application.applicationIconBadgeNumber = 0;
    UIApplicationState state = application.applicationState;
    if (state == UIApplicationStateActive){
        NSString *musicName = [NSString stringWithFormat:@"%@",notification.soundName];
        [self playWithName:musicName];
        //当程序处于活跃状态时
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扎心闹钟，闹起来" message:notification.alertBody delegate:self cancelButtonTitle: @"确定" otherButtonTitles:nil];
        [alert show];
    }else if(state == UIApplicationStateInactive){
        //程序运行在后台时，点击启动程序按钮时
        NSLog(@"后台点击进入");
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //关闭上次
    [musicPalyer stop];
    musicPalyer.currentTime = 0;//将播放的进度设置为初始状态
    
}
- (void)playWithName:(NSString *)name {
 
    NSURL *url = [[NSBundle mainBundle] URLForAuxiliaryExecutable:name];
    musicPalyer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    //设置声音的大小
    musicPalyer.volume = 1;//范围为（0到1）；
    //设置循环次数，如果为负数，就是无限循环
    musicPalyer.numberOfLoops =-1;
    //设置播放进度
    musicPalyer.currentTime = 0;
    //准备播放
    [musicPalyer prepareToPlay];
    [musicPalyer play];
    

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
