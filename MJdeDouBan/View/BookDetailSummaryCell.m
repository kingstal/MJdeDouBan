//
//  BookDetailSummaryCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/25.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "BookDetailSummaryCell.h"

@interface BookDetailSummaryCell ()
@property (nonatomic, weak) IBOutlet UILabel* bookSummaryLabel;
@end

@implementation BookDetailSummaryCell

+ (void)registerNibWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookDetailSummaryCell";
    UINib* directorNib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:directorNib forCellReuseIdentifier:ID];
}

+ (BookDetailSummaryCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookDetailSummaryCell";
    BookDetailSummaryCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

- (void)setBookDetail:(MJBookDetail*)bookDetail
{
    _bookDetail = bookDetail;
    [self.bookSummaryLabel setText:bookDetail.bookSummary];
}
@end
