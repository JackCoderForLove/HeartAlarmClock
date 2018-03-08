//  EvaluateRemindManger.m
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

#import "EvaluateRemindManger.h"
#import <YYKit/YYCache.h>
#import "EvaluateRemindModel.h"

static EvaluateRemindManger *manager = nil;
@interface EvaluateRemindManger()
@property(nonatomic,strong)YYCache *jcCache;
@end

@implementation EvaluateRemindManger
+(EvaluateRemindManger *)shareManger
{
    
    static dispatch_once_t token;
    dispatch_once(&token,^{
        if(manager == nil){
         manager = [[EvaluateRemindManger alloc]init];
        }
    } );
    return manager;
}
//获取所有数据
- (NSMutableArray *)jcAllData
{
    
    NSMutableArray *jcArr = (NSMutableArray *)[self.jcCache objectForKey:JCLocalClockArr];
    if (jcArr == nil) {
        jcArr = [NSMutableArray array];
    }
    return jcArr;
}
//保存单条数据
- (void)saveDataWithModel:(EvaluateRemindModel *)model 
{
    //先获取所有数据
    NSMutableArray *jcAllData = [self jcAllData];
    if (jcAllData == nil) {
        jcAllData = [NSMutableArray array];
    }
    BOOL isContainData = NO;
    NSInteger jcIndex = 0;
    for (int i = 0; i<jcAllData.count; i++) {
        EvaluateRemindModel *abModel = [jcAllData objectAtIndex:i];
        if ([abModel.evaluateRemindId isEqualToString:model.evaluateRemindId]) {
            isContainData = YES;
            jcIndex = i;
            break;
        }
        
    }
    //判断是否包含数据，如果包含数据，则更新数据
    if (isContainData == YES)
    {
        [jcAllData replaceObjectAtIndex:jcIndex withObject:model];
        //保存数据
        [self.jcCache setObject:jcAllData forKey:JCLocalClockArr];
    }
    else
    {
        //如果不包含数据，则添加数据
        [jcAllData addObject:model];
        //保存数据
        [self.jcCache setObject:jcAllData forKey:JCLocalClockArr];
    }

}
//通过model删除数据
- (void)deleteDataWithModel:(EvaluateRemindModel *)model
{
    //先获取所有数据
    NSMutableArray *jcAllData = [self jcAllData];
    if (jcAllData == nil) {
        jcAllData = [NSMutableArray array];
    }
    for (EvaluateRemindModel *abmodel in jcAllData) {
        if ([abmodel.evaluateRemindId isEqualToString:model.evaluateRemindId]) {
            [jcAllData removeObject:abmodel];
            break;
        }
    }
    [self.jcCache setObject:jcAllData forKey:JCLocalClockArr];

}
//删除单条数据
- (void)deleteDatawithKey:(NSString *)key
{
    //先获取所有数据
    NSMutableArray *jcAllData = [self jcAllData];
    if (jcAllData == nil) {
        jcAllData = [NSMutableArray array];
    }
    EvaluateRemindModel *jcModel = nil;
    for (EvaluateRemindModel *model in jcAllData) {
        if ([model.evaluateRemindId isEqualToString:key]) {
            jcModel = model;
            break;
        }
    }
    if (jcModel!=nil) {
        //从数组删除数据
        [jcAllData removeObject:jcModel];
        //重新保存到内存中
        [self.jcCache setObject:jcAllData forKey:JCLocalClockArr];
    }

}
- (EvaluateRemindModel *)jcgetDataForKey:(NSString *)key
{
    //先获取所有数据
    NSMutableArray *jcAllData = [self jcAllData];
    if (jcAllData == nil) {
        jcAllData = [NSMutableArray array];
    }
    EvaluateRemindModel *jcModel = nil;
    for (EvaluateRemindModel *model in jcAllData) {
        if ([model.evaluateRemindId isEqualToString:key]) {
            jcModel = model;
            break;
        }
    }
    return jcModel;
}
//删除所有数据
- (void)deleteAllData
{
    [self.jcCache removeAllObjects];
}
//初始化cache
- (YYCache *)jcCache
{
    if (!_jcCache) {
        
       _jcCache  = [[YYCache alloc]initWithName:JCLocalClockKey];
//        _jcCache  = [YYCache cacheWithName:JCLocalClockKey];
    }
    return _jcCache;
}
@end
