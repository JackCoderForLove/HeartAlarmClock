//  ToolsHelper.m
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

#import "ToolsHelper.h"
#import <sys/utsname.h>
#import "NSDate+Extension.h"


@implementation ToolsHelper
#pragma mark -
#pragma mark - 获取app版本号
+(NSString *) getAppVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}
#pragma mark -
#pragma mark - 获取build版本号
+(NSString *) getBuildVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
#pragma mark -
#pragma mark - 获取设备系统版本 例如：iOS 10.0...
+(NSString *) getSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark -
#pragma mark - 获取手机类型 例如：iphone or ipad...
+(NSString *)getDeviceModel
{
    return [[UIDevice currentDevice] model];
}

#pragma mark -
#pragma mark - 获取设备名称 如：iPhone6   iPhone6s...
+(NSString*) getDeviceName {
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",      // (Original)
                              @"iPod2,1"   :@"iPod Touch",      // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",      // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",      // (Fourth Generation)
                              @"iPod7,1"   :@"iPod Touch",      // (6th Generation)
                              @"iPhone1,1" :@"iPhone",          // (Original)
                              @"iPhone1,2" :@"iPhone",          // (3G)
                              @"iPhone2,1" :@"iPhone",          // (3GS)
                              @"iPad1,1"   :@"iPad",            // (Original)
                              @"iPad2,1"   :@"iPad 2",          //
                              @"iPad3,1"   :@"iPad",            // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",        // (GSM)
                              @"iPhone3,3" :@"iPhone 4",        // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",       //
                              @"iPhone5,1" :@"iPhone 5",        // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",        // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",            // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",       // (Original)
                              @"iPhone5,3" :@"iPhone 5c",       // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",       // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",       // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",       // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",   //
                              @"iPhone7,2" :@"iPhone 6",        //
                              @"iPhone8,1" :@"iPhone 6S",       //
                              @"iPhone8,2" :@"iPhone 6S Plus",  //
                              @"iPhone9,1" :@"iPhone 7",
                              @"iPhone9,2" :@"iPhone 7 Plus",
                              @"iPad4,1"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",       // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini",       // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,7"   :@"iPad Mini"        // (3rd Generation iPad Mini - Wifi (model A1599))
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
        else {
            deviceName = @"Unknown";
        }
    }
    
    return deviceName;
}



#pragma mark -
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}


//计算文字宽度和高度
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}
// 返回虚线image的方法
+ (UIImage *)drawLineByImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 0.5是每个虚线的长度 1是高度
    CGFloat lengths[] = {4,4,4};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [ToolsHelper colorWithHexString:@"#d2d2d2"].CGColor);
    CGContextSetLineDash(line, 0, lengths, 3); //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0); //开始画线
    CGContextAddLineToPoint(line, 0.0, imageView.frame.size.height);
    
    CGContextStrokePath(line);
    
    return UIGraphicsGetImageFromCurrentImageContext();
}
//根据时间字符串获取NSDate
+ (NSDate *)jcGetDateWithString:(NSString *)dateStr withFormatter:(NSString *)jcformate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    // 设置日期格式 为了转换成功
    if (jcformate.length==0) {
        format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    else
    {
        format.dateFormat = jcformate;
    }
    // NSString * -> NSDate *
    NSDate *data = [format dateFromString:dateStr];
    return data;
    
}

//根据NSDate转为时间字符串
+(NSString *)jcGetTimeStrWithDate:(NSDate *)date withFormatter:(NSString *)jcformate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    // 设置日期格式 为了转换成功
    if (jcformate.length==0) {
        format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    else
    {
        format.dateFormat = jcformate;
    }
    NSString *timeString = [format stringFromDate:date];
    return timeString;
}
//根据时间字符串转换格式，获取时间字符串
+ (NSString *)jcGetTimeStrWithString:(NSString *)dateStr withSourceFormmater:(NSString *)sourceF withToFormater:(NSString *)toFormatter
{
    NSString *timeStr;
    NSDate *jcDate = [ToolsHelper jcGetDateWithString:dateStr withFormatter:sourceF];
    timeStr = [ToolsHelper jcGetTimeStrWithDate:jcDate withFormatter:toFormatter];
    return timeStr;
    
}
//获取n天前的日期
+(NSDate *)jcGetBeforeDaysTimeWithDate:(NSDate *)jcDate withDays:(NSInteger)day
{
    NSDate *jcBeforeDate;
    NSTimeInterval  beforeDay = 24*60*60*day;  //1天的长度
    //之后的天数
    jcBeforeDate = [jcDate dateByAddingTimeInterval: -beforeDay];
    return jcBeforeDate;
}

