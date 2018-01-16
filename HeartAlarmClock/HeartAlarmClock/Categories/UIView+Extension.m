//
//  UIView+Extension.m
//  App
//
//  Created by weixhe on 16/4/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}


#pragma mark - 

- (void)removeAllSubviews
{
    while ([self.subviews count] > 0) {
        UIView *subview = [self.subviews objectAtIndex:0];
        [subview removeFromSuperview];
    }
}

- (void)removeViewWithTag:(NSInteger)tag
{
    if (tag == 0) {
        return;
    }
    UIView *view = [self viewWithTag:tag];
    if (view) {
        [view removeFromSuperview];
    }
}

- (void)removeSubViewArray:(NSMutableArray *)views
{
    for (UIView *sub in views) {
        [sub removeFromSuperview];
    }
}

- (void)removeViewWithTags:(NSArray *)tagArray
{
    for (NSNumber *num in tagArray) {
        [self removeViewWithTag:[num integerValue]];
    }
}

- (void)removeViewWithTagLessThan:(NSInteger)tag
{
    NSMutableArray *views = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if (view.tag > 0 && view.tag < tag) {
            [views addObject:view];
        }
    }
    [self removeSubViewArray:views];
}

- (void)removeViewWithTagGreaterThan:(NSInteger)tag
{
    NSMutableArray *views = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if (view.tag > 0 && view.tag > tag) {
            [views addObject:view];
        }
    }
    [self removeSubViewArray:views];
}

- (UIViewController *)controller
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


- (UIView *)subviewWithTag:(NSInteger)tag
{
    for (UIView *sub in self.subviews) {
        if (sub.tag == tag) {
            return sub;
        }
    }
    return nil;
}


#pragma mark - touch

const void * tapGestureHandle = "tapGestureBlock";
- (void)addTapGesture:(void(^)(void))handle
{
    if (!self.userInteractionEnabled) {
        self.userInteractionEnabled = YES;
    }
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGes];
    objc_setAssociatedObject(self, tapGestureHandle, handle, OBJC_ASSOCIATION_COPY);
}

BOOL doubleTap = NO;
- (void)tapAction:(UITapGestureRecognizer *)tapGesture {
    
    
    if (tapGesture.numberOfTapsRequired == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (doubleTap) {
                doubleTap = NO;
                return ;
            }
            void (^handle)(void) = objc_getAssociatedObject(self, tapGestureHandle);
            handle();
            
        });
    } else if (tapGesture.numberOfTapsRequired == 2) {
        doubleTap = YES;
        void (^handle)(void) = objc_getAssociatedObject(self, doubleTapGestureHandle);
        handle();
    }
    
}

const void * doubleTapGestureHandle = "doubleTapGestureHandle";

- (void)addDoubleTapGesture:(void(^)(void))handle {
    if (!self.userInteractionEnabled) {
        self.userInteractionEnabled = YES;
    }
    UITapGestureRecognizer *doubleTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    doubleTapGes.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTapGes];
    objc_setAssociatedObject(self, doubleTapGestureHandle, handle, OBJC_ASSOCIATION_COPY);
}

#pragma mark - 边角

/**
 *  添加圆角和边的宽度
 */
- (void)cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = masksToBounds;
}

/**
 *  添加边的宽度
 */
- (void)borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

/**
 *  添加阴影
 */
- (void)shadowRadius:(CGFloat)shadowRadius shadowOffset:(CGSize)shadowOffset
{
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.6;
}
- (void)shadowRadius:(CGFloat)shadowRadius shadowOffset:(CGSize)shadowOffset shadowOpacity:(float)shadowOpacity shadowColor:(UIColor *)shadowColor
{
    [self shadowRadius:shadowRadius shadowOffset:shadowOffset];
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowColor = shadowColor.CGColor;
}

@end

