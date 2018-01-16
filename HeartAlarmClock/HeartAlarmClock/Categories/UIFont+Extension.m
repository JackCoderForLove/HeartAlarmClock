//
//  UIFont+Extension.m
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "UIFont+Extension.h"
#import <objc/message.h>

@implementation UIFont (Extension)

//+ (void)load {
//    
//    Method systimeFont = class_getClassMethod(self, @selector(systemFontOfSize:));
//    
//    Method qsh_systimeFont = class_getClassMethod(self, @selector(yqt_systemFontOfSize:));
//    // 交换方法
//    method_exchangeImplementations(qsh_systimeFont, systimeFont);
//    
//}
//+ (UIFont *)yqt_systemFontOfSize:(CGFloat)pxSize{
//    
//    CGFloat pt = floor((pxSize) / 96.0f * 72.0f);
//    
//    NSLog(@"pt--%f",pt);
//    
//    UIFont *font = [UIFont yqt_systemFontOfSize:pt];
//    
//    return font;
//    
//}

// 系统普通字体，字号，根据屏幕适配改版大小
+ (UIFont *)fontScaleByDevice:(CGFloat)fontSize
{
//    CGFloat pt = floor((fontSize ) / 96.0f * 72.0f) ;

    return [UIFont systemFontOfSize:(fontSize / 2 * kDeviceScale)];
}

// 系统普通加粗字体，字号, 根据屏幕适配改版大小
+ (UIFont *)boldFontScaleByDevice:(CGFloat)fontSize
{
//    CGFloat pt = floor((fontSize) / 96.0f * 72.0f);

    return [UIFont boldSystemFontOfSize:(fontSize / 2 * kDeviceScale)];
}

@end
