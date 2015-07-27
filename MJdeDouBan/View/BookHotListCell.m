//
//  BookHotListCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/24.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "BookHotListCell.h"
#import "ScoreStarsView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BookHotListCell ()

@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* rankingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel* subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel* scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel* votecountLabel;
@property (weak, nonatomic) IBOutlet ScoreStarsView* scoreStarsView;

@end

@implementation BookHotListCell

+ (BookHotListCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookHotListCell";
    return [tableView dequeueReusableCellWithIdentifier:ID];
    ;
}

- (void)setBook:(MJBook*)book
{
    _book = book;

    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:book.bookPosterUrl] placeholderImage:nil];
    [self.titleLabel setText:book.bookTitle];
    [self.subTitleLabel setText:book.bookSubTitle];
    [self.rankingTimeLabel setText:book.bookRankingTime];

    NSString* score = book.bookScore;
    self.scoreStarsView.value = [score floatValue] / 10;
    [self.scoreLabel setText:score];
    [self.votecountLabel setText:book.bookVoteCount];
}
@end
