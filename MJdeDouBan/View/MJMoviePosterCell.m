//
//  MJMoviePosterCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/19.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMoviePosterCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MJMoviePosterCell ()
@property (weak, nonatomic) IBOutlet UIImageView* moviePosterImageView;
@end

@implementation MJMoviePosterCell

+ (void)registerNibWithCollection:(UICollectionView*)collectionView
{
    static NSString* ID = @"MJMoviePosterCell";
    UINib* nib = [UINib nibWithNibName:ID bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
}

+ (MJMoviePosterCell*)cellWithCollectionView:(UICollectionView*)collectionView forIndexPath:(NSIndexPath*)indexPath
{
    static NSString* ID = @"MJMoviePosterCell";
    MJMoviePosterCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return cell;
}

- (void)setMovie:(MJMovie*)movie
{
    _movie = movie;
    [self.moviePosterImageView sd_setImageWithURL:[NSURL URLWithString:[movie moviePosterUrl]]];
}
@end
