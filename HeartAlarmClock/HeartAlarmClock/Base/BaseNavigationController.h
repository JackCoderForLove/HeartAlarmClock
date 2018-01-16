//
//  BaseNavigationController.h
//  App
//
//  Created by weixhe on 16/4/18.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBar.h"

@interface BaseNavigationController : UINavigationController

// 自定义Nav Bar
@property (nonatomic, strong) NavigationBar *navigationBarSelf;

/*
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

@end
