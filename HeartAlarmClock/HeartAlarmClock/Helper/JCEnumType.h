//
//  JCEnumType.h
//  NewBodivis
//
//  Created by xingjian on 2017/12/26.
//  Copyright © 2017年 weixhe. All rights reserved.
//

#ifndef JCEnumType_h
#define JCEnumType_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger,JCTrendDateType)
{
    /**
     * 周
     */
    JCTrendDateTypeWeek = 0,
    /**
     * 月
     */
    JCTrendDateTypeMonth ,

    /**
     * 季
     */
    JCTrendDateTypeSeason ,

    /**
     * 年
     */
    JCTrendDateTypeYear

    
};
typedef NS_ENUM(NSInteger,JCTrendHealthType)
{
    /**
     * 体重
     */
    JCTrendHealthTypeWeigth = 0,
    /**
     * 脂肪量
     */
    JCTrendHealthTypeFat ,
    
    /**
     * 体脂率
     */
    JCTrendHealthTypeBodyFatRate ,
    /**
     * 肌肉量
     */
    JCTrendHealthTypeMuscleMass ,
    
    /**
     * 水分
     */
    JCTrendHealthTypeMoisture ,

    /**
     * 骨质
     */
    JCTrendHealthTypeBone

};
typedef NS_ENUM (NSInteger,JCTrendDescType)
{
    /**
     * 最高
     */
    JCTrendDescTypeTheHighest = 0,
    /**
     * 最低
     */
    JCTrendDescTypeMonthTheMinimum ,
    
    /**
     * 平均
     */
    JCTrendDescTypeOnAverage,
    
    /**
     * 变化量
     */
    JCTrendDescTypeChangeTheAmount
    
    
};
typedef NS_ENUM (NSInteger,JCTrendHisTogramType)
{
    /**
     * 趋势图柱状图Item没数据
     */
    JCTrendHisTogramTypeNoData = 0,
    /**
     * 趋势图柱状图Item历史数据
     */
    JCTrendHisTogramTypeHistoryData,
    
    /**
     * 趋势图柱状图Item最新数据
     */
    JCTrendHisTogramTypeNewData
    
    
};

typedef NS_ENUM (NSInteger,JCTrendCircleType)
{
    /**
     * 实心圆
     */
    JCTrendCircleTypeSolidRound = 0,
    /**
     * 空心圆
     */
    JCTrendCircleTypeHollowCircle

};

typedef NS_ENUM (NSInteger,JCUnitType)
{
    /**
     * kg
     */
    JCUnitTypeKG = 0,
    /**
     * 磅
     */
    JCUnitTypeLB = 1,
    /**
     * 斤
     */
    JCUnitTypeJIN = 2

};
typedef NS_ENUM (NSInteger,JCAbnormalType)
{
    /**
     * 系统崩溃啦
     */
    JCAbnormalTypeSystemError = 0,
    /**
     * 没网络
     */
    JCAbnormalTypeNoNetWork = 1,
    
};

#endif /* JCEnumType_h */
