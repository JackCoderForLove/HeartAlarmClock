//
//  UIView+Extension.h
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

#pragma mark -


- (void)removeAllSubviews;
- (void)removeViewWithTag:(NSInteger)tag;
- (void)removeViewWithTags:(NSArray *)tagArray;
- (void)removeViewWithTagLessThan:(NSInteger)tag;
- (void)removeViewWithTagGreaterThan:(NSInteger)tag;

- (UIViewController *)controller;
- (UIView *)subviewWithTag:(NSInteger)tag;

#pragma mark - touch

- (void)addTapGesture:(void(^)(void))handle;
- (void)addDoubleTapGesture:(void(^)(void))handle;

#pragma mark - 边角
/**
 *  添加圆角和边的宽度
 */
- (void)cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds;

/**
 *  添加边的宽度
 */
- (void)borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 *  添加阴影
 */
- (void)shadowRadius:(CGFloat)shadowRadius shadowOffset:(CGSize)shadowOffset;
- (void)shadowRadius:(CGFloat)shadowRadius shadowOffset:(CGSize)shadowOffset shadowOpacity:(float)shadowOpacity shadowColor:(UIColor *)shadowColor;

@end