//获取n天后的日期
+(NSDate *)jcGetAfterDaysTimeWithDate:(NSDate *)jcDate withDays:(NSInteger)day
{
    NSDate *jcAfterDate;
    NSTimeInterval  afterDay = 24*60*60*day;  //1天的长度
    //之后的天数
    jcAfterDate = [jcDate dateByAddingTimeInterval: +afterDay];
    return jcAfterDate;
}

//此段代码可以获取本地异常日志
+ (NSString *)jcGetUncaughtException
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"Log"];
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"UncaughtException.log"];
    NSString * jcContent = [NSString stringWithContentsOfFile:logFilePath encoding:NSUTF8StringEncoding error:nil];
    //替换反斜杠,上传异常日志到后台，如果有反斜杠，上传失败
    jcContent = [jcContent stringByReplacingOccurrencesOfString:@"'\'" withString:@"'/'"];
    return jcContent;
    
}
+ (NSString *)jcGetUncaughtExceptionPath
{
    
    NSString *logDirectory = @"Log";
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"UncaughtException.log"];
    return logFilePath;
}
+ (NSString *)jcGetLogPath
{
    NSString *logDirectory = @"Log";
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"NewBodivis.log"];
    
    return logFilePath;
    
}

//将图像的中心放在正方形区域的中心，图形未填充的区域用黑色填充，并压缩到40－100k，
+ (NSString *)fileOfImgInSquareFillBlankWithBlackBgAndPressedImage:(UIImage *)image{
    
    // NSLog(@"%@", NSStringFromCGSize(image.size));
    
    NSString *tmpDic = NSTemporaryDirectory(); //生成一个临时目录，生命周期很短
    NSDate *date = [NSDate date];
    NSDateFormatter *formatDate = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatDate setLocale:locale];
    [formatDate setDateFormat:@"yyyyMMddHHmmss"];
    NSString* dateStr = [formatDate stringFromDate:date];
    NSString *imagelocalName_s = [NSString stringWithFormat:@"%@_s.jpg", dateStr];
    NSString *_image_Path=[tmpDic stringByAppendingPathComponent:imagelocalName_s];
    
    CGSize imageSize;
    imageSize.height = image.size.height;
    imageSize.width = image.size.width;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    UIBezierPath* p = [UIBezierPath bezierPathWithRect:CGRectMake(0,0,image.size.width,image.size.height)];
    [[UIColor blackColor] setFill];
    [p fill];
    
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    
    UIImage *imageHavePress = UIGraphicsGetImageFromCurrentImageContext();
    //    NSData *pressSizeData1 = UIImageJPEGRepresentation(imageHavePress, 1.0);
    UIGraphicsEndImageContext();
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *pressSizeData = UIImageJPEGRepresentation(imageHavePress, compression);
    while ([pressSizeData length] > 200*1024 && compression > maxCompression) {
        compression -= 0.1;
        pressSizeData = UIImageJPEGRepresentation(imageHavePress, compression);
    }
    //    NSData *pressSizeData = UIImageJPEGRepresentation(imageHavePress, 1.0);
    //
    //    if (pressSizeData.length>1024*1024){
    //        pressSizeData = UIImageJPEGRepresentation(imageHavePress, 1.0);
    //    }
    
    [pressSizeData writeToFile:_image_Path atomically:YES];
    
    return _image_Path;
    
}
//获取当前季度
+(NSInteger)jcGetCurrentSeason
{
    NSInteger month = [NSDate date].month;
    NSInteger season = 1;
    if (month == 1||month == 2||month == 3) {
        season = 1;
    }
    else if (month == 4||month == 5||month == 6)
    {
        season = 2;
    }
    else if (month == 7||month == 8||month == 9)
    {
        season = 3;
    }
    else if (month == 10||month == 11||month == 12)
    {
        season = 4;
    }
    return month;
}
//根据当前季度，获取当前相应的的标题数组
+(NSArray *)jcGetDataTitleArr
{
    NSInteger season = [ToolsHelper jcGetCurrentSeason];
    NSArray *jcTitleArr;
    if (season == 1) {
        jcTitleArr = @[JCLocalStr(@"jc1M", @"1月"),JCLocalStr(@"jc3M", @"3月")];
    }
    else if (season == 2)
    {
        jcTitleArr = @[JCLocalStr(@"jc4M", @"4月"),JCLocalStr(@"jc6M", @"6月")];
    }
    else if (season == 3)
    {
        jcTitleArr = @[JCLocalStr(@"jc7M", @"7月"),JCLocalStr(@"jc9M", @"9月")];
    }
    else if (season == 4)
    {
        jcTitleArr = @[JCLocalStr(@"jc10M", @"10月"),JCLocalStr(@"jc12M", @"12月")];
    }
    return jcTitleArr;
}
//获取当前月份
+(NSInteger)jcGetCurrentMonth
{
    return [[NSDate date]month];
}
//获取当前月的天数
+(NSInteger)jcGetCurrentMonthDay
{
    NSInteger day = 31;
    NSInteger month = [ToolsHelper jcGetCurrentMonth];
    if (month == 1||month==3||month==5||month==7||month==8||month==10||month==12) {
        day = 31;
    }
    else if (month == 2)
    {
        //判断是否是闰年
        if ([[NSDate date]isLeapYear]== YES) {
            day = 29;
        }
        else
        {
            day = 28;
        }
    }
    else if (month == 4||month==6||month==9||month==11)
    {
        day = 30;
    }
    return day;
}

