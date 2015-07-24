//
//  BookNewListCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/24.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "BookNewListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BookNewListCell ()

@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel* summaryLabel;

@end

@implementation BookNewListCell

+ (BookNewListCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookNewListCell";
    return [tableView dequeueReusableCellWithIdentifier:ID];
    ;
}

- (void)setBook:(MJBook*)book
{
    _book = book;

    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:book.bookPosterUrl] placeholderImage:nil];
    [self.titleLabel setText:book.bookTitle];
    [self.subTitleLabel setText:book.bookSubTitle];
    [self.summaryLabel setText:book.bookSummary];
}
@end
