//
//  BaseTabbarController.m
//  App
//
//  Created by weixhe on 16/4/25.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "BaseTabbarController.h"
#import "HEBubbleView.h"

// 【显示】、【隐藏】角标‘bridge’
NSString *kNotificationToShowBridge          =   @"baseTabbar_showBridge";      // 通知的name
NSString *kNotificationToHidenBridge         =   @"baseTabbar_hidenBridge";     // 通知的name
NSString *kTabbar_index                      =   @"baseTabbar_index";           // 通知中 userinfo 的 key
NSString *kTabbar_bridgeNum                  =   @"baseTabbar_bridgeNum";       // 通知中 userinfo 的 key

// 【显示】、【隐藏】tabbar
NSString *kNotificationShowTabbar            =  @"baseTabbar_showTabbar";
NSString *kNotificationHidenTabbar           =  @"baseTabbar_hidenTabbar";

@interface BaseTabbarController () <UITabBarControllerDelegate>
{
    BOOL isHiden;
    NSMutableArray *_items;     // 保存items
    HETabbarItem *_preItem;     // 上一个item
    HETabbarItem *_curItem;     // 当前item
}


@end

@implementation BaseTabbarController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self removeObserver:self.tabBar forKeyPath:@"frame"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.selectedIndex = 0;
    _tabHeight = kTabBarHeight;
    [self hideRealTabBar];
    
    self.cusTabbar = [[HETabbar alloc] init];
    [self.view addSubview:self.cusTabbar];
    
    self.cusTabbar.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(_tabHeight);
    
    self.cusTabbar.showShadow = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBridge:) name:kNotificationToShowBridge object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidenBridge:) name:kNotificationToHidenBridge object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabbar) name:kNotificationShowTabbar object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidenTabbar) name:kNotificationHidenTabbar object:nil];
}

- (void)hideRealTabBar
{
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[UITabBar class]]) {
            view.hidden = YES;
            view.y = SCREEN_HEIGHT;   // 将系统的 ‘tabbar’ 隐藏
            break;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 通知

/**
 *  显示角标
 */
- (void)showBridge:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    if ([userInfo containKey:kTabbar_index]) {
        // 判断是哪个 index
        if (_items.count >= [userInfo containKey:kTabbar_index] + 1) {
            HETabbarItem *item = [_items objectAtIndex:[[userInfo valueForKey:kTabbar_index] intValue]];
            
            // 取数值
            if ([userInfo containKey:kTabbar_bridgeNum]) {
                item.bridgeNum = [userInfo valueForKey:kTabbar_bridgeNum];  // 负值为点，0为隐藏，正直为显示数字
            }
        }
    }
}

/**
 *  隐藏角标
 */
- (void)hidenBridge:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    if ([userInfo containKey:kTabbar_index]) {
        if (_items.count >= [userInfo containKey:kTabbar_index] + 1) {
            HETabbarItem *item = [_items objectAtIndex:[[userInfo valueForKey:kTabbar_index] intValue]];
            item.bridgeNum = @"0";  // 负值为点，0为隐藏，正直为显示数字
        }
    } else {
        for (HETabbarItem *item in _items) {
             item.bridgeNum = @"0";
        }
    }
    
}

#pragma mark - 监听

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CLog(@"\n");
    CLog(@"%@", keyPath);
    CLog(@"%@", object);
    CLog(@"%@", change);
}

#pragma mark - Setter
- (void)setTabHeight:(CGFloat)tabHeight
{
    if (tabHeight != 49) {
        _tabHeight = tabHeight;
        if (self.cusTabbar) {
            self.cusTabbar.sd_layout.heightIs(tabHeight);
            [self.cusTabbar updateLayout];
        }
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    if (self.cusTabbar) {
        self.cusTabbar.backgroundImage = backgroundImage;
    }
}

/**
 *  重写此方法的作用：保证在 titles 有值时通知给 selectedTitles 也赋值的，防止 selectedTitles 为空
 *  同时，防止在现设置 viewControllers ，后设置 titles 导致 title 不能显示
 */
- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    if (!_selectedTitles || _selectedTitles.count == 0) {
        _selectedTitles = titles;
    }
    
    // 如果 tabbarItem 已经存在，则直接为title赋值
    if (_items) {
        int index = 0;
        for (HETabbarItem *item in _items) {
            
            item.title = (_titles.count >= _items.count) ? _titles[index] : nil;
            
            if (!item.selectedTitle) {
                item.selectedTitle = (_selectedTitles.count >= _items.count) ? _selectedTitles[index] : nil;
            }
            index++;
            item.selected = item.selected;
        }
    }
}

