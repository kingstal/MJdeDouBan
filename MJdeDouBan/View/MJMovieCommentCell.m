//
//  MJMovieCommentCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieCommentCell.h"
#import "MMPlaceHolder.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MJMovieCommentCell

+ (void)registerNibWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"MJMovieCommentCell";
    UINib* commentNib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:commentNib forCellReuseIdentifier:ID];
}

+ (MJMovieCommentCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"MJMovieCommentCell";
    MJMovieCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

- (void)awakeFromNib
{
    [self showPlaceHolderWithLineColor:[UIColor redColor]];
    // Initialization code
    self.cellImageView.layer.cornerRadius = self.cellImageView.frame.size.width / 2;
    self.cellImageView.layer.masksToBounds = YES;
}

- (void)setReview:(MJReview*)review
{
    _review = review;
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:[review avatarUrl]]];
    self.titleLabel.text = review.title;
    self.usernameLabel.text = review.username;
    self.timeLabel.text = review.commnetTime;
    self.scoreStarsView.value = [review.score floatValue] / 5;
    self.commentLabel.text = review.content;
    self.percentUseLabel.text = [NSString stringWithFormat:@"%@有用", review.percentUse];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
