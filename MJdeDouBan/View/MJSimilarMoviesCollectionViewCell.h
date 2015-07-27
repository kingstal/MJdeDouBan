//
//  MJSimilarMoviesCollectionViewCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJMovie.h"

@interface MJSimilarMoviesCollectionViewCell : UICollectionViewCell

+ (void)registerNibWithCollection:(UICollectionView*)collection;
+ (MJSimilarMoviesCollectionViewCell*)cellWithCollectionView:(UICollectionView*)collectionView forIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, strong) MJMovie* movie;
@end