/**
 *  重写此方法的作用：保证在 selectedTitles 有值时 titles 是一定有值的
 *  同时，防止在现设置 viewControllers ，后设置 selectedTitles 导致 selectedTitle 不能显示
 */
- (void)setSelectedTitles:(NSArray *)selectedTitles
{
    _selectedTitles = selectedTitles;
    if (!_titles || _titles.count == 0) {
        _titles = selectedTitles;
    }
    
    // 如果 tabbarItem 已经存在，则直接为 selectedTitle 赋值
    if (_items) {
        int index = 0;
        for (HETabbarItem *item in _items) {
            if (!item.title) {
                item.title = (_titles.count >= _items.count) ? _titles[index] : nil;
            }
            
            item.selectedTitle = (_selectedTitles.count >= _items.count) ? _selectedTitles[index] : nil;
            index++;
            item.selected = item.selected;
        }
    }
}

/**
 *  重写此方法的作用：保证在 images 有值时通知给 selectedImages 也赋值的，防止 selectedImages 为空
 *  同时，防止在现设置 viewControllers ，后设置 images 导致 image 不能显示
 */
- (void)setImages:(NSArray *)images
{
    _images = images;
    if (!_selectedImages || _selectedImages.count == 0) {
        _selectedImages = images;
    }
    
    // 如果 tabbarItem 已经存在，则直接为 images 赋值
    if (_items) {
        int index = 0;
        for (HETabbarItem *item in _items) {
            item.image = (_images.count >= _items.count) ? _images[index] : nil;
            
            if (!item.selectedImage) {
                item.selectedImage = (_selectedImages.count >= _items.count) ? _selectedImages[index] : nil;
            }
            index++;
            item.selected = item.selected;
        }
    }

}

/**
 *  重写此方法的作用：保证在 selectedImages 有值时 images 是一定有值的
 *  同时，防止在现设置 viewControllers ，后设置 selectedImages 导致 selectedImage 不能显示
 */
- (void)setSelectedImages:(NSArray *)selectedImages
{
    _selectedImages = selectedImages;
    if (!_images || _images.count == 0) {
        _images = selectedImages;
    }
    
    // 如果 tabbarItem 已经存在，则直接为 selectedImage 赋值
    if (_items) {
        int index = 0;
        for (HETabbarItem *item in _items) {
            if (!item.image) {
                item.image = (_images.count >= _items.count) ? _images[index] : nil;
            }
            
            item.selectedImage = (_selectedImages.count >= _items.count) ? _selectedImages[index] : nil;
            index++;
            item.selected = item.selected;
        }
    }
}

/**
 *  重写此方法的作用：保证在 color 有值时通知给 selectedColor 也赋值的，防止 selectedColor 为空
 *  同时，防止在现设置 viewControllers ，后设置 color 导致 color 不能显示
 */
- (void)setColor:(UIColor *)color
{
    _color = color;
    if (!_selectedColor) {
        _selectedColor = color;
    }
    
    // 如果 tabbarItem 已经存在，则直接为 color 赋值
    if (_items) {
        int index = 0;
        for (HETabbarItem *item in _items) {
            item.color = color;
            
            if (!item.selectedColor) {
                item.selectedColor = _selectedColor;
            }
            
            index++;
            item.selected = item.selected;
        }
    }

}

/**
 *  重写此方法的作用：保证在 selectedColor 有值时 color 是一定有值的
 *  同时，防止在现设置 viewControllers ，后设置 color 导致 color 不能显示
 */
- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    if (!_color) {
        _color = selectedColor;
    }
    
    // 如果 tabbarItem 已经存在，则直接为 selectedColor 赋值
    if (_items) {
        int index = 0;
        for (HETabbarItem *item in _items) {
            if (!item.color) {
                item.color = _color;
            }
            
            item.selectedColor = _selectedColor;
            
            index++;
            item.selected = item.selected;
        }
    }

}

/**
 *  重写 setViewControllers 方法，添加创建 item 的功能
 */
- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    [super setViewControllers:viewControllers];
    
    if (viewControllers.count == 0) {
        return;
    }
    
    if (!_items) {
        _items = [NSMutableArray array];
    } else if (_items.count != 0) {
        return;   // 保证一个 tabbarController 只能设置一次 viewControllers
    }
    
    // 根据 viewController 创建 tabbarItem ，在此处不做数量上的限制，但，由于宽度限制，最好不要超过5个
    UIView *lastView = nil;
    for (int i = 0; i < viewControllers.count; i++) {
        
        HETabbarItem *oneItem = [[HETabbarItem alloc] init];

        oneItem.title = (_titles && _titles.count >= viewControllers.count) ? _titles[i] : nil;
        oneItem.selectedTitle = (_selectedTitles && _selectedTitles.count >= viewControllers.count) ? _titles[i] : nil;
        oneItem.color = (_color) ?: [UIColor grayColor];
        oneItem.selectedColor = (_selectedColor) ?: [UIColor blackColor];
        
        oneItem.image = (_images && _images.count >= viewControllers.count) ? _images[i] : nil;
        oneItem.selectedImage = (_selectedImages && _selectedImages.count >= viewControllers.count) ? _selectedImages[i] : nil;
       
        oneItem.selected = NO;
        oneItem.backgroundColor = [UIColor redColor];
        [oneItem addTarget:self action:@selector(clickTabbarItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.cusTabbar addSubview:oneItem];
        
        oneItem.sd_layout
        .leftSpaceToView(lastView ?: self.cusTabbar, 0)
        .topEqualToView(self.cusTabbar)
        .bottomEqualToView(self.cusTabbar);
        
        lastView = nil;
        lastView = oneItem;
        [_items addObject:oneItem];
    }
    lastView = nil;
    [self.cusTabbar setSd_equalWidthSubviews:_items];

    // 默认：选中 ‘selectedIndex’ 个
    [self clickTabbarItem:[_items objectAtIndex:self.selectedIndex]];
}

- (void)clickTabbarItem:(HETabbarItem *)sender
{
    if (sender == _curItem) {
        // 如果点击‘item‘的是当前的’item‘，则不切换页面，但是可以做其他的操作，比如：调用刷新接口等
        if (self.clickCurrentItem) {
            self.clickCurrentItem(self.selectedIndex);
        }
        return;
    }

    self.selectedIndex = [_items indexOfObject:sender];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    if (_items && _items.count - 1 >= selectedIndex) {
        _preItem = _curItem;  // 记录上一个选中的item
        _preItem.selected = NO;
        _curItem = [_items objectAtIndex:selectedIndex];   // 记录当前的item
        _curItem.selected = YES;
    }
}

/**
 *  切换 tab 上的 image，也可设置角标等
 */
- (void)exchangeNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage atIndex:(int)index
{
    if (index > _items.count - 1) {
        return;
    }
    HETabbarItem *item = [_items objectAtIndex:index];
    item.image = normalImage;
    item.selectedImage = highlightImage;
    item.selected = item.selected;
}

#pragma makr - 隐藏和显示
- (void)showTabbar {
    
    if (!isHiden) {
        return;
    }
    
    [UIView animateWithDuration:0.35 animations:^{

        self.cusTabbar.y = SCREEN_HEIGHT - self.tabHeight;
        
    } completion:^(BOOL finished) {
        isHiden = NO;
    }];
    
}

- (void)hidenTabbar {
    if (isHiden) {
        return;
    }
    [UIView animateWithDuration:0.35 animations:^{
        
        self.cusTabbar.y = SCREEN_HEIGHT;
        
    } completion:^(BOOL finished) {
        isHiden = YES;
    }];
}


@end

#pragma mark - 类 HETabbar
/**
 *  自定义tabbar
 */

