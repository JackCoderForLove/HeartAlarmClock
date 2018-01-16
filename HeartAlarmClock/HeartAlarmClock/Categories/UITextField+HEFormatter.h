//
//  UITextField+Formatter.h
//  WKTextFieldFormatter
//
//  Created by weixhe on 16/3/14.
//  Copyright © 2016年 WelkinXie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UITextFieldFormatterType) {
    
    // version：1.0
    UITextFieldFormatterTypeAny = 0,             // 不过滤
    UITextFieldFormatterTypePhoneNumber,         // 11位电话号码
    UITextFieldFormatterTypeNumber,              // 数字
    UITextFieldFormatterTypeDecimal,             // 小数
    UITextFieldFormatterTypeAlphabet,            // 英文字母
    UITextFieldFormatterTypeNumberAndAlphabet,   // 数字+英文字母
    UITextFieldFormatterTypeIDCard,              // 18位身份证
    UITextFieldFormatterTypeCustom               // 自定义
};

/**
 *  该类是对 UITextField 进行了扩展，可以使得输入框进行一些输入性的限制
 *
 *  以后可能会有所补充
 */

@interface UITextField (HEFormatter)

// 格式类型
@property (nonatomic, assign) UITextFieldFormatterType formatterType;

// 限制长度
@property (nonatomic, assign) NSUInteger limitLength;


// 允许的字符集
@property (nonatomic, copy)   NSString *characterSet;

// 小数位, decimalPlace 默认是2，最小是1，不能设为0
@property (nonatomic, assign) NSUInteger decimalPlace;

/**
 *  初始化方法，在使用该扩展之前，请先调用此方法，用来初始化一些数据，这些初始化数据不会影响您的数据, 如果不调用此方法，结果可能会出现未知问题
 */
//- (void)initializing;

/**
 *  在您设置好您需要的过滤方案后，请在textField的代理中，调用此方法，否则您的设置将不会有任何的作用
 *
 *  - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 *  {
 *      return [textField textFieldShouldChangeCharactersInRange:range replacementString:string];
 *  }
 *
 */
- (BOOL)textFieldShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
