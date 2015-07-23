//
//  MJMovieCommentCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreStarsView.h"
#import "MJReview.h"
@interface MJMovieCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel* timeLabel;
@property (weak, nonatomic) IBOutlet UILabel* commentLabel;
@property (weak, nonatomic) IBOutlet UILabel* percentUseLabel;
@property (weak, nonatomic) IBOutlet UIImageView* cellImageView;
@property (weak, nonatomic) IBOutlet ScoreStarsView* scoreStarsView;

@property (strong, nonatomic) MJReview* review;

+ (void)registerNibWithTableView:(UITableView*)tableView;
+ (MJMovieCommentCell*)cellWithTableView:(UITableView*)tableView;

@end
