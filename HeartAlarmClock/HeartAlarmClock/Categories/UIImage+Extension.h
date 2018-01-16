//
//  UIImage+Extension.h
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Extension.h"
@interface UIImage (Extension)

// 截取部分图像
- (UIImage *)cutOutSubImage:(CGRect)rect;

// 将图片旋转为正方向，适用于照相机，旋转了90度
- (UIImage *)fixOrientationUp;

// 改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color;

// 按比例缩放, size 是你要把图显示到 多大区域 CGSizeMake(300, 140), 取图片的中间部分
- (UIImage *)scaleToSize:(CGSize)size;

// 指定宽度按比例缩放，取图片的中间部分
- (UIImage *)scaleByWidth:(CGFloat)defineWidth;

// 保持原来的长宽比，生成一个缩略图B
- (UIImage *)thumbScaleTosize:(CGSize)asize;

// 手动制作某个颜色的image，常用于设置searchbar的背景色
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 *  根据图片url获取图片尺寸,imageURL 为'字符串'或 'NSURL' 对象
 */
+ (CGSize)getImageSizeWithURL:(id)imageURL;

//设置图片颜色渐变
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;
//设置图片圆角
-(UIImage*)imageWithCornerRadius:(CGFloat)radius;
@end
