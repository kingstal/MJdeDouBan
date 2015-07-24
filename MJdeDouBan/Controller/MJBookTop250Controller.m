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
#import "MJRefresh.h"
#import "MJBookDetailController.h"

const static NSInteger BOOKTOP250 = 250;

@interface MJBookTop250Controller ()
@property (weak, nonatomic) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* books;

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
    if ([segue.identifier isEqualToString:@"BookDetail"]) {
        MJBookDetailController* controller = segue.destinationViewController;
        controller.bookId = [[self.books objectAtIndex:[self.tableView indexPathForSelectedRow].row] bookId];
    }
}

#pragma mark - Network Requests methods

- (void)requestBookTop250
{
    [[MJHTTPFetcher sharedFetcher] fetchBookTop250WithStart:self.startIndex
        success:^(MJHTTPFetcher* fetcher, id data) {
            NSArray* temp = (NSArray*)data;
            if ([temp count] == 0) {
                //                [self.networkLoadingViewController showNoContentView];
            }
            else {
                [self.books addObjectsFromArray:temp];
                self.startIndex = [self.books count];
                [self hideLoadingView];
                [self.tableView reloadData];
            }
        }
        failure:^(MJHTTPFetcher* fetcher, NSError* error){
            //            [self.networkLoadingViewController showErrorView];
        }];
}

#pragma mark UITableViewSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.books count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    BookTop250ListCell* cell = [BookTop250ListCell cellWithTableView:tableView];

    cell.book = self.books[indexPath.row];
    return cell;
}

#pragma mark - MJNetworkLoadingViewController Methods
- (void)hideLoadingView
{
    NSLog(@"remove loadingView");
    [UIView transitionWithView:self.view
        duration:0.3f
        options:UIViewAnimationOptionTransitionCrossDissolve
        animations:^(void) {
            //            [self.networkLoadingContainerView removeFromSuperview];
        }
        completion:^(BOOL finished){
            //            [self.networkLoadingViewController removeFromParentViewController];
            //            self.networkLoadingContainerView = nil;
        }];
}
@end
