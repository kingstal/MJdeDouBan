//
//  MJSimilarMoviesCollectionViewCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJSimilarMoviesCollectionViewCell : UICollectionViewCell

+ (MJSimilarMoviesCollectionViewCell*)similarMoviesCollectionViewCell;

@property (weak, nonatomic) IBOutlet UIImageView* cellImageView;
@property (weak, nonatomic) IBOutlet UIView* cellBackgroundView;

@end
