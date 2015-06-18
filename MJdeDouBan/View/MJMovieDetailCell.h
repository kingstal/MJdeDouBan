//
//  MJMovieDetailCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreStarsView.h"

@interface MJMovieDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet ScoreStarsView* starRatingView;
@property (weak, nonatomic) IBOutlet UILabel* scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel* voteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel* genresLabel;
@property (weak, nonatomic) IBOutlet UILabel* regionDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel* releaseDateLabel;

+ (MJMovieDetailCell*)movieDetailsCell;

@end
