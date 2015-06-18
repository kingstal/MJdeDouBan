//
//  ScoreStarsView.m
//  ScoreStarsDemo
//
//  Created by 彭显鹤 on 15/5/22.
//  Copyright (c) 2015年 pengxianhe. All rights reserved.
//

#import "ScoreStarsView.h"
#import "ScoreStarsKit.h"

@implementation ScoreStarsView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //重新export之后，scorestarskit 代码就变化了，所以创建方式也要修改
    [ScoreStarsKit drawScoreStarsCanvasWithFrame:rect frontColor:self.frontColor fillColor:self.fillColor backColor:self.backColor value:self.value];
}

- (void)setValue:(CGFloat)value {
    if (value > 1.0) {
        value = 1.0;
    } else if (value < 0) {
        value = 0;
    }
    _value = value;
    [self setNeedsDisplay];
}
@end
