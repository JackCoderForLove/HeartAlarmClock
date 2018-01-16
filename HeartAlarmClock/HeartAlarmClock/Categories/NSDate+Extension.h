//
//  NSDate+Extension.h
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (Extension)

+ (NSCalendar *) currentCalendar; // avoid bottlenecks
// 本地的date，[NSDate date] 是GMT时间，比本地时间少8个小时
+ (NSDate *)localeDate;

// 与当前时间Now有关系的时间
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// 简化日期，时间格式 String类型 (系统)
@property (nonatomic, readonly) NSString *shortString;              // 12/4/15, 3:02 PM
@property (nonatomic, readonly) NSString *shortDateString;          // 12/4/15
@property (nonatomic, readonly) NSString *shortTimeString;          // 3:02 PM
@property (nonatomic, readonly) NSString *mediumString;             // Dec 4, 2015, 3:02:09 PM
@property (nonatomic, readonly) NSString *mediumDateString;         // Dec 4, 2015
@property (nonatomic, readonly) NSString *mediumTimeString;         // 3:02:09 PM
@property (nonatomic, readonly) NSString *longString;               // December 4, 2015 at 3:02:09 PM GMT+8
@property (nonatomic, readonly) NSString *longDateString;           // December 4, 2015
@property (nonatomic, readonly) NSString *longTimeString;           // 3:02:09 PM GMT+8

// 系统的样式
- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;

// 自定义的样式
- (NSString *) stringWithFormat: (NSString *) format;
+ (NSDate *) dateFromString:(NSString *)string format:(NSString *)format;


// 时间比较
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;       // 忽略时间（时分秒），也可自定义
- (BOOL) isEarlierToDateIgnoringTime: (NSDate *) aDate;     // 忽略时间（时分秒），也可自定义
- (BOOL) isLaterToDateIgnoringTime: (NSDate *) aDate;       // 忽略时间（时分秒），也可自定义

- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;

- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;

- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isNextMonth;
- (BOOL) isLastMonth;

- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

- (BOOL) isInFuture;
- (BOOL) isInPast;

// 日期角色：工作日，周末
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;


// 根据date，获取其他的的日期
- (NSDate *) dateByAddingYears: (NSInteger) dYears;
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date 每天的起始和结束时间
- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;

// 两个日期之间相差的时间
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;

// 返回两个日期之间的天，时，分，秒
- (NSInteger) distanceInDaysToDate:(NSDate *)anotherDate;
- (NSInteger) distanceInHoursToDate:(NSDate *)anotherDate;
- (NSInteger) distanceInMinutesToDate:(NSDate *)anotherDate;
- (NSInteger) distanceInSecondsToDate:(NSDate *)anotherDate;

// 分解date
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;
@property (readonly) NSInteger quarter; // 季度，验证未通过

@end
