//
//  BookDetailAuthorSummaryCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/25.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "BookDetailAuthorSummaryCell.h"

@interface BookDetailAuthorSummaryCell ()
@property (nonatomic, weak) IBOutlet UILabel* authorSummaryLabel;
@end

@implementation BookDetailAuthorSummaryCell

+ (void)registerNibWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookDetailAuthorSummaryCell";
    UINib* directorNib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:directorNib forCellReuseIdentifier:ID];
}

+ (BookDetailAuthorSummaryCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookDetailAuthorSummaryCell";
    BookDetailAuthorSummaryCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

- (void)setBookDetail:(MJBookDetail*)bookDetail
{
    _bookDetail = bookDetail;
    [self.authorSummaryLabel setText:bookDetail.bookAuthorSummary];
}
@end
