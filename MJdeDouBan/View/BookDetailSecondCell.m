//
//  BookDetailSecondCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/26.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "BookDetailSecondCell.h"

@interface BookDetailSecondCell ()

@property (nonatomic, weak) IBOutlet UILabel* authorDetailLabel;
@property (nonatomic, weak) IBOutlet UILabel* publishDetailLabel;
@property (nonatomic, weak) IBOutlet UILabel* publishTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel* pageCountLabel;
@property (nonatomic, weak) IBOutlet UILabel* priceLabel;
@property (nonatomic, weak) IBOutlet UILabel* ISBNLabel;

@end

@implementation BookDetailSecondCell

+ (void)registerNibWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookDetailSecondCell";
    UINib* directorNib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:directorNib forCellReuseIdentifier:ID];
}

+ (BookDetailSecondCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookDetailSecondCell";
    BookDetailSecondCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

- (void)setBookDetail:(MJBookDetail*)bookDetail
{
    _bookDetail = bookDetail;
    [self.authorDetailLabel setText:bookDetail.bookAuthor];
    [self.publishDetailLabel setText:bookDetail.bookPress];
    [self.publishTimeLabel setText:bookDetail.bookPublishTime];
    [self.pageCountLabel setText:bookDetail.bookPageCount];
    [self.priceLabel setText:bookDetail.bookPrice];
    [self.ISBNLabel setText:bookDetail.bookISBN];
}

@end
