//
//  MJComingSoonMovieMasterViewController.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/17.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJComingSoonMovieMasterViewController.h"
#import "MJNetworkLoadingViewController.h"
#import "MJMovieDetailsViewController.h"
#import "MJHTTPFetcher.h"
#import "MJMovieListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MJComingSoonMovieListCell.h"

@interface MJComingSoonMovieMasterViewController ()

@property (nonatomic, strong) NSArray* comingSoonMovies;
@property (nonatomic, strong) MJNetworkLoadingViewController* networkLoadingViewController;

@property (nonatomic, strong) NSIndexPath* selectedIndexPath;

@end

@implementation MJComingSoonMovieMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestComingSoonMovies];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MJNetworkLoadingViewController"]) {
        self.networkLoadingViewController = segue.destinationViewController;
        self.networkLoadingViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"MovieDetail"]) {
        MJMovieDetailsViewController* controller = segue.destinationViewController;
        controller.movie = [self.comingSoonMovies objectAtIndex:self.selectedIndexPath.row];
    }
}

#pragma mark - Network Requests methods

//- (void)refreshFeed
//{
//    [self requestHotMovies];
//}

- (void)requestComingSoonMovies
{
    [[MJHTTPFetcher sharedFetcher] fetchComingSoonMovieWithCity:@"nanjing"
        success:^(MJHTTPFetcher* fetcher, id data) {
            self.comingSoonMovies = (NSArray*)data;
            //            NSLog(@"movieArray: %@", self.hotMovies);
            if ([self.comingSoonMovies count] == 0) {
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
    [self requestComingSoonMovies];
}

#pragma mark UITableViewSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.comingSoonMovies count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MJComingSoonMovieListCell* cell = (MJComingSoonMovieListCell*)[tableView dequeueReusableCellWithIdentifier:@"MJComingSoonMovieCell" forIndexPath:indexPath];

    [cell.posterImageView sd_setImageWithURL:[self.comingSoonMovies[indexPath.row] valueForKey:@"moviePosterUrl"] placeholderImage:nil];
    [cell.titleLabel setText:[self.comingSoonMovies[indexPath.row] valueForKey:@"movieTitle"]];
    [cell.dateLabel setText:[self.comingSoonMovies[indexPath.row] valueForKey:@"movieReleaseDate"]];
    [cell.genreLabel setText:[self.comingSoonMovies[indexPath.row] valueForKey:@"movieGenre"]];
    [cell.regionLabel setText:[self.comingSoonMovies[indexPath.row] valueForKey:@"movieRegion"]];
    [cell.peopleWantSeeLabel setText:[self.comingSoonMovies[indexPath.row] valueForKey:@"moviePeopleLike"]];
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
