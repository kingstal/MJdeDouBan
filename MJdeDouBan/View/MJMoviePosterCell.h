//
//  MJMoviePosterCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/19.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJMovie.h"

@interface MJMoviePosterCell : UICollectionViewCell

@property (strong, nonatomic) MJMovie* movie;

+ (void)registerNibWithCollection:(UICollectionView*)collection;
+ (MJMoviePosterCell*)cellWithCollectionView:(UICollectionView*)collectionView forIndexPath:(NSIndexPath*)indexPath;
@end
