//
//  UIImage+Gif.h
//  App
//
//  Created by weixhe on 16/4/14.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Gif)

/**
 *  通过url返回一个动画的image， 即：gif
 */
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url;

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data;
@end
