//
//  BaseWebViewController.h
//  App
//
//  Created by weixhe on 16/4/27.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseWebViewController : UIViewController

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *navTitle;

- (instancetype)initWithUrl:(NSString *)url navTitle:(NSString *)title;
@end
