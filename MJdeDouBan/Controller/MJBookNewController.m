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
#import "MJBookDetailController.h"
#import "MJLoadingView.h"

@interface MJBookNewController ()

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic, weak) MJLoadingView* loadingView;

@property (nonatomic, strong) NSArray* books;

@end

@implementation MJBookNewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showLoadingView];
    [self requestBookNew];
}

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
                [self.loadingView hideLoadingView];
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
    BookNewListCell* cell = [BookNewListCell cellWithTableView:tableView];
    cell.book = self.books[indexPath.row];
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
