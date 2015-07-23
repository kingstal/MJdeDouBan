//
//  MJMovieSimilarMoviesCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJIndexedCollectionView.h"

@class MJSimilarMoviesCell;

@protocol MJSimilarMoviesCellDelegate <NSObject>
@optional
- (void)similarMoviesCellButtonPressed:(MJSimilarMoviesCell*)cell;
@end

@interface MJSimilarMoviesCell : UITableViewCell

@property (weak, nonatomic) id<MJSimilarMoviesCellDelegate> delegate;

+ (void)registerNibWithTableView:(UITableView*)tableView;

+ (MJSimilarMoviesCell*)cellWithTableView:(UITableView*)tableView;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index;
@end
