//
//  BarButtonItem.m
//  Test
//
//  Created by weixhe on 15/8/19.
//  Copyright (c) 2015年 weixhe. All rights reserved.
//

#import "BarButtonItem.h"

@interface BarButtonItem ()


@end

@implementation BarButtonItem
@synthesize button;

+ (id)itemWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle
{
    BarButtonItem *item = [[BarButtonItem alloc] init];
    item.button = [UIButton buttonWithType:UIButtonTypeCustom];
    item.title = title;
    item.selectedTitle = selectedTitle;
    item.button.titleLabel.font  = [UIFont fontScaleByDevice:28];
//    [item.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [item.button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [item.button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [item.button setTitleColor:UIColorHex(0x777777) forState:UIControlStateNormal];
    [item.button setTitleColor:UIColorHex(0x777777) forState:UIControlStateHighlighted];
    [item.button setTitleColor:UIColorHex(0x777777) forState:UIControlStateSelected];

    return item;
}

+ (id)itemWithImage:(NSString *)imageName selectedImage:(NSString *)selectedImage
{
    BarButtonItem *item = [[BarButtonItem alloc] init];
    item.button = [UIButton buttonWithType:UIButtonTypeCustom];
    item.image = imageName;
    item.selectedImage = selectedImage;
    return item;
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
        [button setTitle:_title forState:UIControlStateNormal];
    }
}

- (void)setSelectedTitle:(NSString *)selectedTitle
{
    if (_selectedTitle != selectedTitle) {
        _selectedTitle = selectedTitle;
        [button setTitle:_selectedTitle forState:UIControlStateSelected];
    }
}

- (void)setImage:(NSString *)image
{
    if (_image != image) {
        _image = image;
        if ([image containsString:@"http"]) {
            [button sd_setImageWithURL:[NSURL URLWithString:_image] forState:(UIControlStateNormal)];
//            [button.imageView  sd_setImageWithURL:[NSURL URLWithString:image] completed:nil];
            [button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_image]]] forState:(UIControlStateNormal)];
        }else
            
        [button setImage:[UIImage imageNamed:_image] forState:UIControlStateNormal];
    }
}

- (void)setSelectedImage:(NSString *)selectedImage
{
    if (_selectedImage != selectedImage) {
        _selectedImage = selectedImage;
        [button setImage:[UIImage imageNamed:_selectedImage] forState:UIControlStateSelected];
    }
}

- (void)setTarget:(id)target
{
    if (_target != target) {
        _target = target;
    }
}

- (void)setSelector:(SEL)selector
{
    if (_selector != selector) {
        _selector = selector;
        [button removeTarget:_target action:NULL forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];;
    }
}

// 调节位置
- (void)setTitleInsets:(UIEdgeInsets)titleInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_titleInsets, titleInsets)) {
        _titleInsets = titleInsets;
        button.titleEdgeInsets = titleInsets;
    }
}

- (void)setImageInsets:(UIEdgeInsets)imageInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_imageInsets, imageInsets)) {
        _imageInsets = imageInsets;
        button.imageEdgeInsets = imageInsets;
    }
}

@end
