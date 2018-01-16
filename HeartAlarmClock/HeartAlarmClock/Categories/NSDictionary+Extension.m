//
//  NSDictionary+Extension.m
//  JRB
//
//  Created by weixhe on 16/5/4.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (BOOL)containKey:(NSString *)key
{
    return [[self allKeys] containsObject:key];
}

- (BOOL)containValue:(NSString *)value
{
    return [[self allValues] containsObject:value];
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
