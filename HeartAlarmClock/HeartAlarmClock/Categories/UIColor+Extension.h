//
//  UIColor+Extension.h
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIColor (Extension)

// 随机获取一种颜色
+ (UIColor *)arc4randomColor;

// 16进制颜色,alpha = 1.0
+ (UIColor *)colorFormRGBHex:(unsigned int)hex;

// 16进制颜色,alpha范围 0~1
+ (UIColor *)colorFormRGBHex:(unsigned int)hex alpha:(float)alpha;

// 获取color, 取值在0~255，alpha 默认 1.0
+ (UIColor *)colorFormRed:(CGFloat)red green:(float)green blue:(float)blue;

// 获取color, 颜色值取值在0~255，alpha 范围 0~1
+ (UIColor *)colorFormRed:(CGFloat)red green:(float)green blue:(float)blue alpha:(float)alpha;

// 将16进制的颜色转换成color
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType viewSize:(CGSize)imgSize;
@end
