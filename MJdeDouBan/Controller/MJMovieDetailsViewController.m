//
//  KMMovieDetailsViewController.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/11.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieDetailsViewController.h"
#import "MJNetworkLoadingViewController.h"
#import "MJHTTPFetcher.h"
#import "MJMovieDetailCell.h"
#import "MJMovieDescriptionCell.h"
#import "MJMovieCommentCell.h"
#import "MJMovieViewAllCommentsCell.h"
#import "MJSimilarMoviesCell.h"
#import "MJMovieDirectorCell.h"
#import "MJSimilarMoviesCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "MJReview.h"
#import "MJRefresh.h"
#import "StoryBoardUtilities.h"
#import "MJSimilarMoviesViewController.h"

static NSInteger const REVIEWLIMIT = 10;

@interface MJMovieDetailsViewController ()

@property (nonatomic, strong) MJNetworkLoadingViewController* networkLoadingViewController;
@property (assign) CGPoint scrollViewDragPoint;
@property (nonatomic) NSInteger currentReviewIndex;

@end

@implementation MJMovieDetailsViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    //添加上拉刷新
    __weak __typeof(self) weakSelf = self;
    self.detailsPageView.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"共有%@条影评", self.movie.reviewCount);
        NSLog(@"当前有%lu条影评,正请求%lu 条影评", (unsigned long)[self.movie.reviews count], _currentReviewIndex);
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

    //    self.navigationController.fd_prefersNavigationBarHidden = YES;
    // Do any additional setup after loading the view.
    [self registerNib];
    [self setupDetailsPageView];
    [self requestMovieDetails];
}

- (NSInteger)currentReviewIndex
{
    if (!_currentReviewIndex) {
        _currentReviewIndex = 0;
    }
    return _currentReviewIndex;
}

- (void)dealloc
{
    [[MJHTTPFetcher sharedFetcher] cancel];
}

#pragma mark - setup

