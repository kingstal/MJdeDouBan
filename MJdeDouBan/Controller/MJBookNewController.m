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

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSArray* books;

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
    if ([segue.identifier isEqualToString:@"BookDetail"]) {
        MJBookDetailController* controller = segue.destinationViewController;
        controller.bookId = [[self.books objectAtIndex:[self.tableView indexPathForSelectedRow].row] bookId];
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
                //                [self.networkLoadingViewController showNoContentView];
            }
            else {
                self.books = temp;
                [self hideLoadingView];
                [self.tableView reloadData];
            }
        }
        failure:^(MJHTTPFetcher* fetcher, NSError* error){
            //            [self.networkLoadingViewController showErrorView];
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
    BookNewListCell* cell = [BookNewListCell cellWithTableView:tableView];
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
