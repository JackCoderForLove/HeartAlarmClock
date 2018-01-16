//
//  UICollectionView+Extension.h
//  JRB
//
//  Created by 岳堑途 on 16/5/11.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^Refreshing) (void);
typedef void (^Loading) (void);

@interface UICollectionView (Extension)

- (void)refreshing:(Refreshing)refresh;
- (void)endRefreshing;

- (void)loading:(Loading)load;
- (void)noMoreData;

@end
