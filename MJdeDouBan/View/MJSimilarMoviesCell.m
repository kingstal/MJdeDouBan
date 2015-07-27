//
//  MJMovieSimilarMoviesCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJSimilarMoviesCell.h"
#import "MJSimilarMoviesCollectionViewCell.h"

@interface MJSimilarMoviesCell ()

@property (weak, nonatomic) IBOutlet UICollectionView* collectionView;
@property (weak, nonatomic) IBOutlet UIButton* viewAllSimilarMoviesButton;
- (IBAction)buttonPressed:(id)sender;

@end

@implementation MJSimilarMoviesCell

+ (void)registerNibWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"MJSimilarMoviesCell";
    UINib* directorNib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:directorNib forCellReuseIdentifier:ID];
}

+ (MJSimilarMoviesCell*)cellWithTableView:(UITableView*)tableView
{
    NSString* ID = @"MJSimilarMoviesCell";
    MJSimilarMoviesCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate
{

    [MJSimilarMoviesCollectionViewCell registerNibWithCollection:self.collectionView];

    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;

    [self.collectionView reloadData];
}
- (IBAction)buttonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(similarMoviesCellButtonPressed:)]) {
        [self.delegate similarMoviesCellButtonPressed:self];
    }
}
@end
