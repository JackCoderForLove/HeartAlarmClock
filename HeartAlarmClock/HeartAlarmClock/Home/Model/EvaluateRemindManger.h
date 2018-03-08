//  EvaluateRemindManger.h
//  HeartAlarmClock
/**
 * ━━━━━━神兽出没━━━━━━
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛Code is far away from bug with the animal protecting
 * 　　　　┃　　　┃    神兽保佑,代码无bug
 * 　　　　┃　　　┃
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 *
 * ━━━━━━感觉萌萌哒━━━━━━
 */
//  Created by xingjian on 2018/1/24.
//  Copyright © 2018年 xingjian. All rights reserved.杰克
//  @class EvaluateRemindManger
//  @abstract <#类的描述#>
//  @discussion <#类的功能#>
//

#import <Foundation/Foundation.h>
@class EvaluateRemindModel;
@interface EvaluateRemindManger : NSObject
+(EvaluateRemindManger *)shareManger;
//获取所有数据
- (NSMutableArray *)jcAllData;
- (EvaluateRemindModel *)jcgetDataForKey:(NSString *)key;
//保存单条数据
- (void)saveDataWithModel:(EvaluateRemindModel *)model;
//删除单条数据
- (void)deleteDatawithKey:(NSString *)key;
//通过model删除数据
- (void)deleteDataWithModel:(EvaluateRemindModel *)model;
//删除所有数据
- (void)deleteAllData;
@end
