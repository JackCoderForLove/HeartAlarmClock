//
//  BarButtonItem.h
//  Test
//
//  Created by weixhe on 15/8/19.
//  Copyright (c) 2015年 weixhe. All rights reserved.
//


// 自定义NavBarBtnItem

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BarButtonItem : NSObject


@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *selectedTitle;

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *selectedImage;

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;

// 如果标题和图片的位置不符合需求，可手动调节文字和图片的位置
@property (nonatomic, assign) UIEdgeInsets titleInsets;
@property (nonatomic, assign) UIEdgeInsets imageInsets;


+ (id)itemWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle;
+ (id)itemWithImage:(NSString *)imageName selectedImage:(NSString *)selectedImage;

@end

