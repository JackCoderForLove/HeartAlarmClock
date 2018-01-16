//
//  Macro.h
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#ifndef Macro_h
#define Macro_h


/*========================================输出打印============================================*/

#ifdef DEBUG
    #define CLog(xx, ...)  NSLog(@"%s(%d行):\t\t" xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
    #define CLog(xx, ...)
#endif


/// 是否模拟器
#ifdef TARGET_IPHONE_SIMULATOR
#define isSimulators TARGET_IPHONE_SIMULATOR
#endif

#define kAppStore_Url   @""//@"https://itunes.apple.com/us/app/ums/id580112518?mt=8&uo=4"
#define kCheckApp_URL   @"http://itunes.apple.com/lookup?id=1053509984"

/*========================================屏幕适配============================================*/

#define kUIApplication                  [UIApplication sharedApplication]
#define kUIWindow                       [[kUIApplication delegate] window] //获得window
#define kAppDelegate                    ((AppDelegate *)kUIApplication.delegate)
#define UserDefaults                    [NSUserDefaults standardUserDefaults]
#define WS(weakSelf)                    __weak __typeof(&*self)weakSelf = self;

#define kDeviceScaleFactor(num)         ((num) * kDeviceScale)
#define kHDeviceScaleFactor(num)         ((num) * kHDeviceScale)
//#define kPt(px)                         (floor(((px) / 96.0f * 72.0f)) / 2)
#define kPt(px)                         ((px) / 2 * kDeviceScale)
#define kHPt(px)                         ((px) / 2 * kHDeviceScale)
#define kDeviceScale                    (SCREEN_WIDTH / 375.0)   // 用来适配frame，font等，根据屏幕的大小，适当改变，以iPhone6的宽度为基准
#define kHDeviceScale                    (SCREEN_HEIGHT / 667.0)   // 用来适配frame，font等，根据屏幕的大小，适当改变，以iPhone6的高度为基准

/** 这个参数,看公司项目UI图 具体是哪款机型,默认  iphone6
 RealUISrceenWidth  4/4s 5/5s 320.0  6/6s 375.0  6p/6sp 414.0
 RealUISrceenHeight 4/4s 修改480 5/5s 568.0  6/6s 667.0  6p/6sp 736.0  (备用)
 */

/// 系统语言
#define kLanguage_IOS_System ([[NSLocale preferredLanguages] objectAtIndex:0])
/// 当前应用build版本号
#define kApp_Version_Build [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]
/// 当前应用发布版本号
#define kApp_Version_Short [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
// 应用程序的名字
#define kApp_DisplayName  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

/// 加载图片
#define UIImageLoad(name, type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:type]]
#define UIImageNamed( name ) [UIImage imageNamed: name]


/*========================================屏幕适配============================================*/

/// 是否是iPad iPhone，和retian屏
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

/// 屏幕高度、宽度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height // 主屏幕的高度
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width  // 主屏幕的宽度

#define Screen_Max_Length (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))   // 取屏幕的最大宽度
#define Screen_Min_Length (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))   // 取屏幕的最大宽度
#define kScreen_Bounds [UIScreen mainScreen].bounds

/// 是否iPhone 型号
#define isIphone_4_or_less (IS_IPHONE && Screen_Max_Length < 568.0)
#define isIphone_5 (IS_IPHONE && Screen_Max_Length == 568.0)   // 1136/2
#define isIphone_6 (IS_IPHONE && Screen_Max_Length == 667.0)   // 1334/2
#define isIphone_6P (IS_IPHONE && Screen_Max_Length == 736.0)  // 2208/3 （414， 736）

/// 当前系统版本大于等于某版本
#define IOS_Equal_or_Above(v) (([[[UIDevice currentDevice] systemVersion] floatValue] >= (v))? (YES):(NO))
/// 当前系统版本小于等于某版本
#define IOS_Equal_or_Below(v) (([[[UIDevice currentDevice] systemVersion] floatValue] <= (v))? (YES):(NO))

#define isIOS6 ([[[UIDevice currentDevice] systemVersion] intValue] == 6 ? (YES):(NO))
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] intValue] == 7 ? (YES):(NO))
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] intValue] == 8 ? (YES):(NO))
#define isIOS9 ([[[UIDevice currentDevice] systemVersion] intValue] == 9 ? (YES):(NO))

/// 颜色
#define UIColorWithRGBHex(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromAlphaRGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define UIColorWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define UIColorWithRGB(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]

/// 常用文件路径
#define kPathForDocument NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define kPathForLibrary  NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES)[0]
#define kPathForCaches   NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES)[0]

/// 通过‘FileHandle’中的clean方法清内存时，此文件夹在清除缓存是将不会被清空，在此文件夹下写文件是请慎重
#define kPathSolid       [kPathForLibrary stringByAppendingPathComponent:@"AppSolidFile"]

#pragma mark - 以下不常用

// 标记
#define MARK CLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)

// 中英状态下键盘的高度
#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)


// 标准系统状态栏高度
#define SYS_STATUSBAR_HEIGHT 20
// 热点栏高度
#define HOTSPOT_STATUSBAR_HEIGHT 20

#define APP_STATUSBAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

// 打开热点
#define IS_HOTSPOT_CONNECTED (APP_STATUSBAR_HEIGHT==(SYS_STATUSBAR_HEIGHT+HOTSPOT_STATUSBAR_HEIGHT)?YES:NO)

//
//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)


//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
#define requestKey  @"qweasdzxc"


#endif /* Macro_h */
