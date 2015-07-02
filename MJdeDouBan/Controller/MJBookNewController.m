//
//  MJBookNewController.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/24.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJBookNewController.h"
#import "MJNetworkLoadingViewController.h"
#import "MJHTTPFetcher.h"
#import "BookNewListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MJBookDetailController.h"

@interface MJBookNewController ()

@property (nonatomic, strong) NSArray* books;
@property (nonatomic, strong) MJNetworkLoadingViewController* networkLoadingViewController;

@property (nonatomic, strong) NSIndexPath* selectedIndexPath;

@end

@implementation MJBookNewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@,---%@", self, self.flag);
    [self requestBookNew];
}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    if (!self.books) {
//        [self.tableView reloadData];
//    }
//}

- (NSArray*)books
{
    if (!_books) {
        _books = [NSArray new];
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

- (void)requestBookNew
{
    [[MJHTTPFetcher sharedFetcher] fetchBookNewWithFlag:self.flag
        success:^(MJHTTPFetcher* fetcher, id data) {
            NSArray* temp = (NSArray*)data;
            NSLog(@"%@", temp);
            if ([temp count] == 0) {
                [self.networkLoadingViewController showNoContentView];
            }
            else {
                self.books = temp;
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
    [self requestBookNew];
}

#pragma mark UITableViewSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.books count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    BookNewListCell* cell = (BookNewListCell*)[tableView dequeueReusableCellWithIdentifier:@"BookNewListCell" forIndexPath:indexPath];

    [cell.posterImageView sd_setImageWithURL:[self.books[indexPath.row] valueForKey:@"bookPosterUrl"] placeholderImage:nil];
    [cell.titleLabel setText:[self.books[indexPath.row] valueForKey:@"bookTitle"]];
    [cell.subTitleLabel setText:[self.books[indexPath.row] valueForKey:@"bookSubTitle"]];

    [cell.summaryLabel setText:[self.books[indexPath.row] valueForKey:@"bookSummary"]];
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
