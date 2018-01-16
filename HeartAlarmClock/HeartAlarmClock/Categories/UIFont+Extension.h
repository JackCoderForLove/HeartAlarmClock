//
//  UIFont+Extension.h
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extension)

// 系统普通字体，字号，根据屏幕适配改版大小
+ (UIFont *)fontScaleByDevice:(CGFloat)fontSize;

// 系统普通加粗字体，字号, 根据屏幕适配改版大小
+ (UIFont *)boldFontScaleByDevice:(CGFloat)fontSize;

@end
