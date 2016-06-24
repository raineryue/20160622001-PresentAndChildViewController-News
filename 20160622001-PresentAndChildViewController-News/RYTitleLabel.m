//
//  RYTitleLabel.m
//  20160622001-PresentAndChildViewController-News
//
//  Created by Rainer on 16/6/24.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "RYTitleLabel.h"

#define RYRed 0.4
#define RYGreen 0.5
#define RYBlue 0.6

@implementation RYTitleLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor colorWithRed:RYRed green:RYGreen blue:RYBlue alpha:1.0];
        self.font = [UIFont systemFontOfSize:15.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    
    // 文字颜色渐变的规则根据RGB来渐变，如：
    //      R G B
    // 黑色：0 0 0
    // 红色：1 0 0
    // 蓝色：0 0 1
    // 绿色：0 1 0
    
    // 1.渐变左右两边标题标签的颜色:蓝色->黄色
    CGFloat red = RYRed + (1 - RYRed) * scale;
    CGFloat green = RYGreen + (0 - RYGreen) * scale;
    CGFloat blue = RYBlue + (0 - RYBlue) * scale;
    
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // 2.渐变左右两边标题标签的大小
    CGFloat transformScale = 1 + scale * 0.2;// 比例为：[1, 1.2]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

@end
