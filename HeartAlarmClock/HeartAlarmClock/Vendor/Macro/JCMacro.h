//
//  JCMacro.h
//  NewBodivis
//
//  Created by xingjian on 2017/12/11.
//  Copyright © 2017年 weixhe. All rights reserved.
//

#ifndef JCMacro_h
#define JCMacro_h

//iPhonex适配
#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.height==2436 : NO)
//导航栏高度
#define  JCNavBarHeight  (isIPhoneX ? 88 : 64)
//底部Tabbar 高度
#define JCTabBarHeight  (isIPhoneX ? 83 : 49)
//状态栏高度
#define  JCStatusBarHeight  (isIPhoneX ? 44 : 20)
//距离安全区margin
#define  JC_TabbarSafeBottomMargin   (isIPhoneX ? 34.f : 0.f)
//距离状态栏安全区margin
#define  JC_TabbarSafeTopMargin   (isIPhoneX ? 44.f : 0.f)


#define isIOS11 [[UIDevice currentDevice].systemVersion floatValue] >= 11

//由角度转弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

#define jcAESPassWord @"6SD8UH6GR43DF7J9"

/*************国际化宏定义**************/
#define Chinese_Simplified @"zh-Hans"//简体
#define Chinese_Traditional_HK @"zh-Hant-HK"//香港繁体
#define Chinese_Traditional_TW @"zh-Hant-TW"//台湾繁体
#define English @"en"
#define Japanese @"ja"
#define French @"fr"
#define changeLanguage @"changelanguage"//改变语言的通知名称
#define AppLanguage @"appLanguage"
#define JCLocalStr(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:@"JCTFLanguage"]

#define isBindMobilePhone  @"isBindMobilePhone"  //是否绑定手机号，默认为No,即为没有绑定手机号，如果为Yes,则为绑定手机号

#define isUpdateUserInfo  @"isUpdateUserInfo"  //更新资料通知

//数据持久化－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
#define defaults [NSUserDefaults standardUserDefaults]

#define JCCUURENTUSERID @"JCCURRENDUSERID"

/******************block弱引用强引用转换******************/
#define WeakSelf(type) __weak typeof(type) weak##type = type

#define StrongSelf(type) __strong typeof(type) strong##type = type

/******************护眼模式******************/
#define JCEyeCareValueISOpen  @"JCEyeCareValueISOpen"           //护眼模式是否开启，默认是未开启，NO,如果是Yes,则是开启护眼模式
#define JCEyeCareValue        @0.3                 //护眼模式亮度值
#define JCEyeCareLastDefaultValue @"JCEyeCareLastDefaultValue"  //护眼模式系统默认亮度

/******************苹果健康是否开启******************/
#define JCHealthKitISOpen  @"jchealthkitisopen"   //苹果健康是否开启

/******************是否第一次安装******************/
#define JCIsFirstSaveSetUP    @"JCIsFirstSaveSetUP" //是否是第一次安装，默认为No,如果第一次安装之后，则设置为Yes,不在进行安装统计，除非用户强制删除，再重新统计

//是否显示更新数据
#define JCISShowUpdateData               @"jcisshowupdatedata"    //如果是No,则显示更新数据，如果是yes,则不显示更新数据

#endif /* JCMacro_h */
