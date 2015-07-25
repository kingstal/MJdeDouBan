//
//  MJMovieMasterViewController.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/10.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJHotMovieMasterViewController.h"
#import "MJHTTPFetcher.h"
#import "MJMovieListCell.h"
#import "MJMovieDetailsViewController.h"

#import "MJLoadingView.h"

@interface MJHotMovieMasterViewController ()
@property (nonatomic, strong) NSArray* hotMovies;
@property (weak, nonatomic) IBOutlet UITableView* tableView;

@property (nonatomic, weak) MJLoadingView* loadingView;

@end

@implementation MJHotMovieMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self showLoadingView];

    [self requestHotMovies];
}

- (void)dealloc
{
    [[MJHTTPFetcher sharedFetcher] cancel];
}

#pragma mark - LoadingView
- (void)showLoadingView
{
    MJLoadingView* loadingView = [[MJLoadingView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:loadingView];
    self.loadingView = loadingView;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MovieDetail"]) {
        MJMovieDetailsViewController* controller = segue.destinationViewController;
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        controller.movie = [self.hotMovies objectAtIndex:indexPath.row];
    }
}

#pragma mark - Network Requests methods

- (void)requestHotMovies
{
    [[MJHTTPFetcher sharedFetcher] fetchHotMovieWithCity:@"nanjing"
        success:^(MJHTTPFetcher* fetcher, id data) {
            self.hotMovies = (NSArray*)data;
            if ([self.hotMovies count] == 0) {
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

#pragma mark - UITableViewSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.hotMovies count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MJMovieListCell* cell = [MJMovieListCell cellWithTableView:tableView];
    cell.movie = self.hotMovies[indexPath.row];
    return cell;
}
@end
