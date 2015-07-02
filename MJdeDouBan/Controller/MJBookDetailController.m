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

@property (nonatomic, strong) MJBookDetail* bookDetail;
@property (nonatomic, strong) MJNetworkLoadingViewController* networkLoadingViewController;
@end

@implementation MJBookDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //    self.tableView.sectionHeaderHeight = 20;
    [self.tableView registerNib:[UINib nibWithNibName:@"BookDetailFirstCell" bundle:nil] forCellReuseIdentifier:@"BookDetailFirstCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BookDetailSecondCell" bundle:nil] forCellReuseIdentifier:@"BookDetailSecondCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BookDetailAuthorSummaryCell" bundle:nil] forCellReuseIdentifier:@"BookDetailAuthorSummaryCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BookDetailSummaryCell" bundle:nil] forCellReuseIdentifier:@"BookDetailSummaryCell"];

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
        failure:^(MJHTTPFetcher* fetcher, NSError* error) {
            [self.networkLoadingViewController showErrorView];
        }];
}

#pragma mark KMNetworkLoadingViewDelegate

- (void)retryRequest;
{
    [self requestBookDetails];
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

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MJNetworkLoadingViewController"]) {
        self.networkLoadingViewController = segue.destinationViewController;
        self.networkLoadingViewController.delegate = self;
    }
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
        BookDetailFirstCell* firstCell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailFirstCell"];

        [firstCell.posterImageView sd_setImageWithURL:[NSURL URLWithString:self.bookDetail.bookPosterUrl]];
        [firstCell.titleLabel setText:self.bookDetail.bookTitle];
        NSString* score = self.bookDetail.bookScore;
        firstCell.scoreStarView.value = [score floatValue] / 10;
        [firstCell.scoreLabel setText:score];
        [firstCell.voteCountLabel setText:[NSString stringWithFormat:@"(%@人评价)", self.bookDetail.bookVoteCount]];
        [firstCell.authorLabel setText:self.bookDetail.bookAuthor];
        [firstCell.publishLabel setText:self.bookDetail.bookPress];

        cell = firstCell;
    }
    else if (indexPath.section == 1) {
        BookDetailSecondCell* secondCell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailSecondCell"];

        [secondCell.authorDetailLabel setText:self.bookDetail.bookAuthor];
        [secondCell.publishDetailLabel setText:self.bookDetail.bookPress];
        [secondCell.publishTimeLabel setText:self.bookDetail.bookPublishTime];
        [secondCell.pageCountLabel setText:self.bookDetail.bookPageCount];
        [secondCell.priceLabel setText:self.bookDetail.bookPrice];
        [secondCell.ISBNLabel setText:self.bookDetail.bookISBN];

        cell = secondCell;
    }

    if (indexPath.section == 2) {
        BookDetailSummaryCell* summaryCell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailSummaryCell"];
        [summaryCell.bookSummaryLabel setText:self.bookDetail.bookSummary];

        cell = summaryCell;
    }
    else if (indexPath.section == 3) {
        BookDetailAuthorSummaryCell* authorCell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailAuthorSummaryCell"];
        [authorCell.authorSummaryLabel setText:self.bookDetail.bookAuthorSummary];

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
                                                 [(BookDetailSummaryCell*)cell bookSummaryLabel].text = self.bookDetail.bookSummary;
                                             }];
    }
    else if (indexPath.section == 3) {
        height = [tableView fd_heightForCellWithIdentifier:@"BookDetailAuthorSummaryCell"
                                          cacheByIndexPath:indexPath
                                             configuration:^(id cell) {
                                                 [(BookDetailAuthorSummaryCell*)cell authorSummaryLabel].text = self.bookDetail.bookAuthorSummary;
                                             }];
    }
    return height;
}

@end
