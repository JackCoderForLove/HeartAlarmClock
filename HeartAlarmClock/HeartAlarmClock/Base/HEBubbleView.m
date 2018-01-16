//
//  HEBubbleView.m
//  HE
//
//  Created by weixhe on 14/7/13.
//  Copyright © 2014年 weixhe. All rights reserved.
//

#import "HEBubbleView.h"

@interface HEBubbleView ()

@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation HEBubbleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.sd_cornerRadiusFromHeightRatio = @0.5;
        
        _numLabel = [UILabel createLabelWithFont:[UIFont fontScaleByDevice:10] text:@"8" superView:self];
        _numLabel.backgroundColor = [UIColor clearColor];
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(-1, 0, 0, 0));
    }
    return self;
}


- (void)setNum:(NSString *)num
{
    
    if (num.intValue < 0) {             // 显示“点”
        self.sd_layout.widthIs(kDeviceScaleFactor(6)).heightEqualToWidth();
        _numLabel.text = nil;
        
    } else if (num.intValue == 0) {     // 不显示
        self.sd_layout.widthIs(0).heightIs(0);
        _numLabel.text = nil;
        
    } else if (num.intValue < 10) {     // 1~9
        self.sd_layout.widthIs(kDeviceScaleFactor(14)).heightEqualToWidth();
        _numLabel.text = num;
        
    } else if (num.intValue < 100) {    // 10~99
        self.sd_layout.widthIs(kDeviceScaleFactor(20)).heightIs(kDeviceScaleFactor(14));
        _numLabel.text = num;
        
    } else {        // 99+
        self.sd_layout.widthIs(kDeviceScaleFactor(30)).heightIs(kDeviceScaleFactor(14));
        _numLabel.text = @" 99+";
    }
    [self updateLayout];
}

@end
