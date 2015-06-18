//
//  MJMovieSimilarMoviesCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJSimilarMoviesCell.h"

@implementation MJSimilarMoviesCell

+ (MJSimilarMoviesCell*)similarMoviesCell
{
    MJSimilarMoviesCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"MJSimilarMoviesCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index
{
    UINib* nib = [UINib nibWithNibName:@"MJSimilarMoviesCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"MJSimilarMoviesCollectionViewCell"];

    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.index = index;

    [self.collectionView reloadData];
}

@end
