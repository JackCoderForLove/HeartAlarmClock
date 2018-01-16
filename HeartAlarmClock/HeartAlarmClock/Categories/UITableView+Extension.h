//
//  UITableView+Extension.h
//  JRB
//
//  Created by weixhe on 16/5/6.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Refreshing) (void);
typedef void (^Loading) (void);

@interface UITableView (Extension)

- (void)refreshing:(Refreshing)refresh;
- (void)endRefreshing;

- (void)loading:(Loading)load;
- (void)noMoreData;

@end