@implementation HETabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void) safeAreaInsetsDidChange
{
    [super safeAreaInsetsDidChange];
    if(self.oldSafeAreaInsets.left != self.safeAreaInsets.left ||
       self.oldSafeAreaInsets.right != self.safeAreaInsets.right ||
       self.oldSafeAreaInsets.top != self.safeAreaInsets.top ||
       self.oldSafeAreaInsets.bottom != self.safeAreaInsets.bottom)
    {
        self.oldSafeAreaInsets = self.safeAreaInsets;
        [self invalidateIntrinsicContentSize];
        [self.superview setNeedsLayout];
        [self.superview layoutSubviews];
    }
    
}

- (CGSize) sizeThatFits:(CGSize) size
{
    CGSize s = [super sizeThatFits:size];
    if(@available(iOS 11.0, *))
    {
        CGFloat bottomInset = self.safeAreaInsets.bottom;
        if( bottomInset > 0 && s.height < 50) {
            s.height += bottomInset;
        }
    }
    return s;
}



- (void)setup
{
    _imageView = [UIImageView createImageViewWithImageName:nil superView:self];
    _imageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    _line = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) bgColor:UIColorWithRGBHex(0xeeeeee) alpha:1 superView:self];
}

// 显示阴影
- (void)setShowShadow:(BOOL)showShadow
{
    _showShadow = showShadow;
    if (showShadow) {
        [self shadowRadius:3 shadowOffset:CGSizeMake(0, -1) shadowOpacity:0.5 shadowColor:[UIColor blackColor]];
        
    } else {
        self.layer.shadowOpacity = 0;
    }
}

// 显示不底部线
- (void)setShowLine:(BOOL)showLine
{
    _showLine = showLine;
    _line.hidden = !_showLine;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    _imageView.image = backgroundImage;
}


@end



#pragma mark - 类 HETabbarItem
/**
 *  自定义tabbarItem
 */
@implementation HETabbarItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _font = _selectedFont = [UIFont fontScaleByDevice:11];
        _imageView = [UIImageView createImageViewWithImageName:nil superView:self];
        _imageView.userInteractionEnabled = NO;
        
        _titleLabel = [UILabel createLabelWithFont:[UIFont fontScaleByDevice:11] text:nil superView:self];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 气泡
        _bubbleView = [[HEBubbleView alloc] init];
        [self addSubview:_bubbleView];
         _bubbleView.num = @"0";
        _bubbleView.sd_layout.topSpaceToView(self, kDeviceScaleFactor(5)).rightSpaceToView(self, kDeviceScaleFactor(10));
        
        // 适配
        _imageView.sd_layout
        .centerYEqualToView(self).offset(kDeviceScaleFactor(-8))
        .centerXEqualToView(self);
        
        _titleLabel.sd_layout
        .bottomSpaceToView(self, kDeviceScaleFactor(5))
        .centerXEqualToView(self)
        .widthRatioToView(self, 1)
        .autoHeightRatio(0);
        
        [_titleLabel setMaxNumberOfLinesToShow:1];
        
    }
    return self;
}

#pragma mark - Setter

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {  // 选中
        _titleLabel.text = _selectedTitle ?: _title;
        _titleLabel.textColor = _selectedColor ?: _color;
        _titleLabel.font = _selectedFont ?: _font;
        
        _imageView.image = _selectedImage ?: _image;
        
    } else {  // 正常
        
        _titleLabel.text = _title;
        _titleLabel.textColor = _color;
        _titleLabel.font = _font;
        
        _imageView.image = _image;
    }
    
    _imageView.sd_layout.widthIs(_imageView.image.size.width).heightIs(_imageView.image.size.height);
    [_imageView updateLayout];

}

- (void)setBridgeNum:(NSString *)bridgeNum
{
    _bridgeNum = bridgeNum;
    _bubbleView.num = bridgeNum;
    if (bridgeNum.intValue < 0) {
        _bubbleView.sd_layout.topSpaceToView(self, kDeviceScaleFactor(7)).rightSpaceToView(self, kDeviceScaleFactor(25));
    }
    [_bubbleView updateLayout];
}

@end





