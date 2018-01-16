//
//  UITextField+Formatter.m
//  WKTextFieldFormatter
//
//  Created by weixhe on 16/3/14.
//  Copyright © 2016年 WelkinXie. All rights reserved.


#import "UITextField+HEFormatter.h"
#import <objc/runtime.h>


@implementation UITextField (HEFormatter)
@dynamic formatterType, limitLength, characterSet, decimalPlace;


#pragma mark - 属性的设置

// 1. formatterType的实现
- (void)setFormatterType:(UITextFieldFormatterType)formatterType
{
    if (formatterType == UITextFieldFormatterTypeDecimal || formatterType == UITextFieldFormatterTypeNumber ||  formatterType == UITextFieldFormatterTypePhoneNumber) {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    objc_setAssociatedObject(self, @selector(formatterType), @(formatterType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (UITextFieldFormatterType)formatterType
{
    NSNumber *obj = objc_getAssociatedObject(self, _cmd);
    return obj.integerValue;
}

// 2. limitLength 的实现
- (void)setLimitLength:(NSUInteger)limitLength
{
    objc_setAssociatedObject(self, @selector(limitLength), @(limitLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSUInteger)limitLength
{
    NSNumber *obj = objc_getAssociatedObject(self, _cmd);
    return obj.integerValue;
}

// 3. characterSet 的实现
- (void)setCharacterSet:(NSString *)characterSet
{
    objc_setAssociatedObject(self, @selector(characterSet), characterSet, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)characterSet
{
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}

// 4. decimalPlace 的实现
- (void)setDecimalPlace:(NSUInteger)decimalPlace
{
    if (decimalPlace == 0) {
        decimalPlace = 1;
    }
    objc_setAssociatedObject(self, @selector(decimalPlace), @(decimalPlace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)decimalPlace
{
    NSNumber *obj = objc_getAssociatedObject(self, _cmd);
    return obj.integerValue;
}

#pragma mark - Method

///**
// *  初始化方法，在使用该扩展之前，请先调用此方法，用来初始化一些数据，这些初始化数据不会影响您的数据
// */
//- (void)initializing
//{
//    self.formatterType = UITextFieldFormatterTypeAny;
//    self.limitLength = INT16_MAX;
//    self.characterSet = @"";
//    self.decimalPlace = 2;
//}

/**
 *  在您设置好您需要的过滤方案后，请开启监听，否则您的设置将不会有任何的作用
 */
- (BOOL)textFieldShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.limitLength == 0) {
        self.limitLength = INT16_MAX;
    }
    
    NSString *regexString = @"";
    switch (self.formatterType) {
        case UITextFieldFormatterTypeAny:               // 任意
        {
            return YES;
        }
        case UITextFieldFormatterTypePhoneNumber:       // 手机号：自动限制11位数字
        {
            regexString = @"^\\d{0,11}$";
            break;
        }
        case UITextFieldFormatterTypeNumber:            // 数字[0-9], 限制长度 0 - limitLength
        {
            regexString = [NSString stringWithFormat:@"^\\d{0,%lu}$", (long)self.limitLength];
            break;
        }
        case UITextFieldFormatterTypeDecimal:           // 小数，限定小数的长度
        {
            if (self.decimalPlace == 0) {
                self.decimalPlace = 2;
            }
            regexString = [NSString stringWithFormat:@"^(\\d+)\\.?(\\d{0,%lu})$", (long)self.decimalPlace];
            break;
        }
        case UITextFieldFormatterTypeAlphabet:          // 英文字母, 限制长度 0 - limitLength
        {
            regexString = [NSString stringWithFormat:@"^[a-zA-Z]{0,%lu}$", (long)self.limitLength];
            break;
        }
        case UITextFieldFormatterTypeNumberAndAlphabet: // 数字+英文字母，, 限制长度 0 - limitLength
        {
            regexString = [NSString stringWithFormat:@"^[a-zA-Z0-9]{0,%lu}$", (long)self.limitLength];
            break;
        }
        case UITextFieldFormatterTypeIDCard:            // 身份证号，限定18位长度，最后一位可以是 "数字，X，x"
        {
            regexString = @"^\\d{1,17}[0-9Xx]?$";
            break;
        }
        case UITextFieldFormatterTypeCustom:            // 用户自定义的一些字符，数字，特殊字符等，限定长度  0 - limitLength
        {
            if (!self.characterSet) {
                self.characterSet = @"";
            }
            regexString = [NSString stringWithFormat:@"^[%@]{0,%lu}$", self.characterSet, (long)self.limitLength];
            break;
        }
        default:
            break;
    }
    NSString *currentText = [self.text stringByReplacingCharactersInRange:range withString:string];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    
    return [regexTest evaluateWithObject:currentText] || currentText.length == 0;
}

@end
