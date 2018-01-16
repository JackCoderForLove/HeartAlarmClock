//
//  UIButton+Extension.m
//  App
//
//  Created by weixhe on 16/4/25.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "UIButton+Extension.h"

int kTimeout = 60;


@implementation UIButton (Extension)

@dynamic normalTitle, highlightedTitle, selectedTitle;
@dynamic normalTitleColor, highlightedTitleColor, selectedTitleColor;
@dynamic normalImage, highlightedImage, selectedImage;
@dynamic normalBgImage, highlightedBgImage, selectedBgImage;
@dynamic titleFont;

// title
- (void)setNormalTitle:(NSString *)normalTitle
{
    [self setTitle:normalTitle forState:UIControlStateNormal];
}

- (void)setHighlightedTitle:(NSString *)highlightedTitle
{
    [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}

- (void)setSelectedTitle:(NSString *)selectedTitle
{
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

// title color
- (void)setNormalTitleColor:(UIColor *)normalTitleColor
{
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
}

- (void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor
{
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    self.titleLabel.font = titleFont;
}

// image
- (void)setNormalImage:(NSString *)normalImage
{
    [self setImage:UIImageNamed(normalImage) forState:UIControlStateNormal];
}

- (void)setHighlightedImage:(NSString *)highlightedImage
{
    [self setImage:UIImageNamed(highlightedImage) forState:UIControlStateHighlighted];
}

- (void)setSelectedImage:(NSString *)selectedImage
{
    [self setImage:UIImageNamed(selectedImage) forState:UIControlStateSelected];
}

// background image
- (void)setNormalBgImage:(NSString *)normalBgImage
{
    [self setBackgroundImage:UIImageNamed(normalBgImage) forState:UIControlStateNormal];
}

- (void)setHighlightedBgImage:(NSString *)highlightedBgImage
{
    [self setBackgroundImage:UIImageNamed(highlightedBgImage) forState:UIControlStateHighlighted];
}

- (void)setSelectedBgImage:(NSString *)selectedBgImage
{
    [self setBackgroundImage:UIImageNamed(selectedBgImage) forState:UIControlStateSelected];
}


- (void)verifedCodeButtonWithTitle:(NSString *)title andNewTitle:(NSString *)newTitle bgImageName:(NSString *)imageName newBgImageName:(NSString *)newImageName
{
    WS(weakSelf);
    __block int timeout = kTimeout;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (title) {
                    weakSelf.normalTitle = title;
                    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont fontScaleByDevice:24]}];
                    self.sd_layout
                    .widthIs(size.width + kPt(40));
                }
                if (imageName) {
                    weakSelf.normalBgImage = imageName;
                }
                weakSelf.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
//                if (newTitle) {
                    weakSelf.normalTitle = [NSString stringWithFormat:@"%@s", strTime];
//                }
                if (newImageName) {
                    weakSelf.normalBgImage = newImageName;
                }
                [UIView commitAnimations];
                weakSelf.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
@end
