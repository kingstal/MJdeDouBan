//
//  BookDetailFirstCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/26.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "BookDetailFirstCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BookDetailFirstCell ()

@property (nonatomic, weak) IBOutlet UIImageView* posterImageView;
@property (nonatomic, weak) IBOutlet UILabel* titleLabel;
@property (nonatomic, weak) IBOutlet ScoreStarsView* scoreStarView;
@property (nonatomic, weak) IBOutlet UILabel* scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel* voteCountLabel;
@property (nonatomic, weak) IBOutlet UILabel* authorLabel;
@property (nonatomic, weak) IBOutlet UILabel* publishLabel;

@end

@implementation BookDetailFirstCell

+ (void)registerNibWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookDetailFirstCell";
    UINib* directorNib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:directorNib forCellReuseIdentifier:ID];
}

+ (BookDetailFirstCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"BookDetailFirstCell";
    BookDetailFirstCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

- (void)setBookDetail:(MJBookDetail*)bookDetail
{
    _bookDetail = bookDetail;
    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:bookDetail.bookPosterUrl]];
    [self.titleLabel setText:bookDetail.bookTitle];
    NSString* score = bookDetail.bookScore;
    self.scoreStarView.value = [score floatValue] / 10;
    [self.scoreLabel setText:score];
    [self.voteCountLabel setText:[NSString stringWithFormat:@"(%@人评价)", self.bookDetail.bookVoteCount]];
    [self.authorLabel setText:bookDetail.bookAuthor];
    [self.publishLabel setText:bookDetail.bookPress];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
