//
//  MJSimilarMoviesCollectionViewCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJSimilarMoviesCollectionViewCell.h"

@implementation MJSimilarMoviesCollectionViewCell

+ (MJSimilarMoviesCollectionViewCell*)similarMoviesCollectionViewCell
{
    MJSimilarMoviesCollectionViewCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"MJSimilarMoviesCollectionViewCell" owner:self options:nil] objectAtIndex:0];
    return cell;
}

- (void)awakeFromNib
{
    // Initialization code
    self.cellImageView.layer.cornerRadius = self.cellImageView.frame.size.width / 2;
    self.cellImageView.layer.masksToBounds = YES;
    self.cellBackgroundView.layer.cornerRadius = self.cellBackgroundView.frame.size.width / 2;
    self.cellBackgroundView.layer.masksToBounds = YES;
    self.cellBackgroundView.layer.borderColor = [UIColor colorWithRed:0 / 255.0 green:161 / 225.0 blue:0 / 255.0 alpha:1.0].CGColor;
    self.cellBackgroundView.layer.borderWidth = 1.0f;
}

@end