- (void)registerNib
{
    UINib* detailNib = [UINib nibWithNibName:@"MJMovieDetailCell" bundle:nil];
    [self.detailsPageView.tableView registerNib:detailNib forCellReuseIdentifier:@"MJMovieDetailCell"];

    UINib* descriptionNib = [UINib nibWithNibName:@"MJMovieDescriptionCell" bundle:nil];
    [self.detailsPageView.tableView registerNib:descriptionNib forCellReuseIdentifier:@"MJMovieDescriptionCell"];

    UINib* similarMoviesNib = [UINib nibWithNibName:@"MJSimilarMoviesCell" bundle:nil];
    [self.detailsPageView.tableView registerNib:similarMoviesNib forCellReuseIdentifier:@"MJSimilarMoviesCell"];

    UINib* directorNib = [UINib nibWithNibName:@"MJMovieDirectorCell" bundle:nil];
    [self.detailsPageView.tableView registerNib:directorNib forCellReuseIdentifier:@"MJMovieDirectorCell"];

    UINib* commentNib = [UINib nibWithNibName:@"MJMovieCommentCell" bundle:nil];
    [self.detailsPageView.tableView registerNib:commentNib forCellReuseIdentifier:@"MJMovieCommentCell"];

    //    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)setupDetailsPageView
{
    self.detailsPageView.tableViewDataSource = self;
    self.detailsPageView.tableViewDelegate = self;
    self.detailsPageView.delegate = self;
    self.detailsPageView.tableViewSeparatorColor = [UIColor clearColor];

    self.detailsPageView.navBarView = [self.navigationController navigationBar];
}

#pragma mark - Network Requests methods
- (void)requestMovieDetails
{
    [[MJHTTPFetcher sharedFetcher] fetchMovieDetailWithMovie:self.movie
        success:^(MJHTTPFetcher* fetcher, id data) {
            self.movie = (MJMovie*)data;
            //            NSLog(@"MovieDetail:%@", self.movie);
            if (self.movie) {

                [self.detailsPageView reloadData];

                //第一次请求影评
                [self requestMovieReviewsStartWithIndex:self.currentReviewIndex];

                [self hideLoadingView];
            }
        }
        failure:^(MJHTTPFetcher* fetcher, NSError* error) {
            [self.networkLoadingViewController showErrorView];
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

#pragma mark - MJNetworkLoadingViewController Methods
- (void)hideLoadingView
{
    [UIView transitionWithView:self.view
        duration:0.3f
        options:UIViewAnimationOptionTransitionCrossDissolve
        animations:^(void) {
            [self.networkLoadingContainerView removeFromSuperview];
        }
        completion:^(BOOL finished) {
            [self.networkLoadingViewController removeFromParentViewController];
            self.networkLoadingContainerView = nil;
        }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MJNetworkLoadingViewController"]) {
        self.networkLoadingViewController = segue.destinationViewController;
        self.networkLoadingViewController.delegate = self;
    }
}

#pragma mark - Action Methods

- (IBAction)popViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO: 增加类似电影
- (void)viewAllSimilarMoviesButtonPressed:(id)sender
{
    MJSimilarMoviesViewController* viewController = (MJSimilarMoviesViewController*)[StoryBoardUtilities viewControllerForStoryboardName:@"Main" class:[MJSimilarMoviesViewController class]];
    viewController.similarMovies = self.movie.similarMovies;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4 + [self.movie.reviews count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = nil;

    switch (indexPath.row) {
    case 0: {
        MJMovieDetailCell* detailsCell = [tableView dequeueReusableCellWithIdentifier:@"MJMovieDetailCell"];

        [detailsCell.posterImageView sd_setImageWithURL:[NSURL URLWithString:self.movie.moviePosterUrl]];
        detailsCell.starRatingView.value = [self.movie.movieScore floatValue] / 10.0f;
        detailsCell.scoreLabel.text = self.movie.movieScore;
        detailsCell.voteCountLabel.text = [NSString stringWithFormat:@"%@人评价", self.movie.movieVoteCount];
        detailsCell.genresLabel.text = self.movie.movieGenre;
        detailsCell.regionDurationLabel.text = [NSString stringWithFormat:@"%@/%@", self.movie.movieRegion, self.movie.movieDuration];
        detailsCell.releaseDateLabel.text = self.movie.movieReleaseDate;

        cell = detailsCell;
    } break;
    case 1: {
        MJMovieDirectorCell* directorCell = [tableView dequeueReusableCellWithIdentifier:@"MJMovieDirectorCell"];

        directorCell.directorLabel.text = self.movie.movieDirector;
        directorCell.actorLabel.text = self.movie.movieActor;

        cell = directorCell;

    } break;
    case 2: {
        MJMovieDescriptionCell* descriptionCell = [tableView dequeueReusableCellWithIdentifier:@"MJMovieDescriptionCell"];

        descriptionCell.movieSummaryLabel.text = self.movie.movieSummary;

        cell = descriptionCell;
    } break;
    case 3: {
        MJSimilarMoviesCell* similarMoviesCell = [tableView dequeueReusableCellWithIdentifier:@"MJSimilarMoviesCell"];

        [similarMoviesCell.viewAllSimilarMoviesButton addTarget:self action:@selector(viewAllSimilarMoviesButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

        cell = similarMoviesCell;
    } break;
    default: {
        MJMovieCommentCell* commentCell = [tableView dequeueReusableCellWithIdentifier:@"MJMovieCommentCell"];

        MJReview* review = (MJReview*)[self.movie.reviews objectAtIndex:indexPath.row - 4];
        [commentCell.cellImageView sd_setImageWithURL:[NSURL URLWithString:[review avatarUrl]]];
        commentCell.titleLabel.text = review.title;
        commentCell.usernameLabel.text = review.username;
        commentCell.timeLabel.text = review.commnetTime;
        commentCell.scoreStarsView.value = [review.score floatValue] / 5;
        commentCell.commentLabel.text = review.content;
        commentCell.percentUseLabel.text = [NSString stringWithFormat:@"%@有用", review.percentUse];

        cell = commentCell;
    } break;
    }

    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    cell.contentView.backgroundColor = [UIColor clearColor];

    // 为MJSimilarMoviesCell的 collectionView 设置 delegate
    if ([cell isKindOfClass:[MJSimilarMoviesCell class]]) {
        MJSimilarMoviesCell* similarMovieCell = (MJSimilarMoviesCell*)cell;
        [similarMovieCell setCollectionViewDataSourceDelegate:self index:indexPath.row];
    }
}

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
                                                 [(MJMovieDirectorCell*)cell directorLabel].text = self.movie.movieDirector;
                                                 [(MJMovieDirectorCell*)cell actorLabel].text = self.movie.movieActor;
                                             }];
    }
    else if (indexPath.row == 2) {
        height = [tableView fd_heightForCellWithIdentifier:@"MJMovieDescriptionCell"
                                          cacheByIndexPath:indexPath
                                             configuration:^(id cell) {
                                                 [(MJMovieDescriptionCell*)cell movieSummaryLabel].text = self.movie.movieSummary;
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
                                                 [commentCell.imageView sd_setImageWithURL:[NSURL URLWithString:[review avatarUrl]]];
                                                 commentCell.titleLabel.text = review.title;
                                                 commentCell.usernameLabel.text = review.username;
                                                 commentCell.timeLabel.text = review.commnetTime;
                                                 commentCell.scoreStarsView.value = [review.score floatValue];
                                                 commentCell.commentLabel.text = review.content;
                                                 commentCell.percentUseLabel.text = review.percentUse;

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
    MJSimilarMoviesCollectionViewCell* cell = (MJSimilarMoviesCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"MJSimilarMoviesCollectionViewCell" forIndexPath:indexPath];

    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:[(MJMovie*)[self.movie.similarMovies objectAtIndex:indexPath.row] moviePosterUrl]]];
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

#pragma mark MJDetailsPageDelegate

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
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];

    NSLog(@"navigationBar did set!");
}

#pragma mark KMNetworkLoadingViewDelegate

- (void)retryRequest;
{
    [self requestMovieDetails];
}

@end
