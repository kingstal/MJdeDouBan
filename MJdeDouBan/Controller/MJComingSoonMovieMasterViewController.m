//
//  MJComingSoonMovieMasterViewController.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/17.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJComingSoonMovieMasterViewController.h"
#import "MJMovieDetailsViewController.h"
#import "MJHTTPFetcher.h"
#import "MJMovieListCell.h"
#import "MJComingSoonMovieListCell.h"
#import "FeThreeDotGlow.h"
#import "MJLoadingView.h"

@import UIKit;

@interface MJComingSoonMovieMasterViewController () <MJComingSoonMovieListCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSArray* comingSoonMovies;

@property (nonatomic, weak) MJLoadingView* loadingView;

@end

@implementation MJComingSoonMovieMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showLoadingView];
    [self requestComingSoonMovies];
}

- (void)dealloc
{
    [[MJHTTPFetcher sharedFetcher] cancel];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MovieDetail"]) {
        MJMovieDetailsViewController* controller = segue.destinationViewController;
        controller.movie = [self.comingSoonMovies objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

#pragma mark - Network Requests methods

- (void)requestComingSoonMovies
{
    [[MJHTTPFetcher sharedFetcher] fetchComingSoonMovieWithCity:@"nanjing"
        success:^(MJHTTPFetcher* fetcher, id data) {
            self.comingSoonMovies = (NSArray*)data;
            if ([self.comingSoonMovies count] == 0) {
                //                [self.networkLoadingViewController showNoContentView];
            }
            else {
                [self.loadingView hideLoadingView];
                [self.tableView reloadData];
            }
        }
        failure:^(MJHTTPFetcher* fetcher, NSError* error){
            //            [self.networkLoadingViewController showErrorView];
        }];
}

#pragma mark - MJComingSoonMovieListCellDelegate
- (void)comingSoonMovieListCellBtnPressed:(MJComingSoonMovieListCell*)cell;
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:cell.movie.movieTrailerUrl]];
}

#pragma mark UITableViewSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.comingSoonMovies count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MJComingSoonMovieListCell* cell = [MJComingSoonMovieListCell cellWithTableView:tableView];
    cell.movie = self.comingSoonMovies[indexPath.row];
    cell.deleaget = self;
    return cell;
}

#pragma mark - LoadingView
- (void)showLoadingView
{
    MJLoadingView* loadingView = [[MJLoadingView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:loadingView];
    self.loadingView = loadingView;
}

@end
