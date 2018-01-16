//
//  UIButton+Extension.h
//  App
//
//  Created by weixhe on 16/4/25.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

// title
@property (nonatomic, strong) NSString *normalTitle;
@property (nonatomic, strong) NSString *highlightedTitle;
@property (nonatomic, strong) NSString *selectedTitle;

// title color
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *highlightedTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, strong) UIFont *titleFont;


// image
@property (nonatomic, strong) NSString *normalImage;
@property (nonatomic, strong) NSString *highlightedImage;
@property (nonatomic, strong) NSString *selectedImage;

// background image
@property (nonatomic, strong) NSString *normalBgImage;
@property (nonatomic, strong) NSString *highlightedBgImage;
@property (nonatomic, strong) NSString *selectedBgImage;

/**
 *  验证码倒计时
 */
- (void)verifedCodeButtonWithTitle:(NSString *)title andNewTitle:(NSString *)newTitle bgImageName:(NSString *)imageName newBgImageName:(NSString *)newImageName;


@end
