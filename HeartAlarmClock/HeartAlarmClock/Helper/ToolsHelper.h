//  ToolsHelper.h
//  NewBodivis
/**
 * ━━━━━━神兽出没━━━━━━
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛Code is far away from bug with the animal protecting
 * 　　　　┃　　　┃    神兽保佑,代码无bug
 * 　　　　┃　　　┃
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 *
 * ━━━━━━感觉萌萌哒━━━━━━
 */
//  Created by xingjian on 2017/12/20.
//  Copyright © 2017年 weixhe. All rights reserved.杰克
//  @class ToolsHelper
//  @abstract 帮助类
//  @discussion <#类的功能#>
//

#import <Foundation/Foundation.h>

@interface ToolsHelper : NSObject
/* --------------------------------- 设备相关  --------------------------*/

//获取app版本号
+(NSString *) getAppVersion;

//获取build版本号
+(NSString *) getBuildVersion;

//获取设备系统版本 例如：8.3  9.0...
+ (NSString *) getSystemVersion;

//获取手机类型 例如：iPhone or ipad...
+ (NSString *) getDeviceModel;

//获取设备名称 例如：iPhone6   iPhone6s...
+ (NSString*) getDeviceName;


/* --------------------------------- 服务相关  --------------------------*/
//颜色色值,全局使用
+ (UIColor *) colorWithHexString: (NSString *)color;

//颜色设置，自动设置alpha值
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alpha;

//计算文字宽度和高度
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;

// 返回虚线image的方法
+ (UIImage *)drawLineByImageView:(UIImageView *)imageView;

//根据时间字符串获取NSDate
+ (NSDate *)jcGetDateWithString:(NSString *)dateStr withFormatter:(NSString *)jcformate;

//根据时间字符串转换格式，获取时间字符串
+ (NSString *)jcGetTimeStrWithString:(NSString *)dateStr withSourceFormmater:(NSString *)sourceF withToFormater:(NSString *)toFormatter;

//根据NSDate转为时间字符串
+(NSString *)jcGetTimeStrWithDate:(NSDate *)date withFormatter:(NSString *)jcformate;

//获取n天前的日期
+(NSDate *)jcGetBeforeDaysTimeWithDate:(NSDate *)jcDate withDays:(NSInteger)day;

//获取n天后的日期
+(NSDate *)jcGetAfterDaysTimeWithDate:(NSDate *)jcDate withDays:(NSInteger)day;


//此段代码可以获取本地异常日志
+ (NSString *)jcGetUncaughtException;

//获取异常日志的路径
+ (NSString *)jcGetUncaughtExceptionPath;

//获取输入日志的路径
+ (NSString *)jcGetLogPath;

//图片处理，存入本地，上传图片
+ (NSString *)fileOfImgInSquareFillBlankWithBlackBgAndPressedImage:(UIImage *)image;
//获取当前季度
+(NSInteger)jcGetCurrentSeason;

//根据当前季度，获取当前相应的的标题数组
+(NSArray *)jcGetDataTitleArr;

//获取当前月份
+(NSInteger)jcGetCurrentMonth;

//获取当前月的天数
+(NSInteger)jcGetCurrentMonthDay;

//获取月的标题数组
+(NSArray *)jcGetMonthTitleArr;

//单位转换之后获取对应的值
+(float)jcGetSwitchUnitValue:(float)jcValue;

//json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//获取切换单位
+ (NSString *)jcSwithUnit;

//获取切换单位汉字版本
+ (NSString *)jcSwithUnicodeUnit;

//获取当前系统时间
+(NSDate *)jcGetCurrentDate;

//获取当前用户的语言
+(NSString *)jcGetCurrentLanguage;
//判断是bodivis还是好体知
+(BOOL)jcISBodivis;

//版本号比较算法
+ (BOOL)jcJudgeAppVersionWithServerVersion:(NSString *)version1 withLoacalVersion:(NSString *)version2;

//按比例缩放,size 是你要把图显示到 多大区域
+ (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size;
//根据时间字符串获取格林尼治时间NSDate
+ (NSDate *)jcGetGLNZDateWithString:(NSString *)dateStr withFormatter:(NSString *)jcformate;
//根据NSDate转为格林尼治时间字符串
+(NSString *)jcGetGLNZTimeStrWithDate:(NSDate *)date withFormatter:(NSString *)jcformate;
//生成唯一id标识符
+(NSString *)jcGetIdentifyID;
@end
