//
//  MJBookDetailController.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/25.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJBookDetailController.h"
#import "MJHTTPFetcher.h"
#import "MJBookDetail.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BookDetailAuthorSummaryCell.h"
#import "BookDetailSummaryCell.h"
#import "BookDetailFirstCell.h"
#import "BookDetailSecondCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface MJBookDetailController ()

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic, strong) MJBookDetail* bookDetail;

@end

@implementation MJBookDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [BookDetailFirstCell registerNibWithTableView:self.tableView];
    [BookDetailSecondCell registerNibWithTableView:self.tableView];
    [BookDetailAuthorSummaryCell registerNibWithTableView:self.tableView];
    [BookDetailSummaryCell registerNibWithTableView:self.tableView];

    [self requestBookDetails];
}

- (void)dealloc
{
    [[MJHTTPFetcher sharedFetcher] cancel];
}

- (void)requestBookDetails
{
    [[MJHTTPFetcher sharedFetcher] fetchBookDetailWithBookId:self.bookId
        success:^(MJHTTPFetcher* fetcher, id data) {
            self.bookDetail = (MJBookDetail*)data;
            //            NSLog(@"MovieDetail:%@", self.movie);
            if (self.bookDetail) {
                [self hideLoadingView];
                [self.tableView reloadData];
            }
        }
        failure:^(MJHTTPFetcher* fetcher, NSError* error){
            //            [self.networkLoadingViewController showErrorView];
        }];
}

#pragma mark - MJNetworkLoadingViewController Methods
- (void)hideLoadingView
{
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

#pragma mark - UITableViewDatasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = nil;

    if (indexPath.section == 0) {
        BookDetailFirstCell* firstCell = [BookDetailFirstCell cellWithTableView:tableView];
        firstCell.bookDetail = self.bookDetail;
        cell = firstCell;
    }
    else if (indexPath.section == 1) {
        BookDetailSecondCell* secondCell = [BookDetailSecondCell cellWithTableView:tableView];
        secondCell.bookDetail = self.bookDetail;
        cell = secondCell;
    }

    if (indexPath.section == 2) {
        BookDetailSummaryCell* summaryCell = [BookDetailSummaryCell cellWithTableView:tableView];
        summaryCell.bookDetail = self.bookDetail;
        cell = summaryCell;
    }
    else if (indexPath.section == 3) {
        BookDetailAuthorSummaryCell* authorCell = [BookDetailAuthorSummaryCell cellWithTableView:tableView];
        authorCell.bookDetail = self.bookDetail;
        cell = authorCell;
    }

    return cell;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* title = @"";
    if (section == 1) {
        title = @"图书详情";
    }
    else if (section == 2) {
        title = @"内容详情";
    }
    else if (section == 3) {
        title = @"作者详情";
    }
    return title;
}

/**
 *  使用UITableView+FDTemplateLayoutCell自动计算 tableViewCell 的高度
 */
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    CGFloat height = 0;

    if (indexPath.section == 0) {
        height = 116;
    }
    else if (indexPath.section == 1) {
        height = 126;
    }
    else if (indexPath.section == 2) {
        height = [tableView fd_heightForCellWithIdentifier:@"BookDetailSummaryCell"
                                          cacheByIndexPath:indexPath
                                             configuration:^(id cell) {
                                                 BookDetailSummaryCell* summaryCell = (BookDetailSummaryCell*)cell;
                                                 summaryCell.bookDetail = self.bookDetail;
                                             }];
    }
    else if (indexPath.section == 3) {
        height = [tableView fd_heightForCellWithIdentifier:@"BookDetailAuthorSummaryCell"
                                          cacheByIndexPath:indexPath
                                             configuration:^(id cell) {
                                                 BookDetailAuthorSummaryCell* authorCell = (BookDetailAuthorSummaryCell*)cell;
                                                 authorCell.bookDetail = self.bookDetail;
                                             }];
    }
    return height;
}

@end
