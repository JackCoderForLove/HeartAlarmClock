//
//  NSString+Extension.h
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

#pragma mark - 检查字符串
// 是否存在值:
- (BOOL)isNotNull;

// 去掉所有的空格
- (NSString *)trimAllWhitespace;

// 检查姓名（待检验）
- (BOOL)checkName;

// 检查手机号
- (BOOL)checkPhoneNum;  // 手机号
- (BOOL)isMobileNumber; // 座机号和手机号（需要验证）

// 检查Email
- (BOOL)checkEmail;

// 检查车牌号
- (BOOL)checkNumAndChar;

// 检查纯数字
- (BOOL)checkNum;
// 检查数字和字母
- (BOOL)checkNumAndString;

// 检测字符串包含某个字符串，适用于IOS7，和IOS8
- (BOOL)myContainsString:(NSString *)other;

// 是否包含表情
- (BOOL)isContainsEmoji;

#pragma mark -  加密

// 加密md5
- (NSString *)md5;

// 加密银行卡号：
- (NSString *)bankCard;

// 加密手机号：131****1111
- (NSString *)phone;

#pragma mark - 计算字符串长度

/**
 *  根据给定最大的的宽度和高度，计算文字的size
 */
- (CGSize)sizeWithSize:(CGSize)size font:(UIFont *)font;

#pragma mark -
/**
 *  创建app唯一标识，除非卸载app，或者手动删除 NSUserDefaults 中的 UUID 字段，否则，该标识永久存在
 */
- (NSString *)createUUID;
//字典转 string
+ (NSString *)jsonStringFromObject:(NSObject*)jsonObject;
//字典转 URLString
+ (NSString *)keyValueStringWithDict:(NSDictionary *)dict;
@end
