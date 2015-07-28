//
//  MJMovieDetailsViewController.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/11.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieDetailsViewController.h"
#import "MJHTTPFetcher.h"
#import "StoryBoardUtilities.h"

#import "MJMovieDetailCell.h"
#import "MJMovieDescriptionCell.h"
#import "MJMovieCommentCell.h"
#import "MJMovieViewAllCommentsCell.h"
#import "MJSimilarMoviesCell.h"
#import "MJMovieDirectorCell.h"

#import "MJSimilarMoviesCollectionViewCell.h"
#import "MJSimilarMoviesViewController.h"

#import <UITableView+FDTemplateLayoutCell.h>
#import <UINavigationController+FDFullscreenPopGesture.h>

#import "MJReview.h"
#import "MJRefresh.h"

#import "MJLoadingView.h"

static NSInteger const REVIEWLIMIT = 10;

@interface MJMovieDetailsViewController () <MJSimilarMoviesCellDelegate>

@property (assign) CGPoint scrollViewDragPoint;
@property (nonatomic, assign) NSInteger currentReviewIndex;

@property (weak, nonatomic) IBOutlet MJDetailsPageView* detailsPageView;
@property (nonatomic, weak) MJLoadingView* loadingView;

@end

@implementation MJMovieDetailsViewController

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 隐藏 TabBar
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;

    //添加上拉刷新
    __weak __typeof(self) weakSelf = self;
    self.detailsPageView.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"共有%@条影评", self.movie.reviewCount);
        NSLog(@"当前有%lu条影评,正请求%lu 条影评", (unsigned long)[self.movie.reviews count], (long)_currentReviewIndex);
        if (self.currentReviewIndex == 0 || [self.movie.reviews count] < [self.movie.reviewCount integerValue]) {
            // 进入刷新状态后会自动调用这个block
            [weakSelf requestMovieReviewsStartWithIndex:self.currentReviewIndex];
            // 结束刷新
            [weakSelf.detailsPageView.tableView.footer endRefreshing];
        }
        else {
            [self.detailsPageView.tableView.footer noticeNoMoreData];
        }
    }];

    [self registerNib];
    [self setupDetailsPageView];

    [self showLoadingView];
    [self requestMovieDetails];
}

- (void)dealloc
{
    [[MJHTTPFetcher sharedFetcher] cancel];
}

#pragma mark - Setup

- (void)registerNib
{
    [MJMovieDetailCell registerNibWithTableView:self.detailsPageView.tableView];
    [MJMovieDescriptionCell registerNibWithTableView:self.detailsPageView.tableView];
    [MJSimilarMoviesCell registerNibWithTableView:self.detailsPageView.tableView];
    [MJMovieDirectorCell registerNibWithTableView:self.detailsPageView.tableView];
    [MJMovieCommentCell registerNibWithTableView:self.detailsPageView.tableView];
}

- (void)setupDetailsPageView
{
    self.detailsPageView.tableViewDataSource = self;
    self.detailsPageView.tableViewDelegate = self;
    self.detailsPageView.delegate = self;
    self.detailsPageView.tableViewSeparatorColor = [UIColor clearColor];

    self.detailsPageView.navBarView = [self.navigationController navigationBar];
}

#pragma mark - LoadingView
- (void)showLoadingView
{
    MJLoadingView* loadingView = [[MJLoadingView alloc] initWithFrame:self.view.frame];
    [self.detailsPageView addSubview:loadingView];
    [self.detailsPageView bringSubviewToFront:loadingView];
    self.loadingView = loadingView;
}

#pragma mark - Network Request
- (void)requestMovieDetails
{
    [[MJHTTPFetcher sharedFetcher] fetchMovieDetailWithMovie:self.movie
        success:^(MJHTTPFetcher* fetcher, id data) {
            self.movie = (MJMovie*)data;
            if (self.movie) {
                [self.detailsPageView reloadData];
                //第一次请求影评
                [self requestMovieReviewsStartWithIndex:self.currentReviewIndex];

                [self.loadingView hideLoadingView];
            }
        }
        failure:^(MJHTTPFetcher* fetcher, NSError* error){
            //            [self.networkLoadingViewController showErrorView];
        }];
}

- (void)requestMovieReviewsStartWithIndex:(NSInteger)startIndex
{
    [[MJHTTPFetcher sharedFetcher] fetchMovieReviewWithMovie:self.movie
        start:startIndex
        limit:REVIEWLIMIT
        success:^(MJHTTPFetcher* fetcher, id data) {
            if (self.movie.reviews) {
                self.currentReviewIndex = [self.movie.reviews count] + 1;
                [self.detailsPageView reloadData];
            }
        }
        failure:^(MJHTTPFetcher* fetcher, NSError* error){
            // 没有拿到 reviews
        }];
}

#pragma mark - Action

