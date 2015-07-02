//
//  MJBookTop250.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/23.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJBookTop250Controller.h"
#import "MJHTTPFetcher.h"
#import "BookTop250ListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MJRefresh.h"
#import "MJBookDetailController.h"

const static NSInteger BOOKTOP250 = 250;

@interface MJBookTop250Controller ()
@property (nonatomic, strong) NSMutableArray* books;
@property (nonatomic, strong) MJNetworkLoadingViewController* networkLoadingViewController;

@property (nonatomic, strong) NSIndexPath* selectedIndexPath;
@property (nonatomic) NSInteger startIndex;

@end

@implementation MJBookTop250Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self setupTableView];
    //self.fd_interactivePopDisabled = YES;

    self.startIndex = 0;

    [self requestBookTop250];

    //    添加上拉刷新
    __weak __typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"正请求%lu 条影评", (long)_startIndex);
        if (self.startIndex == 0 || [self.books count] < BOOKTOP250) {
            // 进入刷新状态后会自动调用这个block
            [weakSelf requestBookTop250];
            // 结束刷新
            [weakSelf.tableView.footer endRefreshing];
        }
        else {
            [self.tableView.footer noticeNoMoreData];
        }
    }];
}

- (NSMutableArray*)books
{
    if (!_books) {
        _books = [NSMutableArray new];
    }
    return _books;
}

- (void)dealloc
{
    [[MJHTTPFetcher sharedFetcher] cancel];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"MJNetworkLoadingViewController"]) {
        self.networkLoadingViewController = segue.destinationViewController;
        self.networkLoadingViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"BookDetail"]) {
        MJBookDetailController* controller = segue.destinationViewController;
        controller.bookId = [[self.books objectAtIndex:self.selectedIndexPath.row] bookId];
    }
}

#pragma mark - Network Requests methods

- (void)requestBookTop250
{
    [[MJHTTPFetcher sharedFetcher] fetchBookTop250WithStart:self.startIndex
        success:^(MJHTTPFetcher* fetcher, id data) {
            NSArray* temp = (NSArray*)data;
            if ([temp count] == 0) {
                [self.networkLoadingViewController showNoContentView];
            }
            else {
                [self.books addObjectsFromArray:temp];
                self.startIndex = [self.books count];
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
    [self requestBookTop250];
}

#pragma mark UITableViewSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.books count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    BookTop250ListCell* cell = (BookTop250ListCell*)[tableView dequeueReusableCellWithIdentifier:@"BookTop250ListCell" forIndexPath:indexPath];

    [cell.posterImageView sd_setImageWithURL:[self.books[indexPath.row] valueForKey:@"bookPosterUrl"] placeholderImage:nil];
    [cell.titleLabel setText:[self.books[indexPath.row] valueForKey:@"bookTitle"]];
    [cell.titleEngLabel setText:[self.books[indexPath.row] valueForKey:@"bookTitleEng"]];
    [cell.subTitleLabel setText:[self.books[indexPath.row] valueForKey:@"bookSubTitle"]];

    NSString* score = [self.books[indexPath.row] valueForKey:@"bookScore"];
    cell.scoreStarsView.value = [score floatValue] / 10;
    [cell.scoreLabel setText:score];
    [cell.votecountLabel setText:[NSString stringWithFormat:@"(%@人评价)", [self.books[indexPath.row] valueForKey:@"bookVoteCount"]]];
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
