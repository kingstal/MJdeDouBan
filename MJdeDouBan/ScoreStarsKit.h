//
//  ScoreStarsKit.h
//  ScoreStarsDemo
//
//  Created by pengxianhe on 15/5/23.
//  Copyright (c) 2015 CompanyName. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ScoreStarsKit : NSObject

// Drawing Methods
+ (void)drawStarWithFrontColor: (UIColor*)frontColor;
+ (void)drawScoreStarsCanvasWithFrame: (CGRect)frame frontColor: (UIColor*)frontColor fillColor: (UIColor*)fillColor backColor: (UIColor*)backColor value: (CGFloat)value;

@end