//获取月的标题数组
+(NSArray *)jcGetMonthTitleArr
{
    NSArray *titleArr;
    NSInteger maxDay = [ToolsHelper jcGetCurrentMonthDay];
    NSInteger currentMonth = [ToolsHelper jcGetCurrentMonth];
    NSString *firstTitle = [NSString stringWithFormat:@"%ld.1",currentMonth];
    NSString *secondTitle = [NSString stringWithFormat:@"%ld.15",currentMonth];
    NSString *thirdTitle = [NSString stringWithFormat:@"%ld.%ld",currentMonth,maxDay];
    titleArr = @[firstTitle,secondTitle,thirdTitle];
    return titleArr;
}

//json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//获取当前系统时间
+(NSDate *)jcGetCurrentDate
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}
//获取当前用户的语言
+(NSString *)jcGetCurrentLanguage
{
    NSString *jcLanguage;
    jcLanguage =  [[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage];
    if (jcLanguage.length == 0) {
        jcLanguage = Chinese_Simplified;
    }
    else if([jcLanguage isEqualToString:Chinese_Simplified])
    {
        jcLanguage = @"zh";
    }
    else if ([jcLanguage isEqualToString:English])
    {
        jcLanguage = @"en";
    }
    return jcLanguage;
}
//版本号比较算法
+ (BOOL)jcJudgeAppVersionWithServerVersion:(NSString *)version1 withLoacalVersion:(NSString *)version2
{
    NSArray *versions1 = [version1 componentsSeparatedByString:@"."];
    NSArray *versions2 = [version2 componentsSeparatedByString:@"."];
    
    for (int i = 0; i< (versions1.count> versions2.count)?versions1.count :versions2.count; i++) {
        
        if (versions1.count < i+1) return NO;
        if (versions2.count < i+1) return YES;
        
        int v1 = [versions1[i] intValue];
        int v2 = [versions2[i] intValue];
        if (v1 != v2)
            return v1 > v2;
    }
    return NO;
    
}
//按比例缩放,size 是你要把图显示到 多大区域
+ (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

//根据时间字符串获取NSDate
+ (NSDate *)jcGetGLNZDateWithString:(NSString *)dateStr withFormatter:(NSString *)jcformate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    if (jcformate.length==0) {
        format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    else
    {
        format.dateFormat = jcformate;
    }
    // NSString * -> NSDate *
    NSDate *data = [format dateFromString:dateStr];
    return data;
    
}

//根据NSDate转为时间字符串
+(NSString *)jcGetGLNZTimeStrWithDate:(NSDate *)date withFormatter:(NSString *)jcformate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    if (jcformate.length==0) {
        format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    else
    {
        format.dateFormat = jcformate;
    }
    NSString *timeString = [format stringFromDate:date];
    return timeString;
}

@end
