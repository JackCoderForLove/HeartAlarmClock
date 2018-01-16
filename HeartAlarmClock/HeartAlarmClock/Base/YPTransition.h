//
//  YPTransition.h
//  NewBodivis
//
//  Created by 岳堑途 on 2017/12/8.
//  Copyright © 2017年 weixhe. All rights reserved.
//


@interface YPTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign) BOOL isPush;//是否是push，反之则是pop

@property (nonatomic, assign) NSTimeInterval animationDuration;//动画时长

@end
