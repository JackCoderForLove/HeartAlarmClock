//
//  MainTabBarController.h
//  NewBodivis
//
//  Created by 岳堑途 on 2017/11/21.
//  Copyright © 2017年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 底部 TabBar 控制器
 */
@interface MainTabBarController : UITabBarController

/**
 设置小红点
 
 @param index tabbar下标
 @param isShow 是显示还是隐藏
 */
-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow;

@end

