//  JCShareView.h
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
//  @class JCShareView
//  @abstract <#类的描述#>
//  @discussion <#类的功能#>
//

#import <UIKit/UIKit.h>
@protocol ShareDelegate <NSObject>

-(void)shareWithType:(NSString *)type;

@end
@interface JCShareView : UIView

@property(nonatomic, assign)id<ShareDelegate> delegate;
@property(nonatomic, strong)UIView *shareView;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, assign)NSInteger jcType;//0代表其他  1代表文章 没有保存到本地按钮

//显示
-(void)show;
//隐藏
-(void)hide;

@end
