//
//  EvaluateRemindModel.h
//  NewBodivis
//
//  Created by 李策 on 2018/1/7.
//  Copyright © 2018年 weixhe. All rights reserved.
//  评测提醒Model

#import <Foundation/Foundation.h>

@interface EvaluateRemindModel : NSObject
@property(nonatomic,strong)NSString *evaluateRemindId;//主键
@property(nonatomic,strong)NSString *remindContent;//提醒内容
@property(nonatomic,strong)NSArray *remindDate;//提醒日期数组
@property(nonatomic,strong)NSString *remindTime;//提醒时间
@property(nonatomic,assign)NSInteger status;//状态 0：开 1：关
@property(nonatomic,strong)NSString *soundName;//响铃声音
@end
