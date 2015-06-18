//
//  MJMovieMasterViewController.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/10.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieMasterViewController.h"
#import "MJHTTPFetcher.h"
#import "MJMovieListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MJMovieDetailsViewController.h"

//#import <UINavigationController+FDFullscreenPopGesture.h>

@interface MJMovieMasterViewController ()
@property (nonatomic, strong) NSArray* hotMovies;
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (nonatomic, strong) MJNetworkLoadingViewController* networkLoadingViewController;

@property (nonatomic, strong) NSIndexPath* selectedIndexPath;

@end

@implementation MJMovieMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self setupTableView];
    //self.fd_interactivePopDisabled = YES;
    [self requestHotMovies];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    //    [self.navigationController navigationBar].alpha = 1.0;
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         [self.navigationController navigationBar].alpha = 1.0;
//                     }];
//    NSLog(@"MJMovieMasterViewController did appear!");
//}

#pragma mark - Setup Methods

//- (void)setupTableView
//{
//    if (!_refreshControl) {
//        _refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -44, [[UIScreen mainScreen] bounds].size.width, 44)];
//        [self.refreshControl addTarget:self action:@selector(refreshFeed) forControlEvents:UIControlEventValueChanged];
//        [self.tableView addSubview:self.refreshControl];
//    }
//}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"MJNetworkLoadingViewController"]) {
        self.networkLoadingViewController = segue.destinationViewController;
        self.networkLoadingViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"MovieDetail"]) {
        MJMovieDetailsViewController* controller = segue.destinationViewController;
        controller.movie = [self.hotMovies objectAtIndex:self.selectedIndexPath.row];
    }
}

#pragma mark - Network Requests methods

//- (void)refreshFeed
//{
//    [self requestHotMovies];
//}

- (void)requestHotMovies
{
    [[MJHTTPFetcher sharedFetcher] fetchHotMovieWithCity:@"nanjing"
        success:^(MJHTTPFetcher* fetcher, id data) {
            self.hotMovies = (NSArray*)data;
            //            NSLog(@"movieArray: %@", self.hotMovies);
            if ([self.hotMovies count] == 0) {
                [self.networkLoadingViewController showNoContentView];
            }
            else {
                [self hideLoadingView];
                [self.tableView reloadData];
            }
        }
        failure:^(MJHTTPFetcher* fetcher, NSError* error) {
            [self.networkLoadingViewController showErrorView];
        }];
}

#pragma mark - MJNetworkLoadingViewDelegate

- (void)retryRequest;
{
    [self requestHotMovies];
}

#pragma mark UITableViewSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.hotMovies count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MJMovieListCell* cell = (MJMovieListCell*)[tableView dequeueReusableCellWithIdentifier:@"MJMovieListCell" forIndexPath:indexPath];

    [cell.posterImageView sd_setImageWithURL:[self.hotMovies[indexPath.row] valueForKey:@"moviePosterUrl"] placeholderImage:nil];
    [cell.titleLabel setText:[self.hotMovies[indexPath.row] valueForKey:@"movieTitle"]];
    [cell.votecountLabel setText:[NSString stringWithFormat:@"%@人评价", [self.hotMovies[indexPath.row] valueForKey:@"movieVoteCount"]]];
    [cell.scoreLabel setText:[NSString stringWithFormat:@"%@分", [self.hotMovies[indexPath.row] valueForKey:@"movieScore"]]];
    [cell.durationLabel setText:[self.hotMovies[indexPath.row] valueForKey:@"movieDuration"]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSIndexPath*)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    self.selectedIndexPath = indexPath;
    return indexPath;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MJNetworkLoadingViewController Methods
- (void)hideLoadingView
{
    NSLog(@"remove loadingView");
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
@end
