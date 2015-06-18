//
//  ScoreStarsView.h
//  ScoreStarsDemo
//
//  Created by 彭显鹤 on 15/5/22.
//  Copyright (c) 2015年 pengxianhe. All rights reserved.
//

#import <UIKit/UIKit.h>

//这个可以让这个view 在storyboard中显示了
IB_DESIGNABLE
@interface ScoreStarsView : UIView

@property (strong, nonatomic)IBInspectable UIColor * frontColor;
@property (strong, nonatomic)IBInspectable UIColor * fillColor;
@property (strong, nonatomic)IBInspectable UIColor * backColor;
@property (assign, nonatomic)IBInspectable CGFloat value;

@end
