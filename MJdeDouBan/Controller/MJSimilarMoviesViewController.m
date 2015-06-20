//
//  MJSimilarMoviesViewController.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/19.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJSimilarMoviesViewController.h"
#import "StoryBoardUtilities.h"
#import "MJMovie.h"
#import "MJMovieDetailsViewController.h"
#import "MJMoviePosterCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MMPlaceHolder.h>

#define kVerticalMarginForCollectionViewItems 0

@implementation MJSimilarMoviesViewController

- (void)awakeFromNib
{
    if (!self.similarMovies)
        self.similarMovies = [[NSArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setupCollectionViewLayout];
}

#pragma mark - CollectionView Layout

- (void)setupCollectionViewLayout
{
    UICollectionViewFlowLayout* interfaceBuilderFlowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;

    CGSize viewSize = self.view.bounds.size;

    CGFloat cellAspectRatio = interfaceBuilderFlowLayout.itemSize.height / interfaceBuilderFlowLayout.itemSize.width;

    UICollectionViewFlowLayout* flowLayoutPort = UICollectionViewFlowLayout.new;

    flowLayoutPort.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayoutPort.sectionInset = interfaceBuilderFlowLayout.sectionInset;
    flowLayoutPort.minimumInteritemSpacing = interfaceBuilderFlowLayout.minimumInteritemSpacing;
    flowLayoutPort.minimumLineSpacing = interfaceBuilderFlowLayout.minimumLineSpacing;

    if (floor(viewSize.width / interfaceBuilderFlowLayout.itemSize.width) >= 2) {

        CGFloat itemHeight = (viewSize.width / 2.0 - kVerticalMarginForCollectionViewItems) * cellAspectRatio;

        flowLayoutPort.itemSize = CGSizeMake(viewSize.width / 2.0 - kVerticalMarginForCollectionViewItems, itemHeight);
    }
    else {

        CGFloat itemHeight = (viewSize.height / 2.0 - kVerticalMarginForCollectionViewItems) * cellAspectRatio;

        flowLayoutPort.itemSize = CGSizeMake(viewSize.height / 2.0 - kVerticalMarginForCollectionViewItems, itemHeight);
    }
    //    CGFloat itemHeight = (viewSize.width / 2.0 - kVerticalMarginForCollectionViewItems) * cellAspectRatio;
    //
    //    flowLayoutPort.itemSize = CGSizeMake(viewSize.width / 2.0 - kVerticalMarginForCollectionViewItems, itemHeight);

    [self.collectionView setCollectionViewLayout:flowLayoutPort];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [self.similarMovies count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath;
{
    MJMoviePosterCell* cell = (MJMoviePosterCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"MJMoviePosterCell" forIndexPath:indexPath];
    [cell.moviePosterImageView showPlaceHolderWithLineColor:[UIColor redColor]];
    [cell.moviePosterImageView sd_setImageWithURL:[NSURL URLWithString:[[self.similarMovies objectAtIndex:indexPath.row] moviePosterUrl]]];
    return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath;
{
    MJMovieDetailsViewController* viewController = (MJMovieDetailsViewController*)[StoryBoardUtilities viewControllerForStoryboardName:@"Main" class:[MJMovieDetailsViewController class]];
    viewController.movie = [self.similarMovies objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
