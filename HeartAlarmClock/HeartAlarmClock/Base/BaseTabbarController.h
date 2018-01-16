//
//  BaseTabbarController.h
//  App
//
//  Created by weixhe on 16/4/25.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HandleWhenClickCurrentItem)(NSUInteger);

@class HETabbar;
@interface BaseTabbarController : UITabBarController

@property (nonatomic, strong) HETabbar *cusTabbar;

@property (nonatomic, assign) CGFloat tabHeight;    // 系统默认49，如有特殊需求可进行改变
@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, strong) NSArray <UIImage *> *images;      // 所有的图片
@property (nonatomic, strong) NSArray <UIImage *> *selectedImages;  // 所有的图片 — 选中状态，如果不设值，则默认和titles一致

@property (nonatomic, strong) NSArray <NSString *> *titles;      // 所有的标题
@property (nonatomic, strong) NSArray <NSString *> *selectedTitles;  // 所有的标题 — 选中状态，如果不设值，则默认和titles一致

@property (nonatomic, strong) UIColor *color;       // 正常状态的标题颜色
@property (nonatomic, strong) UIColor *selectedColor;   // 选中状态的标题颜色，如果不设值，则默认和titles一致

@property (nonatomic, copy) HandleWhenClickCurrentItem clickCurrentItem;    // 点击当前页，（本身已处于某页，再次点击当前页时处理特殊事件）

/**
 *  切换 tab 上的 image，也可设置角标等
 */
- (void)exchangeNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage atIndex:(int)index;


// 【显示】、【隐藏】角标‘bridge’
extern NSString *kNotificationToShowBridge;         // 通知的name
extern NSString *kNotificationToHidenBridge;        // 通知的name
extern NSString *kTabbar_index;     // 通知中 userinfo 的 key
extern NSString *kTabbar_bridgeNum; // 通知中 userinfo 的 key

// 【显示】、【隐藏】tabbar，上下隐藏
extern NSString *kNotificationShowTabbar;
extern NSString *kNotificationHidenTabbar;

@end



#pragma mark - 类 HETabbar
/**
 *  自定义tabbar
 */
@interface HETabbar : UIView
{
    UIImageView *_imageView;
    UIView *_line;
}

@property (nonatomic, assign) BOOL showShadow;
@property (nonatomic, assign) BOOL showLine;

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic,assign)UIEdgeInsets oldSafeAreaInsets;

@end


#pragma mark - 类 HETabbarItem
/**
 *  自定义tabbarItem
 */
@class HEBubbleView;
@interface HETabbarItem : UIControl
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    HEBubbleView *_bubbleView;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *selectedTitle;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIFont *selectedFont;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, strong) NSString *bridgeNum;


@end




