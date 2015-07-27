//
//  MJSimilarMoviesCollectionViewCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJSimilarMoviesCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MJSimilarMoviesCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView* cellImageView;
@property (weak, nonatomic) IBOutlet UIView* cellBackgroundView;

@end

@implementation MJSimilarMoviesCollectionViewCell

+ (void)registerNibWithCollection:(UICollectionView*)collectionView
{
    static NSString* ID = @"MJSimilarMoviesCollectionViewCell";
    UINib* nib = [UINib nibWithNibName:ID bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
}

+ (MJSimilarMoviesCollectionViewCell*)cellWithCollectionView:(UICollectionView*)collectionView forIndexPath:(NSIndexPath*)indexPath
{
    static NSString* ID = @"MJSimilarMoviesCollectionViewCell";
    MJSimilarMoviesCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return cell;
}

- (void)setMovie:(MJMovie*)movie
{
    _movie = movie;
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:[movie moviePosterUrl]]];
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
