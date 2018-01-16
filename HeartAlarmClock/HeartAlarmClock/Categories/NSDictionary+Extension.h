//
//  NSDictionary+Extension.h
//  JRB
//
//  Created by weixhe on 16/5/4.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)


- (BOOL)containKey:(NSString *)key;
- (BOOL)containValue:(NSString *)value;
//字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
