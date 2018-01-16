//
//  NSObject+Extension.m
//  HE
//
//  Created by weixhe on 16/7/13.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (BOOL)isNull
{
    return [self isKindOfClass:[NSNull class]];
}

@end
