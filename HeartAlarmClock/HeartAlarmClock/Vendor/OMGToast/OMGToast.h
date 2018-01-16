//
//  OMGToast.h
//  Tencent
//
//  Created by MagicStudio on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.

//类似于android的TToast控件

//用法：
//[OMGToast showWithText:@"中间显示" duration:5];  
//[OMGToast showWithText:@"距离上方50像素" topOffset:50 duration:5];  
//[OMGToast showWithText:@"文字很多的时候，我就会自动折行，最大宽度280像素" topOffset:100 duration:5];  
//[OMGToast showWithText:@"加入\\n也可以\n显示\n多\n行" topOffset:300 duration:5];  
//[OMGToast showWithText:@"距离下方3像素" bottomOffset:3 duration:5]; 

//

//#import <Foundation/Foundation.h>
//#import <UIkit/UIKit.h>
#define DEFAULT_DISPLAY_DURATION 1.5f  

@interface OMGToast : NSObject {  
    NSString *_text;  
    UIButton *_contentView;  
    CGFloat  _duration;  
}  
+ (void)showWithText:(NSString *) text_;  
+ (void)showWithText:(NSString *) text_  
            duration:(CGFloat)duration_;  

+ (void)showWithText:(NSString *) text_  
           topOffset:(CGFloat) topOffset_;  
+ (void)showWithText:(NSString *) text_  
           topOffset:(CGFloat) topOffset  
            duration:(CGFloat) duration_;
+ (void)showWithText:(NSString *) text_  
        bottomOffset:(CGFloat) bottomOffset_;  
+ (void)showWithText:(NSString *) text_  
        bottomOffset:(CGFloat) bottomOffset_  
            duration:(CGFloat) duration_;

- (void)showWithText:(NSString *)text_
                   topOffset:(CGFloat)topOffset_
                    duration:(CGFloat)duration_;

- (void)hideWithText;

@end  
