//
//  AppDelegate.m
//  HeartAlarmClock
//
//  Created by xingjian on 2018/1/16.
//  Copyright © 2018年 xingjian. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //注册本地通知
    [self registerLocalNotification];
    HomeViewController *homeVC = [HomeViewController new];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
    self.window.rootViewController = homeNav;

    return YES;
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
        //当程序处于活跃状态时
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"时间提醒" message:notification.alertBody delegate:self cancelButtonTitle: @"确定" otherButtonTitles:nil];
        [alert show];
    }else if(state == UIApplicationStateInactive){
        //程序运行在后台时，点击启动程序按钮时
        NSLog(@"后台点击进入");
    }
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
