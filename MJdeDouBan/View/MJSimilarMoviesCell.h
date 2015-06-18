//
//  MJMovieSimilarMoviesCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJIndexedCollectionView.h"

@interface MJSimilarMoviesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MJIndexedCollectionView* collectionView;
@property (weak, nonatomic) IBOutlet UIButton* viewAllSimilarMoviesButton;

+ (MJSimilarMoviesCell*)similarMoviesCell;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index;
@end
