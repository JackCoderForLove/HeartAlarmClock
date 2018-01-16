//
//  UICollectionView+Extension.m
//  JRB
//
//  Created by 岳堑途 on 16/5/11.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "UICollectionView+Extension.h"
#import "TKHeaderView.h"
#import "TKFooterView.h"

@implementation UICollectionView (Extension)

- (void)refreshing:(Refreshing)refreshing
{
    self.mj_header = [TKHeaderView headerWithRefreshingBlock:^{
        if (refreshing) {
            refreshing();
        }
    }];
    [self.mj_header beginRefreshing];
}

- (void)loading:(Loading)loading
{
    self.mj_footer = [TKFooterView footerWithRefreshingBlock:^{
        if (loading) {
            loading();
        }
    }];
}

- (void)endRefreshing
{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
        
    } else {
        [self.mj_footer endRefreshing];
    }
}

- (void)noMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}


@end