- (void)similarMoviesCellButtonPressed:(MJSimilarMoviesCell*)cell;
{
    MJSimilarMoviesViewController* viewController = (MJSimilarMoviesViewController*)[StoryBoardUtilities viewControllerForStoryboardName:@"Main" class:[MJSimilarMoviesViewController class]];
    viewController.similarMovies = self.movie.similarMovies;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4 + [self.movie.reviews count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = nil;

    switch (indexPath.row) {
    case 0: {
        MJMovieDetailCell* detailsCell = [MJMovieDetailCell cellWithTableView:tableView];
        detailsCell.movie = self.movie;
        cell = detailsCell;
    } break;
    case 1: {
        MJMovieDirectorCell* directorCell = [MJMovieDirectorCell cellWithTableView:tableView];
        directorCell.movie = self.movie;
        cell = directorCell;

    } break;
    case 2: {
        MJMovieDescriptionCell* descriptionCell = [MJMovieDescriptionCell cellWithTableView:tableView];
        descriptionCell.movie = self.movie;
        cell = descriptionCell;
    } break;
    case 3: {
        MJSimilarMoviesCell* similarMoviesCell = [MJSimilarMoviesCell cellWithTableView:tableView];
        similarMoviesCell.delegate = self;
        [similarMoviesCell setCollectionViewDataSourceDelegate:self];
        cell = similarMoviesCell;
    } break;
    default: {
        MJMovieCommentCell* commentCell = [MJMovieCommentCell cellWithTableView:tableView];
        MJReview* review = (MJReview*)[self.movie.reviews objectAtIndex:indexPath.row - 4];
        commentCell.review = review;
        cell = commentCell;
    } break;
    }

    return cell;
}

#pragma mark - UITableView Delegate

/**
 *  使用UITableView+FDTemplateLayoutCell自动计算 tableViewCell 的高度
 */
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    CGFloat height = 0;

    if (indexPath.row == 0) {
        height = 150;
    }
    else if (indexPath.row == 1) {
        height = [tableView fd_heightForCellWithIdentifier:@"MJMovieDirectorCell"
                                          cacheByIndexPath:indexPath
                                             configuration:^(id cell) {
                                                 MJMovieDirectorCell* dcell = cell;
                                                 dcell.movie = self.movie;
                                             }];
    }
    else if (indexPath.row == 2) {
        height = [tableView fd_heightForCellWithIdentifier:@"MJMovieDescriptionCell"
                                          cacheByIndexPath:indexPath
                                             configuration:^(id cell) {
                                                 MJMovieDescriptionCell* dcell = (MJMovieDescriptionCell*)cell;
                                                 dcell.movie = self.movie;
                                             }];
    }
    else if (indexPath.row == 3) {
        height = 150;
    }
    else {
        height = [tableView fd_heightForCellWithIdentifier:@"MJMovieCommentCell"
                                          cacheByIndexPath:indexPath
                                             configuration:^(id cell) {
                                                 MJReview* review = (MJReview*)[self.movie.reviews objectAtIndex:indexPath.row - 4];
                                                 MJMovieCommentCell* commentCell = (MJMovieCommentCell*)cell;
                                                 commentCell.review = review;
                                             }];
    }
    return height;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.movie.similarMovies count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    MJSimilarMoviesCollectionViewCell* cell = [MJSimilarMoviesCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.movie = [self.movie.similarMovies objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    MJMovieDetailsViewController* viewController = (MJMovieDetailsViewController*)[StoryBoardUtilities viewControllerForStoryboardName:@"Main" class:[MJMovieDetailsViewController class]];
    ;
    viewController.movie = [self.movie.similarMovies objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - MJDetailsPage Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    self.scrollViewDragPoint = scrollView.contentOffset;
}

- (CGPoint)detailsPage:(MJDetailsPageView*)detailsPageView tableViewWillBeginDragging:(UITableView*)tableView;
{
    return self.scrollViewDragPoint;
}

- (UIViewContentMode)contentModeForImage:(UIImageView*)imageView
{
    return UIViewContentModeTop;
}

/**
 *  设置 DetailsPageView 中 的 headerImageView
 */
- (UIImageView*)detailsPage:(MJDetailsPageView*)detailsPageView imageDataForImageView:(UIImageView*)imageView;
{
    __block UIImageView* blockImageView = imageView;

    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.movie moviePosterUrl]]
                        completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL* imageURL) {
                            if ([detailsPageView.delegate respondsToSelector:@selector(headerImageViewFinishedLoading:)])
                                [detailsPageView.delegate headerImageViewFinishedLoading:blockImageView];
                        }];
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    return imageView;
}

- (void)detailsPage:(MJDetailsPageView*)detailsPageView tableViewDidLoad:(UITableView*)tableView
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)detailsPage:(MJDetailsPageView*)detailsPageView headerViewDidLoad:(UIView*)headerView
{
    [headerView setAlpha:0.0];
    [headerView setHidden:YES];
    self.navigationItem.title = self.movie.movieTitle;
}

@end
