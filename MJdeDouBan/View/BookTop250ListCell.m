//
//  BookTop250ListCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/23.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "BookTop250ListCell.h"
#import "ScoreStarsView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BookTop250ListCell ()

@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* titleEngLabel;
@property (weak, nonatomic) IBOutlet UILabel* subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel* scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel* votecountLabel;
@property (weak, nonatomic) IBOutlet ScoreStarsView* scoreStarsView;

@end

@implementation BookTop250ListCell

+ (BookTop250ListCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookTop250ListCell";
    return [tableView dequeueReusableCellWithIdentifier:ID];
    ;
}

- (void)setBook:(MJBook*)book
{
    _book = book;
    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:book.bookPosterUrl] placeholderImage:nil];
    [self.titleLabel setText:book.bookTitle];
    [self.titleEngLabel setText:book.bookTitleEng];
    [self.subTitleLabel setText:book.bookSubTitle];

    NSString* score = book.bookScore;
    self.scoreStarsView.value = [score floatValue] / 10;
    [self.scoreLabel setText:score];
    [self.votecountLabel setText:[NSString stringWithFormat:@"(%@人评价)", book.bookVoteCount]];
}

@end
