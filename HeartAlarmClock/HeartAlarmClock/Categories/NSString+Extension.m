//
//  NSString+Extension.m
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "NSString+Extension.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (Extension)

#pragma mark - 检查字符串

// 是否存在值
- (BOOL)isNotNull
{
    if (self && self.length > 0) {
        return YES;
    }
    return NO;
}

// 去掉所有的空格
- (NSString *)trimAllWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// 检查姓名（待检验）
- (BOOL)checkName
{
    if (![self length]) {
        return NO;
    }
    
    NSString *str = @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$€% ";
    
    for (int j = 0; j < [self length]; j++) {
        
        NSString *str1 = [self substringWithRange:NSMakeRange(j,1)];
        
        for (int i = 0; i < [str length]; i++) {
            
            if ([str1 isEqualToString:[str substringWithRange:NSMakeRange(i, 1)]]) {
                
                if ([str1 isEqualToString:@" "]) {
                    str1 = @"空格符";
                }
                // [NSString stringWithFormat:@"姓名不能包含特殊字符:%@",str1]
                return NO;
            }
        }
    }
    return YES;
}

// 检查手机号
- (BOOL)checkPhoneNum
{
    if (![self length]) {
        return NO;
    }
    
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    if (![phoneTest evaluateWithObject:self]) {
        
        return NO;
    }
    
    return YES;
}

- (BOOL)isMobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 检查Email
- (BOOL)checkEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

// 检查车牌号
- (BOOL)checkNumAndChar
{
    NSString *phoneRegex = @"^[A-Za-z0-9]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    if (![phoneTest evaluateWithObject:self]) {
        return NO;
    }
    return YES;
}

// 检查纯数字
- (BOOL)checkNum
{
    NSString *phoneRegex = @"^[0-9]*$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    if (![phoneTest evaluateWithObject:self]) {
        return NO;
    }
    return YES;
}

// 检查数字和字母
- (BOOL)checkNumAndString
{
    NSString * regex = @"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![predicate evaluateWithObject:self]) {
        return NO;
    }
    return YES;
}

// 检测字符串包含某个字符串，适用于IOS7，和IOS8(覆盖系统方法)
- (BOOL)containsString:(NSString *)other
{
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

// 检测字符串包含某个字符串，适用于IOS7，和IOS8
- (BOOL)myContainsString:(NSString *)other
{
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

- (BOOL)isContainsEmoji
{
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

#pragma mark - 加密
// Need to import for CC_MD5 access
- (NSString *)md5;
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

// 加密银行卡号：
- (NSString *)bankCard
{
    // 加密隐藏银行卡号
    NSString *yhzh = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSRange range = NSMakeRange(4, yhzh.length - 8);
    
    yhzh = [yhzh stringByReplacingCharactersInRange:range withString:@"********"];
    return yhzh;
}

// 加密手机号：131****1111
- (NSString *)phone
{
    if (![self checkPhoneNum]) {
        return @"请填写正确手机号";
    }
    // 加密隐藏银行卡号
    NSString *phone = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    phone = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSRange range = NSMakeRange(3, 4);
    phone = [phone stringByReplacingCharactersInRange:range withString:@"****"];
    return phone;
}

#pragma mark - 计算字符串长度
/**
 *  根据给定最大的的宽度和高度，计算文字的size
 */
- (CGSize)sizeWithSize:(CGSize)size font:(UIFont *)font
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size;
}


#pragma mark - 
/**
 *  创建app唯一标识，除非卸载app，或者手动删除 NSUserDefaults 中的 UUID 字段，否则，该标识永久存在
 */
- (NSString *)createUUID
{
    NSString *id = [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];    //获取标识为"UUID"的值
    if(id == nil)
    {
        if([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0) {
            NSString *identifierNumber = [[NSUUID UUID] UUIDString];                //ios 6.0 之后可以使用的api
            [[NSUserDefaults standardUserDefaults] setObject:identifierNumber forKey:@"UUID"];  //保存为UUID
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } else {
            
            CFUUIDRef uuid = CFUUIDCreate(NULL);
            CFStringRef uuidString = CFUUIDCreateString(NULL, uuid);                    //ios6.0之前使用的api
            NSString *identifierNumber = [NSString stringWithFormat:@"%@", uuidString];
            [[NSUserDefaults standardUserDefaults] setObject:identifierNumber forKey:@"UUID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            CFRelease(uuidString);
            CFRelease(uuid);
        }
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
    }
    return id;
}

+ (NSString *)jsonStringFromObject:(NSObject*)jsonObject
{
    if (jsonObject && [NSJSONSerialization isValidJSONObject:jsonObject]) {
        NSData* data = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:nil];
        if (data.length > 0) {
            NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            return jsonString;
        }
    }
    return nil;
}

+ (NSString *)keyValueStringWithDict:(NSDictionary *)dict
{
    if (dict == nil) {
        return nil;
    }
    NSMutableString *string = [NSMutableString stringWithString:@"?"];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"%@=%@&",key,obj];
    }];
    
    if ([string rangeOfString:@"&"].length) {
        [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    }
    
    return string;
}


@end
